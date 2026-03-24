<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('accounts', function (Blueprint $table) {
            $table->id();
            $table->string('username', 100);
            $table->string('email', 150)->unique('unique_email');
            $table->string('password', 255);
            $table->string('remember_token', 255)->nullable();
            $table->enum('role', ['user', 'admin'])->default('user');
            $table->string('status', 20)->default('active')->comment('khoá tài khoản user');
            $table->string('note', 255)->nullable()->comment('lý do bị khoá bên user');
            $table->text('savemeal')->nullable();
            $table->datetime('created_at')->nullable()->useCurrent();
            $table->datetime('updated_at');
            $table->softDeletes();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('accounts');
    }
};
