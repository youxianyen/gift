<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Gift extends Model
{
    // 允许批量赋值的字段，这些字段可以通过 create 或 update 方法进行批量赋值
    protected $fillable = ['name', 'price', 'unit_coin', 'image', 'status'];

    /**
     * 定义礼物与礼物日志之间的一对多关联关系
     * 一个礼物可以有多个与之相关的礼物日志记录（表示多次赠送该礼物的情况）
     */
    public function giftLogs()
    {
        return $this->hasMany(GiftLog::class, 'gift_id');
    }

    /**
     * 获取礼物的平均收益（基于单位收益和所有赠送记录的倍数情况计算）
     * 这里只是一个示例方法，可根据实际业务需求调整计算逻辑
     */
    public function getAverageProfitAttribute()
    {
        $totalProfit = $this->giftLogs()->sum(function ($log) {
            return $log->multiplier * $this->unit_coin;
        });

        return $this->giftLogs()->count() > 0? $totalProfit / $this->giftLogs()->count() : 0;
    }
}