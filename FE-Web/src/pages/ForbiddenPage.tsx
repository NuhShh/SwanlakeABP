import React from "react";

export default function ForbiddenPage() {
  return (
    <div className="p-4 text-center">
      <h1 className="text-3xl font-bold text-red-500">403 - Forbidden</h1>
      <p className="text-gray-700 dark:text-gray-300">
        You do not have permission to access this page.
      </p>
    </div>
  );
}
