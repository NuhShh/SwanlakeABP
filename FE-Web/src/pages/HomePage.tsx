import React, { useEffect, useState } from "react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import Carousel from "../components/Carousel";
import ReviewCard from "../components/ReviewCard";
import { Flame, TrendingUp } from "lucide-react";

gsap.registerPlugin(ScrollTrigger);

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

export default function HomePage() {
  const [latestReviews, setLatestReviews] = useState<Review[]>([]);
  const [topRatedReviews, setTopRatedReviews] = useState<Review[]>([]);
  const [error, setError] = useState<string>("");

  // Mengambil token dari localStorage
  const token = localStorage.getItem('token');
  console.log("Token from localStorage:", token);  // Memastikan token ada di localStorage

  // Menambahkan pengecekan token kosong
  if (!token) {
    setError("Token tidak ditemukan. Silakan login.");
  }

  useEffect(() => {
    if (!token) return; // Menghentikan eksekusi jika token tidak ada

    console.log("Fetching reviews...");
    const loadReviews = async () => {
      try {
        // Memastikan token terkirim dengan benar di header
        const result = await fetch("http://127.0.0.1:8000/api/get/review", {
          headers: {
            'Authorization': `Bearer ${token}`,
          },
        });

        const allReviews = await result.json();
        console.log("API Response:", allReviews); // Memastikan respons diterima dengan benar

        // Cek apakah 'reviews' ada dan merupakan array
        if (Array.isArray(allReviews.reviews)) {
          const latest = allReviews.reviews.slice(0, 3);

          const topRated = allReviews.reviews
            .filter((review: any) => review.rating >= 4.5)
            .map((review: any) => ({
              ...review,
              badge: "Top Rated",
            }))
            .slice(0, 3);

          setLatestReviews(latest);
          setTopRatedReviews(topRated);
        } else {
          throw new Error("Expected reviews to be an array");
        }

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
        setError("An error occurred while fetching reviews");
      }
    };

    loadReviews();
  }, [token]); // Menambahkan dependensi token di useEffect

  return (
    <div className="min-h-screen transition-colors duration-200 dark:bg-gray-900">
      <main>
        {/* Carousel */}
        <Carousel />

        {/* Error Handling */}
        {error && (
          <div className="bg-red-500 text-white text-center p-4">
            {error}
          </div>
        )}

        {/* Latest Reviews Section */}
        <section className="py-12 dark:bg-black/70">
          <div className="max-w-7xl mx-auto px-4">
            <div className="flex items-center gap-2 mb-8">
              <Flame className="w-6 h-6 text-orange-500" />
              <h2 className="text-3xl font-bold dark:text-white">
                Newest Review
              </h2>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {latestReviews.map((review, index) => (
                <ReviewCard
                  key={review.reviewID}
                  image={review.imageName}
                  title={review.reviewTitle}
                  description={review.cardDesc}
                  date={review.createdAt ? `Reviewed on ${formatDate(review.createdAt)}` : ""}
                  badge={review.badge}
                  reviewID={review.reviewID}
                  index={index}
                />
              ))}
            </div>
          </div>
        </section>

        {/* Top Rated Reviews Section */}
        <section className="py-12 bg-gray-50 dark:bg-black/75">
          <div className="max-w-7xl mx-auto px-4">
            <div className="flex items-center gap-2 mb-8">
              <TrendingUp className="w-6 h-6 text-blue-500 dark:text-white" />
              <h2 className="text-3xl font-bold dark:text-white">
                Top Rated Reviews
              </h2>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {topRatedReviews.map((review, index) => (
                <ReviewCard
                  key={review.reviewID}
                  image={review.imageName}
                  title={review.reviewTitle}
                  description={review.cardDesc}
                  date={review.createdAt ? `Reviewed on ${formatDate(review.createdAt)}` : ""}
                  badge={review.badge}
                  reviewID={review.reviewID}
                  index={index}
                />
              ))}
            </div>
          </div>
        </section>
      </main>
      {/* Footer */}
      <footer className="bg-white dark:bg-black text-black py-12 dark:text-white">
        <div className="max-w-7xl mx-auto px-4">
          <div className="flex justify-between items-center">
            <div>
              <h3 className="text-xl font-bold mb-2">SwanLake Tech</h3>
              <p className="text-gray-400">
                Your trusted source for in-depth gadget reviews and tech news.
              </p>
            </div>
            <div className="text-sm text-gray-400">
              © {new Date().getFullYear()} Swanlake Tech. All rights reserved.
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}
