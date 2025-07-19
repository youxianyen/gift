<?php

namespace Modules\Gift\Providers;

use Illuminate\Support\Facades\Route;
use Illuminate\Foundation\Support\Providers\RouteServiceProvider as ServiceProvider;

class RouteServiceProvider extends ServiceProvider
{
    /**
     * The module namespace to assume when generating URLs to actions.
     */
    protected $namespace = 'Modules\Gift\Http\Controllers';

    /**
     * Called before routes are registered.
     */
    public function boot()
    {
        parent::boot();
    }

    /**
     * Define the routes for the application.
     */
    public function map()
    {
        $this->mapApiRoutes();
        $this->mapWebRoutes();
    }

    /**
     * Define the "web" routes for the application.
     */
    protected function mapWebRoutes()
    {
        Route::middleware('web')
             ->namespace($this->namespace)
             ->group(module_path('Gift', 'Routes/web.php'));
    }

    /**
     * Define the "api" routes for the application.
     */
    protected function mapApiRoutes()
    {
        Route::prefix('api')
             ->middleware('api')
             ->namespace($this->namespace)
             ->group(module_path('Gift', 'Routes/api.php'));
    }
}
