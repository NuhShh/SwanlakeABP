import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { gsap } from "gsap";
import ReviewCard from "../components/ReviewCard";
import { Filter, SortDesc, ArrowLeft } from "lucide-react";

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

const categoryData = {
    smartphones: {
        title: "Smartphones",
        description: "Latest reviews of flagship and mid-range smartphones",
        image: "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=1400",
        productType: "Smartphone", // Update this
    },
    // Tambahkan kategori lain jika perlu
};

export default function CategoryPage() {
    const { category } = useParams<{ category: keyof typeof categoryData }>();
    const [reviews, setReviews] = useState<Review[]>([]);
    const navigate = useNavigate();
    const data = category ? categoryData[category] : null;

    useEffect(() => {
        if (data) {
            const loadReviews = async () => {
                try {
                    // Ambil token dari localStorage
                    const token = localStorage.getItem('token');
                    if (!token) {
                        console.error("Token tidak ditemukan. Anda perlu login.");
                        return;
                    }

                    // Gunakan URL berdasarkan kategori
                    const result = await fetch(`http://127.0.0.1:8000/api/get/review/${data.productType.toLowerCase()}`, {
                        method: 'GET',
                        headers: {
                            'Authorization': `Bearer ${token}`, // Kirimkan token di header
                        },
                    });

                    if (!result.ok) {
                        throw new Error(`HTTP error! status: ${result.status}`);
                    }

                    const allReviews = await result.json();

                    // Filter reviews berdasarkan kategori
                    const filteredReviews = allReviews.reviews.filter(
                        (review: any) => review.productType === data.productType
                    );

                    const formattedData = filteredReviews.map((review: any) => ({
                        reviewID: review.reviewID,
                        productName: review.productName,
                        reviewTitle: review.reviewTitle,
                        cardDesc: review.cardDesc,
                        productType: review.productType,
                        price: review.price,
                        imageName: review.imageName,
                        badge: review.rating >= 4.5 ? "Top Rated" : undefined,
                        date: review.date,
                        rating: review.rating,
                    }));

                    setReviews(formattedData);

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

            loadReviews();
        }
    }, [data]);

    if (!data) return <div>Category not found</div>;

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
                className="category-header relative h-[40vh] flex items-center justify-center"
                style={{
                    backgroundImage: `linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.7)), url(${data.image})`,
                    backgroundSize: "cover",
                    backgroundPosition: "center",
                }}
            >
                <div className="text-center text-white">
                    <h1 className="text-5xl font-bold mb-4">{data.title}</h1>
                    <p className="text-xl max-w-2xl mx-auto">{data.description}</p>
                </div>
            </div>

            {/* Konten */}
            <div className="max-w-7xl mx-auto px-4 py-12">
                <div className="flex justify-between items-center mb-8">
                    <div className="flex items-center gap-4">
                        <button className="flex items-center gap-2 px-4 py-2 bg-white dark:bg-white/80 rounded-lg shadow hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                            <Filter className="w-5 h-5" />
                            <span>Filter</span>
                        </button>
                        <button className="flex items-center gap-2 px-4 py-2 bg-white dark:bg-white/80 rounded-lg shadow hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                            <SortDesc className="w-5 h-5" />
                            <span>Sort</span>
                        </button>
                    </div>
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
