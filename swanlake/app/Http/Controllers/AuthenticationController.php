<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use App\Http\Requests\RegisterRequest; // Pastikan Anda import RegisterRequest

class AuthenticationController extends Controller
{
    // Metode untuk registrasi
    public function register(RegisterRequest $request)
    {
        // Menambahkan log untuk melihat data yang dikirimkan
        Log::info('Register Request Data: ', $request->all());

        try {
            // Validasi input
            $request->validated();

            // Jika email atau nama sudah ada, Laravel sudah menangani validasi ini secara otomatis

            // Buat user baru
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'role' => $request->role,
            ]);

            // Membuat token untuk autentikasi
            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'user' => $user,
                'token' => $token,
            ], 201);

        } catch (\Exception $e) {
            // Log error jika ada masalah
            Log::error('Registration failed: ' . $e->getMessage());
            return response()->json([
                'message' => 'Registration failed: ' . $e->getMessage(),
            ], 500);
        }
    }

    // Metode untuk login
    public function login(Request $request)
    {
        // Validasi input login
        $validated = $request->validate([
            'email' => 'required|email',
            'password' => 'required|min:6',
        ]);

        // Mencari user berdasarkan email
        $user = User::whereEmail($request->email)->first();

        // Jika user tidak ditemukan atau password salah
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'message' => 'Invalid credentials',
            ], 422); // Mengembalikan error jika credentials salah
        }

        // Membuat token untuk user jika berhasil login
        $token = $user->createToken('auth_token')->plainTextToken;

        // Mengembalikan user dan token
        return response()->json([
            'user' => $user,
            'token' => $token,
        ], 200);
    }
}
