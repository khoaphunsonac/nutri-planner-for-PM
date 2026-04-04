<?php

namespace App\Providers;

use App\Database\Connectors\NeonPostgresConnector;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\URL;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind('db.connector.pgsql', function () {
            return new NeonPostgresConnector();
        });
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Ép chạy HTTPS khi trên Vercel (môi trường production)
        if (env('APP_ENV') === 'production') {
            URL::forceScheme('https');
        }
    }
}
