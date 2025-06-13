<?php

namespace App\Http\Controllers;

use App\Models\Review;
use App\Http\Requests\ReviewRequest;
use Illuminate\Http\Request;

class ReviewController extends Controller
{
    // Fetch all reviews
    public function getAllReviews()
    {
        try {
            $reviews = Review::all();
            return response()->json([
                'message' => 'All reviews fetched successfully',
                'reviews' => $reviews,
            ], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to fetch reviews', 'error' => $e->getMessage()], 500);
        }
    }

    // Get single review by ID
    public function getReviewById($id)
    {
        try {
            $review = Review::find($id);
            if (!$review) {
                return response()->json([
                    'message' => 'Review not found',
                ], 404);
            }
            return response()->json([
                'message' => 'Review fetched successfully',
                'review' => $review,
            ], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to fetch review', 'error' => $e->getMessage()], 500);
        }
    }

    // Add a new review
    public function newReview(ReviewRequest $request)
    {
        try {
            $request->validated();

            if ($request->user()->role !== 'ADMIN') {
                return response([
                    'message' => 'Access denied. Only ADMIN can post reviews.',
                ], 403);
            }

            $reviewData = $request->only([
                'productName', 'productType', 'reviewTitle', 'cardDesc', 'processor', 'processorDesc',
                'ram', 'ramDesc', 'storage', 'storageDesc', 'display', 'displayDesc', 'battery', 'batteryDesc',
                'camera', 'cameraDesc', 'price', 'reviewText', 'imageName', 'rating', 'keyFeatures', 'performance',
                'date', 'reviewAccountID'
            ]);

            $review = Review::create($reviewData);
            return response([
                'message' => 'Review created successfully',
                'review' => $review,
            ], 201);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to create review', 'error' => $e->getMessage()], 500);
        }
    }

    // Update a review
    public function updateReview(Request $request, $id)
    {
        try {
            $validated = $request->validate([
                'productName' => 'required|string|unique:reviews,productName,' . $id . ',reviewID',
                'productType' => 'required|string',
                'reviewTitle' => 'required|string',
                'price' => 'nullable|numeric|min:1',
                'reviewText' => 'nullable|string|min:5',
            ]);

            $review = Review::find($id);
            if (!$review) {
                return response()->json(['message' => 'Review not found'], 404);
            }

            $review->update($validated);
            return response()->json(['message' => 'Review updated successfully', 'review' => $review], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to update review', 'error' => $e->getMessage()], 500);
        }
    }

    // Delete a review
    public function deleteReview($id)
    {
        try {
            $review = Review::find($id);
            if (!$review) {
                return response()->json(['message' => 'Review not found'], 404);
            }

            $review->delete();
            return response()->json(['message' => 'Review deleted successfully'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to delete review', 'error' => $e->getMessage()], 500);
        }
    }
}
