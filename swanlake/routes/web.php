<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\ProfileController;

// // Halaman Login
// Route::get('/login', [AuthController::class, 'showLoginForm'])->name('login');
// Route::post('/login', [AuthController::class, 'login']);

// // Halaman Dashboard (harus login)
// Route::middleware('auth')->get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');

// // Halaman Profile (harus login)
// Route::middleware('auth')->get('/profile', [ProfileController::class, 'show'])->name('profile');

// // Rute Registrasi (jika dibutuhkan)
// Route::get('/register', [AuthController::class, 'showRegistrationForm'])->name('register');
// Route::post('/register', [AuthController::class, 'register']);

