import React, { useEffect, useState, useRef } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { Heart, Scale, Share2, ArrowLeft, MessageSquare } from "lucide-react";
import ReactStars from "react-stars";
import CommentSection from "../components/CommentSection";
import ProductSpecs from "../components/ProductSpecs";
import CompareModal from "../components/CompareModal";
import gsap from "gsap";
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
  const [review, setReview] = useState<Review | null>(null);  // review bisa null saat pertama kali
  const [isWishlisted, setIsWishlisted] = useState(false);
  const [isCompareModalOpen, setIsCompareModalOpen] = useState(false);
  const [comparableProducts, setComparableProducts] = useState<Review[]>([]);
  const navigate = useNavigate();

  const modalRef = useRef<HTMLDivElement>(null);
  const contentRef = useRef<HTMLDivElement>(null);

  const token = localStorage.getItem("token");

  useEffect(() => {
    window.scrollTo(0, 0);
    if (reviewID) {
      fetchReview(reviewID);
    }
  }, [reviewID]);

  const fetchReview = async (id: string) => {
    if (!token) return;

    try {
      const result = await fetch(`http://127.0.0.1:8000/api/get/review/${id}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      const data = await result.json();
      setReview(data.review);
    } catch (error) {
      console.error("Error fetching review:", error);
    }
  };

  const fetchComparableProducts = async (productType: string) => {
  if (!token) return;

  try {
    const result = await fetch("http://127.0.0.1:8000/api/get/review", {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    const data = await result.json();
    console.log("Fetched comparable products:", data);

    // Check if the data is an array before using filter
    if (Array.isArray(data)) {
      const filteredProducts = data.filter(
        (prod: Review) => prod.productType === productType && prod.reviewID !== review?.reviewID
      );
      setComparableProducts(filteredProducts);
    } else {
      console.error("API response is not an array:", data);
    }
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

  useEffect(() => {
    if (isCompareModalOpen && modalRef.current && contentRef.current) {
      gsap.to(modalRef.current, {
        opacity: 1,
        duration: 0.3,
        ease: "power2.out",
      });
      gsap.fromTo(
        contentRef.current,
        { opacity: 0, y: 20, scale: 0.95 },
        { opacity: 1, y: 0, scale: 1, duration: 0.4, ease: "back.out(1.7)" }
      );
    }
  }, [isCompareModalOpen]);

  const handleClose = () => {
    gsap.to(modalRef.current, {
      opacity: 0,
      duration: 0.2,
      ease: "power2.in",
    });
    gsap.to(contentRef.current, {
      opacity: 0,
      y: 20,
      scale: 0.95,
      duration: 0.2,
      ease: "power2.in",
      onComplete: () => setIsCompareModalOpen(false),
    });
  };

  const handleProductSelection = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const selectedReviewID = e.target.value;
    if (!selectedReviewID) return;

    const product = comparableProducts.find(
      (prod) => prod.reviewID.toString() === selectedReviewID
    );

    if (product) {
      setReview(product);  // Set the selected product as current review
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
              src={review.imageName}
              alt={review.productName}
              className="w-full h-96 object-cover"
            />

            <div className="p-6">
              <div className="flex items-center justify-between mb-4">
                <h1 className="text-3xl font-bold dark:text-white">
                  {review.reviewTitle?.trim() || "No title available"}
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
                    <Heart className={`w-6 h-6 ${isWishlisted ? "fill-current" : ""}`} />
                  </button>
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
                    value={review.rating || 0}
                    size={24}
                    color2="#FDB241"
                    edit={false}
                  />
                  <span className="text-lg font-semibold dark:text-white">
                    {review.rating || "No rating"}
                  </span>
                </div>
                <div className="text-gray-500 dark:text-gray-400">|</div>
                <div className="flex items-center gap-2 text-gray-500 dark:text-gray-400">
                  <MessageSquare className="w-5 h-5" />
                  <span>128 comments</span>
                </div>
              </div>
              <p className="text-gray-600 dark:text-gray-300 mb-6">
                {review.reviewText?.trim() || "No review text available"}
              </p>
            </div>
          </div>

          <CommentSection reviewID={reviewID || ""} />
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          <ProductSpecs
            specs={{
              processor: review.processor || "Processor not available",
              processorDesc: review.processorDesc || "No description available",
              storage: review.storage || "Storage not available",
              storageDesc: review.storageDesc || "No description available",
              display: review.display || "Display not available",
              displayDesc: review.displayDesc || "No description available",
              battery: review.battery || "Battery not available",
              batteryDesc: review.batteryDesc || "No description available",
            }}
          />
        </div>
      </div>

      <CompareModal
        isOpen={isCompareModalOpen}
        onClose={handleClose}
        currentProduct={review}
      />
    </div>
  );
}
