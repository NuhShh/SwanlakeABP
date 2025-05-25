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
        Schema::create('reviews', function (Blueprint $table) {
            $table->id('reviewID');
            $table->string('productName')->unique();
            $table->string('productType');
            $table->string('reviewTitle');
            $table->string('cardDesc')->nullable();
            $table->string('processor')->nullable();
            $table->string('processorDesc')->nullable();
            $table->string('ram')->nullable();
            $table->string('ramDesc')->nullable();
            $table->string('storage')->nullable();
            $table->string('storageDesc')->nullable();
            $table->string('display')->nullable();
            $table->string('displayDesc')->nullable();
            $table->string('battery')->nullable();
            $table->string('batteryDesc')->nullable();
            $table->string('camera')->nullable();
            $table->string('cameraDesc')->nullable();
            $table->integer('price')->nullable();
            $table->text('reviewText')->nullable();
            $table->text('imageName')->nullable();
            $table->float('rating')->nullable();
            $table->text('keyFeatures')->nullable();
            $table->text('performance')->nullable();
            $table->date('date')->nullable();
            $table->unsignedBigInteger('reviewAccountID')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reviews');
    }
};
