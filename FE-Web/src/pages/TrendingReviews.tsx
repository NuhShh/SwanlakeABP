import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { gsap } from "gsap";
import ReviewCard from "../components/ReviewCard";
import { ArrowLeft } from "lucide-react";

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
  views: number;
  likes: number;
}

export default function TrendingReviewsPage() {
  const [trendingReviews, setTrendingReviews] = useState<Review[]>([]);
  const navigate = useNavigate();

  useEffect(() => {
    const loadTrendingReviews = async () => {
      try {
        const result = await fetch("http://localhost:8080/get/review");
        const allReviews = await result.json();

        // Map data dari API ke struktur yang diinginkan
        const formattedReviews = allReviews.map((review: any) => ({
          reviewID: review.reviewID,
          productName: review.productName,
          reviewTitle: review.reviewTitle,
          cardDesc: review.cardDesc,
          productType: review.productType,
          price: review.price,
          imageName: review.imageName,
          badge: undefined,
          date: review.date || "N/A",
          rating: review.rating,
          views: review.views,
          likes: review.likes,
        }));

        setTrendingReviews(formattedReviews);

        // Animasi untuk kartu
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

    loadTrendingReviews();
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
          backgroundImage: `linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.7)), url("https://i.pinimg.com/736x/ee/e2/cd/eee2cd358c1d67fc27a3f9910f071f0f.jpg")`,
          backgroundSize: "cover",
          backgroundPosition: "center",
        }}
      >
        <div className="text-center text-white">
          <h1 className="text-5xl font-bold mb-4">Newest Reviews</h1>
          <p className="text-xl max-w-2xl mx-auto">
            Discover the latest review everyone is talking about.
          </p>
        </div>
      </div>

      {/* Konten */}
      <div className="max-w-7xl mx-auto px-4 py-12">
        <div className="flex justify-between items-center mb-8">
          <p className="text-gray-600 dark:text-white/80">
            Showing {trendingReviews.length} newest reviews
          </p>
        </div>

        {/* Review Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {trendingReviews.map((review, index) => (
            <ReviewCard
              key={review.reviewID}
              image={review.imageName}
              title={review.reviewTitle}
              description={review.cardDesc}
              date={review.date || "N/A"}
              badge={review.badge}
              reviewID={`${review.reviewID}`}
              index={index}
            />
          ))}
        </div>
      </div>
    </div>
  );
}
