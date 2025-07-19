<?php
namespace Modules\Gift\Models;

use Illuminate\Database\Eloquent\Model;

class Gift extends Model
{
    protected $table = 'gift';
    
    public function unit_price()
    {
        // 直接使用命名空间，不依赖 use 语句
        return $this->hasOne('Modules\Gift\Models\GiftUnitPrice', 'gift_id', 'id');
    }
}