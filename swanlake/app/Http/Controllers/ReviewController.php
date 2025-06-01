<?php

namespace App\Http\Controllers;

use App\Models\Review;
use App\Http\Requests\ReviewRequest;
use Illuminate\Http\Request;

class ReviewController extends Controller
{

    public function getAllReview()
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
}
