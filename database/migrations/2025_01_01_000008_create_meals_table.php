<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('meals', function (Blueprint $table) {
            $table->id();
            $table->string('name', 150);
            $table->unsignedBigInteger('diet_type_id')->nullable();
            $table->unsignedBigInteger('meal_type_id')->nullable();
            $table->text('preparation')->nullable();
            $table->string('image_url', 255)->nullable();
            $table->text('description')->nullable();
            $table->datetime('created_at');
            $table->datetime('updated_at')->nullable();
            $table->softDeletes();

            $table->index('diet_type_id');
            $table->index('meal_type_id');

            $table->foreign('diet_type_id')
                  ->references('id')->on('diet_type')
                  ->onDelete('restrict')
                  ->onUpdate('restrict');

            $table->foreign('meal_type_id')
                  ->references('id')->on('meal_type')
                  ->onDelete('restrict')
                  ->onUpdate('restrict');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('meals');
    }
};
