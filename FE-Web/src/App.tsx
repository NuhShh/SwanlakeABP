import React from "react";
import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
} from "react-router-dom";
import Navbar from "./components/Navbar";
import HomePage from "./pages/HomePage";
import CategoryPage from "./pages/CategoryPage";
import ReviewPage from "./pages/ReviewPage";
import { ThemeProvider } from "./Theme/ThemeSwitcher";
import TopRatedReviewsPage from "./pages/TopRatedPage";
import TrendingReviewsPage from "./pages/TrendingReviews";
import UserList from "./pages/UserList";
import ReviewList from "./pages/ReviewList";
import LoginPage from "./auth/LoginPage";
import ProtectedRoute from "./auth/ProtectedRoute";
import AdminDashboard from "./pages/AdminDashboard";
import ForbiddenPage from "./pages/ForbiddenPage";
import UserService from "./service/UserService";
import RegistrationPage from "./auth/RegistrationPage";
import UserManagementPage from "./pages/UserManagementPage";
import ReviewManagementPage from "./pages/ReviewManagementPage";
import ReviewSmartphonePage from "./pages/ReviewSmartphonePage";
import AdminRegister from "./pages/AdminRegister";
import UpdateUserPage from "./pages/UpdateUserPage";
import UpdateReviewPage from "./pages/UpdateReviewPage";
import AddReview from "./pages/AddReview";

export default function App() {
  // Mengecek apakah user sudah terautentikasi
  const isAuthenticated = UserService.isAuthenticated();

  return (
    <ThemeProvider>
      <Router>
        <div className="min-h-screen transition-colors duration-200 dark:bg-gray-900">
          <Navbar />
          <Routes>
            {/* Halaman tanpa autentikasi */}
            <Route
              path="/"
              element={
                isAuthenticated ? <Navigate to="/homepage" /> : <LoginPage />
              }
            />

            <Route
              path="/register"
              element={
                isAuthenticated ? (
                  <Navigate to="/homepage" />
                ) : (
                  <RegistrationPage />
                )
              }
            />

            {/* Halaman yang membutuhkan autentikasi */}
            <Route
              path="/category/:category"
              element={
                <ProtectedRoute roles={["USER", "ADMIN"]}>
                  <CategoryPage />
                </ProtectedRoute>
              }
            />
            <Route
              path="/review/:slug"
              element={
                <ProtectedRoute roles={["USER", "ADMIN"]}>
                  <ReviewPage />
                </ProtectedRoute>
              }
            />
            <Route
              path="/top-rated/"
              element={
                <ProtectedRoute roles={["USER", "ADMIN"]}>
                  <TopRatedReviewsPage />
                </ProtectedRoute>
              }
            />
            <Route
              path="/newest-review/"
              element={
                <ProtectedRoute roles={["USER", "ADMIN"]}>
                  <TrendingReviewsPage />
                </ProtectedRoute>
              }
            />
            <Route
              path="/userlist/"
              element={
                <ProtectedRoute roles={["USER", "ADMIN"]}>
                  <UserList />
                </ProtectedRoute>
              }
            />
            <Route
              path="/reviewlist/"
              element={
                <ProtectedRoute roles={["USER", "ADMIN"]}>
                  <ReviewList />
                </ProtectedRoute>
              }
            />
            <Route
              path="/homepage/"
              element={
                <ProtectedRoute roles={["USER", "ADMIN"]}>
                  <HomePage />
                </ProtectedRoute>
              }
            />
            <Route
              path="/smartphone/"
              element={
                <ProtectedRoute roles={["USER", "ADMIN"]}>
                  <ReviewSmartphonePage />
                </ProtectedRoute>
              }
            />
            <Route
              path="/product-review/:reviewID"
              element={
                <ProtectedRoute roles={["USER", "ADMIN"]}>
                  <ReviewPage />
                </ProtectedRoute>
              }
            />

            {/* Halaman khusus admin */}
            <Route
              path="/admin-dashboard"
              element={
                <ProtectedRoute roles={["ADMIN"]}>
                  <AdminDashboard />
                </ProtectedRoute>
              }
            />

            <Route
              path="/update-user/:accountID"
              element={
                <ProtectedRoute roles={["ADMIN"]}>
                  <UpdateUserPage />
                </ProtectedRoute>
              }
            />

            <Route
              path="/update-review/:reviewID"
              element={
                <ProtectedRoute roles={["ADMIN"]}>
                  <UpdateReviewPage />
                </ProtectedRoute>
              }
            />

            {/* Halaman khusus admin */}
            <Route
              path="/user-management"
              element={
                <ProtectedRoute roles={["ADMIN"]}>
                  <UserManagementPage />
                </ProtectedRoute>
              }
            />

            <Route
              path="/admin-register"
              element={
                <ProtectedRoute roles={["ADMIN"]}>
                  <AdminRegister />
                </ProtectedRoute>
              }
            />

            <Route
              path="/review-management"
              element={
                <ProtectedRoute roles={["ADMIN"]}>
                  <ReviewManagementPage />
                </ProtectedRoute>
              }
            />

            <Route
              path="/add-review"
              element={
                <ProtectedRoute roles={["ADMIN"]}>
                  <AddReview />
                </ProtectedRoute>
              }
            />

            {/* Halaman 403 - Forbidden */}
            <Route path="/403" element={<ForbiddenPage />} />
          </Routes>
        </div>
      </Router>
    </ThemeProvider>
  );
}