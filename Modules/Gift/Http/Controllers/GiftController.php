<?php

namespace Modules\Gift\Http\Controllers;

use App\Http\Constants\ApiStatus;
use App\Http\Helpers\RedisHelper;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Modules\Gift\Http\Repositories\GiftRepository;
use Modules\Gift\Models\Gift;
use Modules\Gift\Models\GiftUnitPrice; 
use Modules\Gift\Models\User;
use Throwable;


class GiftController extends Controller
{
    /**
     * 赠送幸运礼物(按组赠送礼物)
     * User:ytx
     * DateTime:2023/2/24 15:33
     */
    public function giveGroupGift(Request $request): JsonResponse
    {
        // 参数验证
       
        $rawContent = $request->getContent();
        $data = json_decode($rawContent, true);
        
        // 3. 检查解析是否成功（处理 JSON 格式错误）
        if (json_last_error() !== JSON_ERROR_NONE) {
            Log::error('JSON 解析失败', [
                'raw_content' => $rawContent,
                'error' => json_last_error_msg()
            ]);
            return responseError([0, '请求数据格式错误，请检查 JSON 格式']);
        }
        
        
        $uid = $data['uid'] ?? 0;
        $to_uid = isset($data['to_uid']) ? array_filter(explode(',', $data['to_uid'])) : [];
        $gift_id = $data['gift_id'] ?? 0;
        $scene = $data['scene'] ?? '';
        $scene_id = (int)($data['scene_id'] ?? 0);
        $number_group = (int)($data['number_group'] ?? 1);
        
        if (in_array($uid, $to_uid)) {
            return responseError([0, '不能送给自己']);
        }

        try {
            
            // 检查是否自己给自己送礼物
            if (in_array($uid, $to_uid)) {
                return responseError([0, '不能送给自己']);
            }
            
            
            
            // 获取礼物信息（带缓存）
            $giftInfo = $this->getGiftInfoWithCache($gift_id);
            if (empty($giftInfo)) {
                return responseError([0, '所选礼物不存在，无法赠送']);
            }

            # 礼物接收者人数
            $to_uid_num = count($to_uid);

            # 礼物单价（单价*倍数=返现的币数）
            $giftUnitCoin = $giftInfo['unit_price']['coin'];
            
            # 礼物所需总价值
            $giftTotalNeedCoin = bcmul($giftInfo['coin'], $number_group * $to_uid_num, 8);
            
            # 每个人收到的礼物价值
            $eachUserGiftCoin = bcmul($giftInfo['coin'], $number_group, 8);
            
            # 校验用户币余额是否充足
            $userCoinBalance = User::query()->where(['id' => $uid])->value('coin');
            if ($userCoinBalance < $giftTotalNeedCoin) {
                return responseError(ApiStatus::PLATFORM_COIN_INSUFFICIENT);
            }

            // 开启数据库事务
            DB::beginTransaction();

            try {
                foreach ($to_uid as $v) {
                    # 赠送礼物
                    GiftRepository::Factory()->doGiveGroupGift(
                        $uid, $v, $giftInfo, $scene, $scene_id, 
                        $number_group, $eachUserGiftCoin, $giftUnitCoin
                    );
                }

                // 提交事务
                DB::commit();
                
                return responseSuccess();
            } catch (Throwable $e) {
                // 回滚事务
                DB::rollBack();
                
                // 记录详细错误日志
                Log::error('礼物赠送失败', [
                    'uid' => $uid,
                    'to_uid' => $to_uid,
                    'gift_id' => $gift_id,
                    'scene' => $scene,
                    'scene_id' => $scene_id,
                    'number_group' => $number_group,
                    'error' => $e->getMessage(),
                    'trace' => $e->getTraceAsString()
                ]);
                
                return responseError([0, '礼物赠送失败，请稍后再试']);
            }
        } catch (Throwable $e) {
            // 记录系统级错误
            Log::critical('礼物赠送系统错误', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            return responseError([0, '系统繁忙，请稍后再试']);
        }
    }
    
    /**
     * 获取礼物信息（带缓存）
     */
    private function getGiftInfoWithCache($gift_id)
    {
        $giftkey = 'luckgift' . $gift_id;
        
        try {
            // 尝试从Redis获取
            $giftRedis = RedisHelper::get($giftkey);
            
            if ($giftRedis) {
                return json_decode($giftRedis, true);
            }
        } catch (Throwable $e) {
            // 缓存获取失败，记录日志但继续执行
            Log::warning('获取礼物缓存失败', [
                'gift_id' => $gift_id,
                'error' => $e->getMessage()
            ]);
        }
        
        // 从数据库获取
        $giftInfo = Gift::query()
            ->where(['id' => $gift_id, 'status' => 0])
            ->with('unit_price')
            ->first();
        echo '<pre>';
        print_r($giftInfo);
        die;
        if ($giftInfo) {
            try {
                // 存入Redis缓存（设置合理的过期时间，例如1小时）
                RedisHelper::setex($giftkey, 3600, json_encode($giftInfo->toArray()));
            } catch (Throwable $e) {
                // 缓存设置失败，记录日志但不影响业务流程
                Log::warning('设置礼物缓存失败', [
                    'gift_id' => $gift_id,
                    'error' => $e->getMessage()
                ]);
            }
            
            return $giftInfo->toArray();
        }
        
        return null;
    }
    
    /**
     * SVGA 播放器页面
     */
    public function svgaPlay()
    {
        $svgaUrl = 'your_svga_url'; // 替换为实际的 SVGA 文件 URL
        return view('gift::svgaPlay', compact('svgaUrl'));
    }
}