import React, { useState, ChangeEvent, FormEvent } from "react";
import UserService from "../service/UserService";
import { useNavigate } from "react-router-dom";

// Define the shape of the form data
interface FormData {
  name: string;
  email: string;
  password: string;
  role: string;
}

function RegistrationPage() {
  const navigate = useNavigate();

  // Initialize formData state with the type FormData
  const [formData, setFormData] = useState<FormData>({
    name: "",
    email: "",
    password: "",
    role: "USER", // Set default role as "USER"
  });

  // Handle input changes with proper typing for event
  const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  // Handle form submission with proper typing for event
  const handleSubmit = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      // Call the register method from UserService
      const response = await UserService.register(formData);

      if (response.message === "User Saved Successfully") {
        setFormData({
          name: "",
          email: "",
          password: "",
          role: "USER",
        });
        alert("User registered successfully");
        navigate("/");
      } else {
        // Show backend validation message
        alert(response.message);
      }
    } catch (error: any) {
      console.error("Error registering user:", error);
      alert(
        error.response?.data?.message ||
          "An error occurred while registering user"
      );
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-50">
      <div className="w-full max-w-md p-8 bg-white shadow-lg rounded-lg">
        <h2 className="text-3xl font-semibold text-center text-gray-800 mb-6">
          Sign Up
        </h2>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label htmlFor="name" className="block text-gray-700">
              Username
            </label>
            <input
              type="text"
              id="name"
              name="name"
              value={formData.name}
              onChange={handleInputChange}
              required
              className="w-full px-4 py-2 mt-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="email" className="block text-gray-700">
              Email
            </label>
            <input
              type="email"
              id="email"
              name="email"
              value={formData.email}
              onChange={handleInputChange}
              required
              className="w-full px-4 py-2 mt-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
          <div className="mb-6">
            <label htmlFor="password" className="block text-gray-700">
              Password
            </label>
            <input
              type="password"
              id="password"
              name="password"
              value={formData.password}
              onChange={handleInputChange}
              required
              className="w-full px-4 py-2 mt-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
          {/* Hidden role field */}
          <input type="hidden" name="role" value="USER" />
          <button
            type="submit"
            className="w-full py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500"
          >
            Register
          </button>
        </form>
        <p className="mt-4 text-center text-gray-600">
          Already have an account?{" "}
          <a href="/" className="text-blue-500 hover:underline">
            Login here
          </a>
        </p>
      </div>
    </div>
  );
}

export default RegistrationPage;
