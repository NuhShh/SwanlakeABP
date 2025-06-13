import React from "react";
import { Navigate } from "react-router-dom";
import UserService from "../service/UserService";

interface ProtectedRouteProps {
  children: React.ReactNode;
  roles?: string[]; // Tambahkan prop roles untuk validasi peran
}

export default function ProtectedRoute({
  children,
  roles,
}: ProtectedRouteProps) {
  const isAuthenticated = UserService.isAuthenticated();
  const userRole = localStorage.getItem("role"); // Ambil peran pengguna dari localStorage

  if (!isAuthenticated) {
    // Jika pengguna tidak login, arahkan ke halaman login
    return <Navigate to="/" />;
  }

  if (roles && !roles.includes(userRole || "")) {
    // Jika pengguna tidak memiliki izin untuk peran tertentu, arahkan ke ForbiddenPage
    return <Navigate to="/403" />;
  }

  // Jika semua validasi berhasil, render children
  return <>{children}</>;
}
