<?php

namespace App\Http\Controllers;

use App\Models\Review;
use App\Http\Requests\ReviewRequest;
use Illuminate\Http\Request;

class ReviewController extends Controller
{

    public function getAllReviews()
    {
        $reviews = Review::all();

        return response()->json([
            'message' => 'All reviews fetched successfully',
            'reviews' => $reviews,
        ], 200);
    }

    public function getReviewById($id)
    {
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
    }

    public function newReview(ReviewRequest $request)
    {
        $request->validated();

        if ($request->user()->role !== 'ADMIN') {
            return response([
                'message' => 'Access denied. Only ADMIN can post reviews.',
            ], 403);
        }

        $reviewData = [
            'productName' => $request->productName,
            'productType' => $request->productType,
            'reviewTitle' => $request->reviewTitle,
            'cardDesc' => $request->cardDesc,
            'processor' => $request->processor,
            'processorDesc' => $request->processorDesc,
            'ram' => $request->ram,
            'ramDesc' => $request->ramDesc,
            'storage' => $request->storage,
            'storageDesc' => $request->storageDesc,
            'display' => $request->display,
            'displayDesc' => $request->displayDesc,
            'battery' => $request->battery,
            'batteryDesc' => $request->batteryDesc,
            'camera' => $request->camera,
            'cameraDesc' => $request->cameraDesc,
            'price' => $request->price,
            'reviewText' => $request->reviewText,
            'imageName' => $request->imageName,
            'rating' => $request->rating,
            'keyFeatures' => $request->keyFeatures,
            'performance' => $request->performance,
            'date' => $request->date,
            'reviewAccountID' => $request->reviewAccountID,
        ];

        $review = Review::create($reviewData);

        return response([
            'message' => 'Review created successfully',
            'review' => $review,
        ], 201);
    }

    public function getSmartphoneReviews() {
        $reviews = Review::where('productType', 'Smartphone')->get();

        return response()->json([
            'reviews' => $reviews
        ]);
    }

    public function getConsoleReviews() {
        $reviews = Review::where('productType', 'Console')->get();

        return response()->json([
            'reviews' => $reviews
        ]);
    }

    public function getAccessoriesReviews() {
        $reviews = Review::where('productType', 'Accessories')->get();

        return response()->json([
            'reviews' => $reviews
        ]);
    }

    public function getDesktopLaptopReviews() {
        $reviews = Review::where('productType', 'Desktop & Laptop')->get();

        return response()->json([
            'reviews' => $reviews
        ]);
    }

    public function updateReview(Request $request, $id){
        $validated = $request->validate([
            'productName' => 'required|string|unique:reviews,productName,' . $id . ',reviewID',
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
        ]);

        $review = Review::find($id); 
        if (!$review) {
            return response()->json([
                'message' => 'Review not found',
            ], 404);
        }

        $review->productName = $validated['productName'];
        $review->productType = $validated['productType'];
        $review->reviewTitle = $validated['reviewTitle'];
        $review->cardDesc = $validated['cardDesc'] ?? null;
        $review->processor = $validated['processor'] ?? null;
        $review->processorDesc = $validated['processorDesc'] ?? null;
        $review->ram = $validated['ram'] ?? null;
        $review->ramDesc = $validated['ramDesc'] ?? null;
        $review->storage = $validated['storage'] ?? null;
        $review->storageDesc = $validated['storageDesc'] ?? null;
        $review->display = $validated['display'] ?? null;
        $review->displayDesc = $validated['displayDesc'] ?? null;
        $review->battery = $validated['battery'] ?? null;
        $review->batteryDesc = $validated['batteryDesc'] ?? null;
        $review->camera = $validated['camera'] ?? null;
        $review->cameraDesc = $validated['cameraDesc'] ?? null;
        $review->price = $validated['price'] ?? null;
        $review->reviewText = $validated['reviewText'] ?? null;
        $review->imageName = $validated['imageName'] ?? null;
        $review->rating = $validated['rating'] ?? null;
        $review->keyFeatures = $validated['keyFeatures'] ?? null;
        $review->performance = $validated['performance'] ?? null;
        $review->date = $validated['date'] ?? null;
        $review->reviewAccountID = $validated['reviewAccountID'] ?? null;

        $review->save();

        return response()->json([
            'message' => 'Review updated successfully',
            'review' => $review,
        ]);
    }

    // Delete Review
public function deleteReview($id) {
        $review = Review::find($id);
        
        if (!$review) {
            return response()->json([
                'message' => 'Review not found',
            ], 404);
        }

        $review->delete();

        return response()->json([
            'message' => 'Review deleted successfully',
        ], 200);
    }

}
