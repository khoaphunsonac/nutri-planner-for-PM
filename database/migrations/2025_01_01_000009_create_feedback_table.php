<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('feedback', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('account_id')->nullable();
            $table->integer('rating')->nullable();
            $table->text('comment')->nullable();
            $table->datetime('created_at')->nullable()->useCurrent();
            $table->datetime('updated_at')->nullable();
            $table->softDeletes();

            $table->index('account_id', 'feedback_ibfk_1');

            $table->foreign('account_id', 'feedback_ibfk_1')
                  ->references('id')->on('accounts')
                  ->onDelete('cascade')
                  ->onUpdate('restrict');
        });

        DB::statement('ALTER TABLE feedback ADD CONSTRAINT feedback_chk_1 CHECK (rating >= 1 AND rating <= 5)');
    }

    public function down(): void
    {
        Schema::dropIfExists('feedback');
    }
};
