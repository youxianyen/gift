<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TestController extends Controller
{
    
    /**
     * 简单的测试方法，返回JSON响应
     */
    public function testOutput(Request $request)
    {
        return response()->json([
            'status' => 'success',
            'message' => '测试输出成功',
            'data' => [
                'input' => $request->all(),
                'timestamp' => now()->toDateTimeString()
            ]
        ]);
    }
    
}
