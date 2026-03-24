<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('user_allergens', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('account_id');
            $table->unsignedBigInteger('meal_id');
            $table->datetime('created_at')->nullable();
            $table->datetime('updated_at')->nullable();
            $table->softDeletes();

            $table->index('account_id');
            $table->index('meal_id');

            $table->foreign('account_id', 'user_allergens_ibfk_1')
                  ->references('id')->on('accounts')
                  ->onDelete('restrict')
                  ->onUpdate('restrict');

            $table->foreign('meal_id', 'user_allergens_ibfk_2')
                  ->references('id')->on('meals')
                  ->onDelete('restrict')
                  ->onUpdate('restrict');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('user_allergens');
    }
};
