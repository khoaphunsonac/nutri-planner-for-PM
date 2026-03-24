<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('meals_tags', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('meal_id');
            $table->unsignedBigInteger('tag_id');
            $table->datetime('created_at')->nullable();
            $table->datetime('updated_at')->nullable();
            $table->softDeletes();

            $table->index('meal_id');
            $table->index('tag_id');

            $table->foreign('meal_id', 'meal_id')
                  ->references('id')->on('meals')
                  ->onDelete('restrict')
                  ->onUpdate('restrict');

            $table->foreign('tag_id', 'tag_id')
                  ->references('id')->on('tags')
                  ->onDelete('restrict')
                  ->onUpdate('restrict');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('meals_tags');
    }
};
