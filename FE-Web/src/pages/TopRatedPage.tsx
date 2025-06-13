import React, { useEffect, useState } from "react";
import { gsap } from "gsap";
import { SortDesc, ArrowLeft } from "lucide-react";
import ReviewCard from "../components/ReviewCard";
import { useNavigate } from "react-router-dom";

interface Review {
  reviewID: string;
  productName: string;
  reviewTitle: string;
  cardDesc: string;
  productType: string;
  price: number;
  imageName: string;
  badge?: string;
  date?: string;
  rating: number;
}

export default function TopRatedReviewsPage() {
  const [reviews, setReviews] = useState<Review[]>([]);
  const navigate = useNavigate();

  useEffect(() => {
    const loadReviews = async () => {
      try {
        const token = localStorage.getItem("token");
        if (!token) {
          console.error("Token tidak ditemukan. Harap login terlebih dahulu.");
          return;
        }

        const result = await fetch("http://127.0.0.1:8000/api/get/review", {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });

        const data = await result.json();

        const filtered = data.reviews
          .filter((review: any) => review.rating >= 4.5)
          .map((review: any) => ({
            reviewID: review.reviewID,
            productName: review.productName,
            reviewTitle: review.reviewTitle,
            cardDesc: review.cardDesc,
            productType: review.productType,
            price: review.price,
            imageName: review.imageName,
            badge: "Top Rated",
            date: review.date,
            rating: review.rating,
          }));

        setReviews(filtered);

        gsap.fromTo(
          ".review-card",
          { opacity: 0, scale: 0.8 },
          {
            opacity: 1,
            scale: 1,
            duration: 0.8,
            ease: "power3.out",
            stagger: 0.2,
          }
        );
      } catch (error) {
        console.error("Error fetching reviews:", error);
      }
    };

    loadReviews();
  }, []);

  return (
    <div className="min-h-screen dark:bg-black">
      {/* Tombol Back */}
      <div className="fixed top-4 left-4 z-50">
        <button
          onClick={() => navigate("/")}
          className="flex items-center gap-2 dark:text-white bg-white dark:bg-black px-4 py-2 rounded-lg shadow hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors"
        >
          <ArrowLeft className="w-5 h-5" />
          <span>Back</span>
        </button>
      </div>

      {/* Header */}
      <div
        className="page-header relative h-[40vh] flex items-center justify-center"
        style={{
          backgroundImage: `linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.7)), url("https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=1400")`,
          backgroundSize: "cover",
          backgroundPosition: "center",
        }}
      >
        <div className="text-center text-white">
          <h1 className="text-5xl font-bold mb-4">Top Rated Reviews</h1>
          <p className="text-xl max-w-2xl mx-auto">
            Explore the highest-rated products reviewed by our experts.
          </p>
        </div>
      </div>

      {/* Konten */}
      <div className="max-w-7xl mx-auto px-4 py-12">
        <div className="flex justify-between items-center mb-8">
          <button
            onClick={() => setReviews([...reviews].sort((a, b) => b.rating - a.rating))}
            className="flex items-center gap-2 px-4 py-2 bg-white dark:bg-white/80 rounded-lg shadow hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors"
          >
            <SortDesc className="w-5 h-5" />
            <span>Sort by Rating</span>
          </button>
          <p className="text-gray-600 dark:text-white/80">
            Showing {reviews.length} reviews
          </p>
        </div>

        {/* Review Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {reviews.map((review, index) => (
            <ReviewCard
              key={review.reviewID}
              image={review.imageName}
              title={review.reviewTitle}
              description={review.cardDesc}
              date={review.date || "N/A"}
              badge={review.badge}
              reviewID={review.reviewID}
              index={index}
            />
          ))}
        </div>
      </div>
    </div>
  );
}
