<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UserRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        // Set to true to authorize all users, otherwise check role or other authorization logic
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'email' => 'required|email|unique:users,email,' . $this->route('id'),
            'name' => 'required|min:3|unique:users,name,' . $this->route('id'),
            'role' => 'required|in:USER,ADMIN',
            'password' => 'nullable|min:6', // Password opsional
        ];
    }
}
