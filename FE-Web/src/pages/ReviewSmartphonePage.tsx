import React, { useEffect, useState } from "react";
import axios from "axios";
import { Link } from "react-router-dom";

interface Review {
  reviewID: string;
  productName: string;
  productType: string;
  reviewTitle: string;
  cardDesc: string;
  processor: string;
  processorDesc: string;
  ram: string;
  ramDesc: string;
  storage: string;
  storageDesc: string;
  display: string;
  displayDesc: string;
  battery: string;
  batteryDesc: string;
  camera: string;
  cameraDesc: string;
  price: number;
  reviewText: string;
  imageName: string;
  rating: number;
  keyFeatures: string;
  performance: string;
}

export default function UserList() {
  const [reviews, setReviews] = useState<Review[]>([]);

  useEffect(() => {
    loadAccounts();
  }, []);

  const loadAccounts = async () => {
    const result = await axios.get("http://localhost:8080/get/review");
    setReviews(result.data);
  };

  return (
    <div className="container mx-auto p-6">
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {reviews.map((review, index) => (
          <div
            key={index}
            className="border border-gray-300 rounded-lg shadow-lg overflow-hidden transition-transform transform hover:scale-105"
          >
            {/* Image */}
            <div className="relative">
              <img
                src={`/images/${review.imageName}`}
                alt={review.productName}
                className="w-full h-48 object-cover"
              />
            </div>

            {/* Card Content */}
            <div className="p-6">
              <h3 className="text-xl font-semibold text-gray-800 mb-2">
                {review.reviewTitle}
              </h3>
              <p className="text-sm text-gray-600 mb-4">
                <strong>Nama Produk:</strong> {review.productName}
              </p>
              <p className="text-sm text-gray-600 mb-4">
                <strong>Deskripsi:</strong> {review.cardDesc}
              </p>
              <p className="text-sm text-gray-500 mb-4">
                <strong>Review ID:</strong> {review.reviewID}
              </p>
              <Link
                to={`/product-review/${review.reviewID}`}
                className="inline-block px-4 py-2 text-sm font-semibold text-white bg-blue-600 hover:bg-blue-700 rounded-lg transition duration-300"
              >
                Read More...
              </Link>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
