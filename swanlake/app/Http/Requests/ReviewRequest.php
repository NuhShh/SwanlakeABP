<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ReviewRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
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
            'productName' => 'required|string|unique:reviews,productName',
            'productType' => 'required|string',
            'reviewTitle' => 'required|string',
            'cardDesc' => 'nullable|string',
            'processor' => 'nullable|string',
            'processorDesc' => 'nullable|string',
            'ram' => 'nullable|string',
            'ramDesc' => 'nullable|string',
            'storage' => 'nullable|string',
            'storageDesc' => 'nullable|string',
            'display' => 'nullable|string',
            'displayDesc' => 'nullable|string',
            'battery' => 'nullable|string',
            'batteryDesc' => 'nullable|string',
            'camera' => 'nullable|string',
            'cameraDesc' => 'nullable|string',
            'price' => 'nullable|integer',
            'reviewText' => 'nullable|string',
            'imageName' => 'nullable|string',
            'rating' => 'nullable|numeric',
            'keyFeatures' => 'nullable|string',
            'performance' => 'nullable|string',
            'date' => 'nullable|date',
            'reviewAccountID' => 'nullable|exists:users,accountID',
        ];
    }
}
