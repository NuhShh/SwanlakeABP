import React, { useEffect, useState } from "react";
import axios from "axios";
import { Eye, Edit, Trash } from "lucide-react";

interface Account {
  accountID: string;
  role: string;
  username: string;
  password: string;
  email: string;
  imagePath?: string;
}

export default function UserList() {
  const [accounts, setAccounts] = useState<Account[]>([]);

  useEffect(() => {
    loadAccounts();
  }, []);

  const loadAccounts = async () => {
    const result = await axios.get("http://localhost:8080/get/account");
    setAccounts(result.data);
  };

  const handleView = (id: string) => {
    alert(`View account with ID: ${id}`);
  };

  const handleEdit = (id: string) => {
    alert(`Edit account with ID: ${id}`);
  };

  const handleDelete = (id: string) => {
    alert(`Delete account with ID: ${id}`);
  };

  return (
    <div className="container mx-auto p-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        {accounts.map((account, index) => (
          <div
            key={index}
            className="border border-gray-300 rounded-lg shadow-md overflow-hidden"
          >
            {/* Image Section */}
            <img
              src={account.imagePath || "default-avatar.png"}
              alt={account.username}
              className="w-full h-48 object-cover"
            />

            {/* Card Content */}
            <div className="p-4">
              <h3 className="text-lg font-semibold text-gray-800">
                {account.username}
              </h3>
              <p className="text-sm text-gray-600">Role: {account.role}</p>
              <p className="text-sm text-gray-600">Email: {account.email}</p>
              <p className="text-sm text-gray-600">
                Password: {account.password}
              </p>
              <p className="text-sm text-gray-600">
                Account ID: {account.accountID}
              </p>
              <div className="mt-4 flex justify-between space-x-2">
                <button
                  className="flex items-center px-3 py-2 text-sm text-blue-600 border border-blue-600 rounded hover:bg-blue-100"
                  onClick={() => handleView(account.accountID)}
                >
                  <Eye size={16} className="mr-1" />
                  View
                </button>
                <button
                  className="flex items-center px-3 py-2 text-sm text-yellow-600 border border-yellow-600 rounded hover:bg-yellow-100"
                  onClick={() => handleEdit(account.accountID)}
                >
                  <Edit size={16} className="mr-1" />
                  Edit
                </button>
                <button
                  className="flex items-center px-3 py-2 text-sm text-red-600 border border-red-600 rounded hover:bg-red-100"
                  onClick={() => handleDelete(account.accountID)}
                >
                  <Trash size={16} className="mr-1" />
                  Delete
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
