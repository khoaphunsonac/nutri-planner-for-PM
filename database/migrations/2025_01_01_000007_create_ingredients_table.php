<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ingredients', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100);
            $table->string('unit', 20)->nullable();
            $table->float('protein')->nullable()->comment('g/100g của ingredients');
            $table->float('carb')->nullable()->comment('g/100g của ingredients');
            $table->float('fat')->nullable()->comment('g/100g của ingredients');
            $table->datetime('created_at')->nullable();
            $table->datetime('updated_at')->nullable();
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ingredients');
    }
};
