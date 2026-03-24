<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('meal_allergens', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('meal_id');
            $table->unsignedBigInteger('allergen_id');
            $table->datetime('created_at')->nullable();
            $table->datetime('updated_at')->nullable();
            $table->softDeletes();

            $table->index('meal_id');
            $table->index('allergen_id');

            $table->foreign('meal_id', 'meal_allergens_ibfk_1')
                  ->references('id')->on('meals')
                  ->onDelete('cascade')
                  ->onUpdate('restrict');

            $table->foreign('allergen_id', 'meal_allergens_ibfk_2')
                  ->references('id')->on('allergens')
                  ->onDelete('cascade')
                  ->onUpdate('restrict');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('meal_allergens');
    }
};
