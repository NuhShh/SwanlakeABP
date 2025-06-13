import React from "react";

export default function AdminDashboard() {
  return (
    <div className="p-4">
      <h1 className="text-2xl font-bold mb-4 text-center dark:text-white">Admin Dashboard</h1>
      <p className="text-center text-gray-600 mb-6 dark:text-white">
        Welcome to the admin panel!
      </p>
      <div className="flex justify-center gap-4">
        <a
          href="/user-management"
          className="bg-blue-500 text-white px-6 py-3 rounded shadow hover:bg-blue-600 transition text-center"
        >
          Go to User Management
        </a>
        <a
          href="/review-management"
          className="bg-green-500 text-white px-6 py-3 rounded shadow hover:bg-green-600 transition text-center"
        >
          Go to Review Management
        </a>
      </div>
    </div>
  );
}
