import React, { useEffect, useState } from "react";
import axios from "axios";
import { Link } from "react-router-dom";
import { Flame } from "lucide-react"; // Anda bisa sesuaikan dengan ikon yang diinginkan

interface Review {
  reviewID: string;
  productName: string;
  reviewTitle: string;
  cardDesc: string;
  imageName: string;
  rating: number;
  price: number;
  productType: string;
}

export default function ReviewSmartphonePage() {
  const [reviews, setReviews] = useState<Review[]>([]);
  const [error, setError] = useState<string>("");

  // Fetch data reviews untuk kategori smartphone
  useEffect(() => {
    fetchSmartphoneReviews();
  }, []);

  const fetchSmartphoneReviews = async () => {
    try {
      const response = await axios.get("http://127.0.0.1:8000/api/get/review/smartphone", {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
      });

      console.log("API Response:", response.data);  // Memeriksa respons dari API

      // Pastikan data yang diterima adalah array reviews
      if (Array.isArray(response.data.reviews)) {
        setReviews(response.data.reviews);  // Menyimpan data ke state
      } else {
        setError("Data tidak ditemukan.");
      }
    } catch (error) {
      console.error("Error fetching smartphone reviews:", error);
      setError("Terjadi kesalahan saat mengambil data review smartphone.");
    }
  };

  // Menampilkan error jika terjadi kesalahan
  if (error) {
    return (
      <div className="min-h-screen bg-gray-100 text-center py-10">
        <h2 className="text-xl text-red-600">{error}</h2>
      </div>
    );
  }

  // Menampilkan pesan jika tidak ada review
  if (reviews.length === 0) {
    return (
      <div className="min-h-screen bg-gray-100 text-center py-10">
        <h2 className="text-xl text-gray-600">No reviews available for smartphones.</h2>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-100 py-10">
      <div className="max-w-7xl mx-auto px-4">
        {/* Header Section */}
        <div className="mb-6 text-center">
          <Flame className="w-6 h-6 text-orange-500 inline-block mb-2" />
          <h2 className="text-3xl font-semibold text-gray-800">Smartphone Reviews</h2>
          <p className="text-sm text-gray-600">Latest reviews of flagship and mid-range smartphones</p>
        </div>

        {/* Reviews List Section */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {reviews.map((review) => (
            <div
              key={review.reviewID}
              className="border border-gray-300 rounded-lg shadow-lg overflow-hidden transition-transform transform hover:scale-105"
            >
              {/* Image */}
              <div className="relative">
                <img
                  src={review.imageName} // Menampilkan gambar
                  alt={review.productName}
                  className="w-full h-48 object-cover"
                />
              </div>

              {/* Card Content */}
              <div className="p-6">
                <h3 className="text-xl font-semibold text-gray-800 mb-2">{review.reviewTitle}</h3>
                <p className="text-sm text-gray-600 mb-4">
                  <strong>Product Name:</strong> {review.productName}
                </p>
                <p className="text-sm text-gray-600 mb-4">
                  <strong>Product Type:</strong> {review.productType}
                </p>
                <p className="text-sm text-gray-600 mb-4">
                  <strong>Price:</strong> ${review.price || 'N/A'} {/* Menampilkan harga */}
                </p>
                <p className="text-sm text-gray-500 mb-4">
                  <strong>Description:</strong> {review.cardDesc}
                </p>
                <Link
                  to={`/product-review/${review.reviewID}`}  // Navigasi ke halaman detail
                  className="inline-block px-4 py-2 text-sm font-semibold text-white bg-blue-600 hover:bg-blue-700 rounded-lg transition duration-300"
                >
                  Read More...
                </Link>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
