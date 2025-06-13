import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { Heart, Scale, Share2, ArrowLeft, MessageSquare } from "lucide-react";
import ReactStars from "react-stars";
import CommentSection from "../components/CommentSection";
import ProductSpecs from "../components/ProductSpecs";
import CompareModal from "../components/CompareModal";
import axios from "axios";

interface Review {
  reviewID: string;
  productName: string;
  productType: string;
  reviewTitle: string;
  reviewText: string;
  imageName: string;
  price: number;
  rating: number;
  keyFeatures: string[];
  processor: string;
  processorDesc: string;
  storage: string;
  storageDesc: string;
  display: string;
  displayDesc: string;
  battery: string;
  batteryDesc: string;
}

export default function ReviewPage() {
  const { reviewID } = useParams<{ reviewID: string }>();
  const [review, setReview] = useState<Review | null>(null);
  const [isWishlisted, setIsWishlisted] = useState(false);
  const [isCompareModalOpen, setIsCompareModalOpen] = useState(false);
  const [comparableProducts, setComparableProducts] = useState<Review[]>([]);
  const navigate = useNavigate();

  useEffect(() => {
    window.scrollTo(0, 0);
    if (reviewID) {
      fetchReview(reviewID);
    }
  }, [reviewID]);

  const fetchReview = async (id: string) => {
    try {
      const result = await axios.get(`http://localhost:8080/get/review/${id}`);
      setReview(result.data);
    } catch (error) {
      console.error("Error fetching review:", error);
    }
  };

  const fetchComparableProducts = async (productType: string) => {
    try {
      const result = await axios.get(`http://localhost:8080/get/review`);
      const products = result.data as Review[];
      // Filter products with the same product type, excluding the current product
      const filteredProducts = products.filter(
        (prod) =>
          prod.productType === productType && prod.reviewID !== review?.reviewID
      );
      setComparableProducts(filteredProducts);
    } catch (error) {
      console.error("Error fetching comparable products:", error);
    }
  };

  const handleCompare = () => {
    if (review) {
      fetchComparableProducts(review.productType); 
      setIsCompareModalOpen(true);
    }
  };

  if (!review) {
    return <div className="container mx-auto p-6">Loading...</div>;
  }

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        {/* Back Button */}
        <div className="fixed top-4 left-4 z-50">
          <button
            onClick={() => navigate("/")}
            className="flex items-center gap-2 dark:text-white bg-white dark:bg-black px-4 py-2 rounded-lg shadow hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors"
          >
            <ArrowLeft className="w-5 h-5" />
            <span>Back</span>
          </button>
        </div>

        {/* Main Content */}
        <div className="lg:col-span-2">
          <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg overflow-hidden">
            <img
              src={`${review.imageName}`}
              alt={review.productName}
              className="w-full h-96 object-cover"
            />

            <div className="p-6">
              <div className="flex items-center justify-between mb-4">
                <h1 className="text-3xl font-bold dark:text-white">
                  {review.reviewTitle}
                </h1>
                <div className="flex items-center gap-4">
                  <button
                    onClick={() => setIsWishlisted(!isWishlisted)}
                    className={`p-2 rounded-full transition-colors ${
                      isWishlisted
                        ? "bg-red-100 text-red-500 dark:bg-red-900 dark:text-red-300"
                        : "bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-300"
                    }`}
                  >
                    <Heart
                      className={`w-6 h-6 ${
                        isWishlisted ? "fill-current" : ""
                      }`}
                    />
                  </button>
                  {/* Compare Button */}
                  <button
                    onClick={handleCompare}
                    className="p-2 rounded-full bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-300 transition-colors"
                  >
                    <Scale className="w-6 h-6" />
                  </button>
                  <button className="p-2 rounded-full bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-300 transition-colors">
                    <Share2 className="w-6 h-6" />
                  </button>
                </div>
              </div>

              <div className="flex items-center gap-4 mb-6">
                <div className="flex items-center gap-2">
                  <ReactStars
                    count={5}
                    value={review.rating}
                    size={24}
                    color2="#FDB241"
                    edit={false}
                  />
                  <span className="text-lg font-semibold dark:text-white">
                    {review.rating}
                  </span>
                </div>
                <div className="text-gray-500 dark:text-gray-400">|</div>
                <div className="flex items-center gap-2 text-gray-500 dark:text-gray-400">
                  <MessageSquare className="w-5 h-5" />
                  <span>128 comments</span>
                </div>
              </div>
              <p className="text-gray-600 dark:text-gray-300 mb-6">
                {review.reviewText}
              </p>
            </div>
          </div>

          <CommentSection reviewID={reviewID || ""} />
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          <ProductSpecs
            specs={{
              processor: review.processor,
              processorDesc: review.processorDesc,
              storage: review.storage,
              storageDesc: review.storageDesc,
              display: review.display,
              displayDesc: review.displayDesc,
              battery: review.battery,
              batteryDesc: review.batteryDesc,
            }}
          />
        </div>
      </div>

      {/* Compare Modal */}
      <CompareModal
        isOpen={isCompareModalOpen}
        onClose={() => setIsCompareModalOpen(false)}
        currentProduct={review}
        // Pass the comparable products
      />
    </div>
  );
}
