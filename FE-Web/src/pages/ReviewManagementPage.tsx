import React, { useEffect, useState } from "react";
import axios from "axios";
import { Link, useNavigate } from "react-router-dom";
import { Edit3, Trash2, Eye, PlusCircle, ArrowLeft } from "lucide-react";

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
  const navigate = useNavigate();

  useEffect(() => {
    loadAccounts();
  }, []);

  const loadAccounts = async () => {
    const result = await axios.get("http://localhost:8080/get/review");
    setReviews(result.data);
  };

  const handleEdit = (reviewID: string) => {
    navigate(`/update-review/${reviewID}`);
  };

  const handleDelete = async (reviewID: string) => {
    if (window.confirm("Are you sure you want to delete this review?")) {
      await axios.delete(`http://localhost:8080/delete/review/${reviewID}`);
      setReviews(reviews.filter((review) => review.reviewID !== reviewID));
    }
  };

  const handleAddReview = () => {
    navigate("/add-review");
  };

  const handleBack = () => {
    navigate("/admin-dashboard");
  };

  return (
    <div className="container mx-auto p-6">
      {/* Buttons */}
      <div className="flex justify-end items-center space-x-4 mb-4">
        <button
          onClick={handleBack}
          className="flex items-center bg-gray-500 text-white px-4 py-2 rounded-lg hover:bg-gray-600 focus:outline-none focus:ring focus:ring-gray-300"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back
        </button>
        <button
          onClick={handleAddReview}
          className="flex items-center bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 focus:outline-none focus:ring focus:ring-blue-300"
        >
          <PlusCircle className="w-5 h-5 mr-2" />
          Add Review
        </button>
      </div>

      {/* Table */}
      <table className="min-w-full border-collapse border border-gray-300 dark:text-white">
        <thead>
          <tr>
            <th className="border border-gray-300 px-4 py-2">Id</th>
            <th className="border border-gray-300 px-4 py-2">Review Title</th>
            <th className="border border-gray-300 px-4 py-2">Product Name</th>
            <th className="border border-gray-300 px-4 py-2">Actions</th>
          </tr>
        </thead>
        <tbody>
          {reviews.map((review, index) => (
            <tr key={review.reviewID}>
              <td className="border border-gray-300 px-4 py-2 text-center">
                {review.reviewID}
              </td>
              <td className="border border-gray-300 px-4 py-2">
                {review.reviewTitle}
              </td>
              <td className="border border-gray-300 px-4 py-2">
                {review.productName}
              </td>
              <td className="border border-gray-300 px-4 py-2 text-center">
                <button
                  onClick={() => handleEdit(review.reviewID)}
                  className="text-blue-600 hover:text-blue-800 mr-2"
                >
                  <Edit3 className="inline-block w-5 h-5" />
                </button>
                <button
                  onClick={() => handleDelete(review.reviewID)}
                  className="text-red-600 hover:text-red-800 mr-2"
                >
                  <Trash2 className="inline-block w-5 h-5" />
                </button>
                <Link
                  to={`/product-review/${review.reviewID}`}
                  className="text-gray-600 hover:text-gray-800"
                >
                  <Eye className="inline-block w-5 h-5" />
                </Link>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
