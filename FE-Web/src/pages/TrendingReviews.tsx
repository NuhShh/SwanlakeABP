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
  createdAt?: string;
  rating: number;
  views: number;
  likes: number;
}

function formatDate(dateStr: string): string {
  try {
    const dt = new Date(dateStr);
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return `${dt.getDate().toString().padStart(2, "0")} ${months[dt.getMonth()]} ${dt.getFullYear()}`;
  } catch {
    return dateStr;
  }
}

export default function LatestReviewsPage() {
  const [latestReviews, setLatestReviews] = useState<Review[]>([]);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchLatest = async () => {
      try {
        const token = localStorage.getItem("token");
        if (!token) {
          console.error("Token tidak ditemukan.");
          return;
        }

        const result = await fetch("http://127.0.0.1:8000/api/get/review", {
          headers: { Authorization: `Bearer ${token}` },
        });

        const data = await result.json();

        const formatted = data.reviews
          .filter((r: any) => r.created_at)
          .sort((a: any, b: any) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime())
          .map((r: any) => ({
            reviewID: r.reviewID,
            productName: r.productName,
            reviewTitle: r.reviewTitle,
            cardDesc: r.cardDesc,
            productType: r.productType,
            price: r.price,
            imageName: r.imageName,
            createdAt: r.created_at,
            rating: r.rating,
            views: r.views,
            likes: r.likes,
          }));

        setLatestReviews(formatted);

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
        console.error("Error fetching latest reviews:", error);
      }
    };

    fetchLatest();
  }, []);

  return (
    <div className="min-h-screen dark:bg-black">
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
          <h1 className="text-5xl font-bold mb-4">Latest Reviews</h1>
          <p className="text-xl max-w-2xl mx-auto">
            Discover the newest reviews, fresh from our editors.
          </p>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-7xl mx-auto px-4 py-12">
        <div className="flex justify-between items-center mb-8">
          <p className="text-gray-600 dark:text-white/80">
            Showing {latestReviews.length} reviews
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {latestReviews.map((review, index) => (
            <ReviewCard
              key={review.reviewID}
              image={review.imageName}
              title={review.reviewTitle}
              description={review.cardDesc}
              date={`Reviewed on ${formatDate(review.createdAt || "")}`}
              badge={undefined}
              reviewID={`${review.reviewID}`}
              index={index}
            />
          ))}
        </div>
      </div>
    </div>
  );
}
