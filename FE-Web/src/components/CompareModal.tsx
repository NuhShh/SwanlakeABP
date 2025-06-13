import React, { useEffect, useRef, useState } from "react";
import { gsap } from "gsap";
import { X } from "lucide-react";
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

interface CompareModalProps {
  isOpen: boolean;
  onClose: () => void;
  currentProduct: Review;
}

function CompareItem({
  label,
  value,
  highlight = false,
}: {
  label: string;
  value: string;
  highlight?: boolean;
}) {
  return (
    <div className="flex justify-between items-center p-2 bg-gray-50 dark:bg-gray-700 rounded-lg">
      <span className="text-gray-600 dark:text-gray-300">{label}</span>
      <span
        className={`font-semibold ${
          highlight ? "text-green-600 dark:text-green-400" : "dark:text-white"
        }`}
      >
        {value}
      </span>
    </div>
  );
}

function ProductCard({ product }: { product: Review }) {
  return (
    <div>
      <img
        src={product.imageName}
        alt={product.productName}
        className="w-full h-48 object-cover rounded-lg mb-4"
      />
      <div className="space-y-2">
        <CompareItem label="Processor" value={product.processor} />
        <CompareItem label="Storage" value={product.storage} />
        <CompareItem label="Display" value={product.display} />
        <CompareItem label="Battery" value={product.battery} />
        <CompareItem label="Price" value={`$${product.price}`} highlight />
      </div>
    </div>
  );
}

export default function CompareModal({
  isOpen,
  onClose,
  currentProduct,
}: CompareModalProps) {
  const modalRef = useRef<HTMLDivElement>(null);
  const contentRef = useRef<HTMLDivElement>(null);
  const [comparableProducts, setComparableProducts] = useState<Review[]>([]);
  const [selectedProduct, setSelectedProduct] = useState<Review | null>(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (isOpen) {
      animateModal();
      fetchComparableProducts(currentProduct.productType);
    } else {
      setSelectedProduct(null);
    }
  }, [isOpen, currentProduct.productType]);

  const animateModal = () => {
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
  };

  const fetchComparableProducts = async (productType: string) => {
    try {
      setLoading(true);
      const result = await axios.get(`http://localhost:8080/get/review`);
      const products = result.data as Review[];
      const filteredProducts = products.filter(
        (prod) =>
          prod.productType === productType &&
          prod.reviewID !== currentProduct.reviewID
      );
      setComparableProducts(filteredProducts);

      // Set the first product as default selection if available
      if (filteredProducts.length > 0) {
        setSelectedProduct(filteredProducts[0]);
      }
    } catch (error) {
      console.error("Error fetching comparable products:", error);
    } finally {
      setLoading(false);
    }
  };

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
      onComplete: onClose,
    });
  };

  const handleProductSelection = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const selectedReviewID = e.target.value;
    console.log("Selected Review ID:", selectedReviewID);

    if (!selectedReviewID) {
      setSelectedProduct(null);
      return;
    }

    const product = comparableProducts.find(
      (prod) => prod.reviewID.toString() === selectedReviewID
    );

    if (product) {
      setSelectedProduct(product);
    } else {
      console.warn("Product not found for ID:", selectedReviewID);
    }
  };

  if (!isOpen) return null;

  return (
    <div
      ref={modalRef}
      className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center opacity-0"
      onClick={handleClose}
    >
      <div
        ref={contentRef}
        className="bg-white dark:bg-gray-800 rounded-2xl shadow-xl w-full max-w-4xl mx-4 overflow-hidden"
        onClick={(e) => e.stopPropagation()}
      >
        <div className="relative p-6">
          <button
            onClick={handleClose}
            className="absolute right-4 top-4 p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>

          <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-6">
            Compare Products
          </h2>

          {loading ? (
            <div className="text-center py-8">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-gray-900 dark:border-white mx-auto"></div>
              <p className="mt-2 text-gray-600 dark:text-gray-300">
                Loading comparable products...
              </p>
            </div>
          ) : (
            <div className="grid grid-cols-2 gap-8">
              <ProductCard product={currentProduct} />

              <div>
                {comparableProducts.length > 0 ? (
                  <>
                    <select
                      className="w-full p-2 mb-4 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                      onChange={handleProductSelection}
                      value={selectedProduct?.reviewID || ""}
                    >
                      <option value="">Select a product to compare</option>
                      {comparableProducts.map((product) => (
                        <option key={product.reviewID} value={product.reviewID}>
                          {product.productName}
                        </option>
                      ))}
                    </select>
                    {selectedProduct ? (
                      <ProductCard product={selectedProduct} />
                    ) : (
                      <div className="text-center py-8">
                        <p className="dark:text-white">
                          Please select a product to compare
                        </p>
                      </div>
                    )}
                  </>
                ) : (
                  <div className="text-center py-8">
                    <p className="dark:text-white">
                      No comparable products available
                    </p>
                  </div>
                )}
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
