<?php

namespace Modules\Gift\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class UserRoom extends Model
{
    // 允许批量赋值的字段，可用于更新或创建用户房间相关记录
    protected $fillable = ['user_id', 'room_id', 'charm', 'consumption', 'level'];

    /**
     * 定义用户房间记录与用户之间的所属关系
     * 通过 user_id 关联到对应的用户，获取该房间记录所属的用户信息
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    /**
     * 定义用户房间记录与房间之间的所属关系
     * 通过 room_id 关联到对应的房间，获取该用户所在的房间信息
     */
    public function room(): BelongsTo
    {
        return $this->belongsTo(Room::class, 'room_id');
    }

    /**
     * 定义用户在该房间的礼物日志记录（一对多关系）
     * 可以获取该用户在这个房间内所有的礼物赠送和接收记录
     */
    public function giftLogs(): HasMany
    {
        return $this->hasMany(GiftLog::class, 'room_id');
    }

    /**
     * 根据礼物日志更新用户在房间内的魅力值、消费金额和等级
     * 这里是一个简单的示例逻辑，实际业务中可根据具体规则调整
     */
    public function updateStatsFromGiftLogs()
    {
        $giftLogs = $this->giftLogs;

        $this->charm += $giftLogs->sum(function ($log) {
            return $log->total_cost;
        });

        $this->consumption += $giftLogs->sum(function ($log) {
            return $log->total_cost;
        });

        // 根据消费金额等因素计算等级，这里只是简单示例，可按实际需求完善
        $this->level = (int) floor(sqrt($this->consumption / 100)) + 1;

        $this->save();
    }
}