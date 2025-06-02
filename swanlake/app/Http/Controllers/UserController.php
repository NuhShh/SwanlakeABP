<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Http\Requests\UserRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    // Get all users
    public function getAllUsers()
    {
        $users = User::all();

        return response()->json([
            'message' => 'All users fetched successfully',
            'users' => $users,
        ], 200);
    }

    // Get user by ID
    public function getUserById($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'message' => 'User not found',
            ], 404);
        }

        return response()->json([
            'message' => 'User fetched successfully',
            'user' => $user,
        ], 200);
    }

    // Update user details
    public function updateUser(Request $request, $id) {
    $validated = $request->validate([
        'email' => 'required|email|unique:users,email,' . $id . ',accountID',
        'name' => 'required|min:3|unique:users,name,' . $id . ',accountID',
        'role' => 'required|in:USER,ADMIN',
        'password' => 'nullable|min:6', // Password opsional
    ]);

    $user = User::find($id);
    if (!$user) {
        return response()->json([
            'message' => 'User not found.',
        ], 404);
    }

    // Update data user
    $user->email = $validated['email'];
    $user->name = $validated['name'];
    $user->role = $validated['role'];

    // Update password jika ada
    if ($request->has('password') && !empty($request->password)) {
        $user->password = Hash::make($request->password);
    }

    $user->save();

    return response()->json([
        'message' => 'User updated successfully.',
        'user' => $user,
    ]);
}

    public function deleteUser($id) {
        $user = User::find($id);
        
        if (!$user) {
            return response()->json([
                'message' => 'User not found',
            ], 404);
        }

        $user->delete();

        return response()->json([
            'message' => 'User deleted successfully',
        ], 200);
    }
}