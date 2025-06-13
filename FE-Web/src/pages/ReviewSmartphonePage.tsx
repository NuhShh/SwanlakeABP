import React, { useEffect, useState } from "react";
import axios from "axios";
import { useParams } from "react-router-dom";
import { Flame, TrendingUp } from "lucide-react"; // Anda bisa menyesuaikan ikon sesuai kebutuhan
import ReviewCard from "../components/ReviewCard"; // pastikan komponen ini ada di folder components

interface Review {
  reviewID: string;
  productName: string;
  reviewTitle: string;
  cardDesc: string;
  productType: string;
  price: number;
  imageName: string;
  rating: number;
  reviewText: string;
}

export default function ReviewSmartphonePage() {
  const { reviewID } = useParams<{ reviewID: string }>(); // Ambil reviewID dari URL params
  const [review, setReview] = useState<Review | null>(null);
  const [error, setError] = useState<string>("");

  useEffect(() => {
    loadReview();
  }, [reviewID]);

  const loadReview = async () => {
    try {
      const response = await axios.get(
        `http://localhost:8080/get/review/${reviewID}`
      );
      setReview(response.data);
    } catch (error) {
      console.error("Error fetching review:", error);
      setError("An error occurred while fetching the review.");
    }
  };

  if (error) {
    return (
      <div className="min-h-screen bg-gray-100 text-center py-10">
        <h2 className="text-xl text-red-600">{error}</h2>
      </div>
    );
  }

  if (!review) {
    return (
      <div className="min-h-screen bg-gray-100 text-center py-10">
        <h2 className="text-xl text-gray-600">Loading...</h2>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-100 py-10">
      <div className="max-w-7xl mx-auto px-4">
        {/* Header Section */}
        <div className="mb-6 text-center">
          <Flame className="w-6 h-6 text-orange-500 inline-block mb-2" />
          <h2 className="text-3xl font-semibold text-gray-800">
            {review.productName} Review
          </h2>
          <p className="text-sm text-gray-600">{review.productType}</p>
        </div>

        {/* Review Section */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div className="col-span-1">
            <img
              src={`/images/${review.imageName}`}
              alt={review.productName}
              className="w-full h-64 object-cover rounded-lg"
            />
          </div>

          <div className="col-span-1">
            <div className="p-6 bg-white rounded-lg shadow-lg">
              <h3 className="text-xl font-semibold text-gray-800 mb-4">
                {review.reviewTitle}
              </h3>
              <p className="text-sm text-gray-600 mb-4">
                <strong>Price: </strong>${review.price}
              </p>
              <p className="text-sm text-gray-600 mb-4">
                <strong>Description: </strong>{review.cardDesc}
              </p>
              <p className="text-sm text-gray-500 mb-4">
                <strong>Review:</strong> {review.reviewText}
              </p>

              {/* Add Rating / Other Info */}
              <div className="flex items-center">
                <span className="text-sm font-semibold text-gray-800">
                  Rating: {review.rating}
                </span>
                <TrendingUp className="w-5 h-5 text-blue-500 ml-2" />
              </div>
            </div>
          </div>
        </div>

        {/* Additional Reviews Section */}
        <div className="mt-12">
          <h3 className="text-2xl font-semibold text-gray-800 mb-4">
            Related Smartphone Reviews
          </h3>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {/* Add mapping to display related reviews */}
            {/* You can use similar logic for fetching and mapping related reviews */}
          </div>
        </div>
      </div>
    </div>
  );
}
