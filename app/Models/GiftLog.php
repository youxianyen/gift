<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class GiftLog extends Model
{
    // 允许批量赋值的字段，用于创建或更新礼物日志记录时使用
    protected $fillable = [
        'gifter_id', 'recipient_id', 'gift_id', 'number_group',
        'total_cost', 'multiplier', 'room_id'
    ];

    /**
     * 定义礼物日志与赠送者（用户）之间的所属关系
     * 即通过 gifter_id 关联到对应的用户，获取赠送该礼物的用户信息
     */
    public function gifter(): BelongsTo
    {
        return $this->belongsTo(User::class, 'gifter_id');
    }

    /**
     * 定义礼物日志与接收者（用户）之间的所属关系
     * 通过 recipient_id 关联到对应的用户，获取接收该礼物的用户信息
     */
    public function recipient(): BelongsTo
    {
        return $this->belongsTo(User::class, 'recipient_id');
    }

    /**
     * 定义礼物日志与礼物本身的所属关系
     * 通过 gift_id 关联到对应的礼物信息，获取赠送的是哪个礼物
     */
    public function gift(): BelongsTo
    {
        return $this->belongsTo(Gift::class, 'gift_id');
    }

    /**
     * 获取本次礼物赠送的实际收益（考虑倍数情况）
     */
    public function getActualProfitAttribute()
    {
        return $this->multiplier * $this->gift->unit_coin * $this->number_group;
    }
}