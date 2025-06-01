<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthenticationController;
use App\Http\Controllers\ReviewController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/test', function () {
    return response([
        'message' => 'Hello, this is a test response from the API!'
    ]);
});

Route::post('register', [AuthenticationController::class, 'register']);
Route::post('login', [AuthenticationController::class, 'login']);
Route::post('/post/review', [ReviewController::class, 'newReview']) ->middleware('auth:sanctum');
Route::get('/get/review', [ReviewController::class, 'getAllReview']) ->middleware('auth:sanctum');
Route::get('/get/review/smartphone', [ReviewController::class, 'getSmartphoneReviews'])->middleware('auth:sanctum');
Route::get('/get/review/console', [ReviewController::class, 'getConsoleReviews'])->middleware('auth:sanctum');
Route::get('/get/review/accessories', [ReviewController::class, 'getAccessoriesReviews'])->middleware('auth:sanctum');
Route::get('/get/review/desktoplaptop', [ReviewController::class, 'getDesktopLaptopReviews'])->middleware('auth:sanctum');
Route::get('/get/review/{id}', [ReviewController::class, 'getReviewById'])->middleware('auth:sanctum');
