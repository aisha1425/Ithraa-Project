<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('username');
            $table->string('email')->unique();
            $table->string('phone')->default('');
            $table->string('businessType')->default('');
            $table->string('image')->default('');
            $table->string('major')->default('');
            $table->string('universityLocation')->default('');
            $table->string('date')->default('');
            $table->string('type')->default('1');
            $table->string('regNumber')->default('');
            $table->string('location')->default('');
            $table->string('contact')->default('');
            $table->string('website')->default('');
            $table->string('regFile')->default('');
            $table->int('status')->default(0);
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->rememberToken();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
