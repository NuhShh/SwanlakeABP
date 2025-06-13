import React, { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";

interface Review {
  productName: string;
  productType: string;
  reviewTitle: string;
  cardDesc?: string;
  processor?: string;
  processorDesc?: string;
  ram?: string;
  ramDesc?: string;
  storage?: string;
  storageDesc?: string;
  display?: string;
  displayDesc?: string;
  battery?: string;
  batteryDesc?: string;
  camera?: string;
  cameraDesc?: string;
  price: number;
  reviewText?: string;
  imageName?: string;
  rating?: number;
  keyFeatures?: string;
  performance?: string;
}

const UpdateReviewPage: React.FC = () => {
  const { reviewID } = useParams<{ reviewID: string }>();
  const navigate = useNavigate();

  const [formValues, setFormValues] = useState<Partial<Review>>({});
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (reviewID) {
      axios
        .get<Review>(`http://localhost:8080/get/review/${reviewID}`)
        .then((response) => {
          setFormValues(response.data);
        })
        .catch(() => {
          setError("Failed to fetch review details.");
        })
        .finally(() => setLoading(false));
    }
  }, [reviewID]);

  const handleInputChange = (
    e: React.ChangeEvent<
      HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement
    >
  ) => {
    const { name, value } = e.target;
    setFormValues((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (reviewID) {
      axios
        .put(`http://localhost:8080/put/review/${reviewID}`, formValues)
        .then(() => {
          alert("Review updated successfully!");
          navigate("/review-management");
        })
        .catch(() => {
          setError("Failed to update review.");
        });
    }
  };

  const handleCancel = () => {
    navigate("/review-management");
  };

  if (loading)
    return <div className="text-center mt-10 text-lg">Loading...</div>;
  if (error)
    return (
      <div className="text-center mt-10 text-lg text-red-500">
        Error: {error}
      </div>
    );

  return (
    <div className="flex justify-center items-center h-full bg-gray-100 py-10">
      <div className="w-full max-w-4xl bg-white shadow-lg rounded-lg p-10">
        <h1 className="text-3xl font-semibold text-gray-700 text-center mb-8">
          Update Review
        </h1>
        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Form Fields */}
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Product Name
            </label>
            <input
              type="text"
              name="productName"
              value={formValues.productName || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            />
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Product Type
            </label>
            <select
              name="productType"
              value={formValues.productType || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            >
              <option value="" disabled>
                Select Product Type
              </option>
              <option value="Smartphones">Smartphones</option>
              <option value="Laptops">Laptops</option>
              <option value="Accessories">Accessories</option>
              <option value="Consoles">Consoles</option>
            </select>
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Review Title
            </label>
            <input
              type="text"
              name="reviewTitle"
              value={formValues.reviewTitle || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            />
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Card Description
            </label>
            <textarea
              name="cardDesc"
              value={formValues.cardDesc || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              rows={3}
            ></textarea>
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Processor
            </label>
            <input
              type="text"
              name="processor"
              value={formValues.processor || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            />
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Processor Description
            </label>
            <textarea
              name="processorDesc"
              value={formValues.processorDesc || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              rows={3}
            ></textarea>
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              RAM
            </label>
            <input
              type="text"
              name="ram"
              value={formValues.ram || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            />
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              RAM Description
            </label>
            <textarea
              name="ramDesc"
              value={formValues.ramDesc || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              rows={3}
            ></textarea>
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Storage
            </label>
            <input
              type="text"
              name="storage"
              value={formValues.storage || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            />
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Storage Description
            </label>
            <textarea
              name="storageDesc"
              value={formValues.storageDesc || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              rows={3}
            ></textarea>
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Display
            </label>
            <input
              type="text"
              name="display"
              value={formValues.display || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            />
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Display Description
            </label>
            <textarea
              name="displayDesc"
              value={formValues.displayDesc || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              rows={3}
            ></textarea>
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Battery
            </label>
            <input
              type="text"
              name="battery"
              value={formValues.battery || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            />
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Battery Description
            </label>
            <textarea
              name="batteryDesc"
              value={formValues.batteryDesc || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              rows={3}
            ></textarea>
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Camera
            </label>
            <input
              type="text"
              name="camera"
              value={formValues.camera || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            />
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Camera Description
            </label>
            <textarea
              name="cameraDesc"
              value={formValues.cameraDesc || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              rows={3}
            ></textarea>
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Price
            </label>
            <input
              type="number"
              name="price"
              value={formValues.price || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            />
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Review Text
            </label>
            <textarea
              name="reviewText"
              value={formValues.reviewText || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              rows={6}
            ></textarea>
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Image Name
            </label>
            <input
              type="text"
              name="imageName"
              value={formValues.imageName || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            />
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Rating
            </label>
            <input
              type="number"
              name="rating"
              value={formValues.rating || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            />
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Key Features
            </label>
            <textarea
              name="keyFeatures"
              value={formValues.keyFeatures || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              rows={3}
            ></textarea>
          </div>
          <div>
            <label className="block text-lg font-medium text-gray-600">
              Performance
            </label>
            <textarea
              name="performance"
              value={formValues.performance || ""}
              onChange={handleInputChange}
              className="mt-2 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              rows={3}
            ></textarea>
          </div>

          {/* Buttons */}
          <div className="flex justify-between mt-8">
            <button
              type="submit"
              className="w-5/12 bg-blue-500 text-white py-3 px-4 rounded-lg hover:bg-blue-600 focus:outline-none focus:ring focus:ring-blue-300"
            >
              Update
            </button>
            <button
              type="button"
              onClick={handleCancel}
              className="w-5/12 bg-gray-500 text-white py-3 px-4 rounded-lg hover:bg-gray-600 focus:outline-none focus:ring focus:ring-gray-300"
            >
              Cancel
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default UpdateReviewPage;
