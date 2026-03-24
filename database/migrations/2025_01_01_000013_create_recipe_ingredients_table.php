<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('recipe_ingredients', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('meal_id');
            $table->unsignedBigInteger('ingredient_id');
            $table->float('quantity')->nullable();
            $table->float('total_calo');
            $table->datetime('created_at')->nullable();
            $table->datetime('updated_at')->nullable();
            $table->softDeletes();

            $table->index('meal_id');
            $table->index('ingredient_id');

            $table->foreign('meal_id', 'recipe_ingredients_ibfk_1')
                  ->references('id')->on('meals')
                  ->onDelete('cascade')
                  ->onUpdate('restrict');

            $table->foreign('ingredient_id', 'recipe_ingredients_ibfk_2')
                  ->references('id')->on('ingredients')
                  ->onDelete('cascade')
                  ->onUpdate('restrict');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('recipe_ingredients');
    }
};
