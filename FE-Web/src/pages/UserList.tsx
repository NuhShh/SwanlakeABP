import React, { useEffect, useState } from "react";
import axios from "axios";
import { Eye, Edit, Trash } from "lucide-react";

interface Account {
  accountID: string;
  role: string;
  username: string;
  password: string;
  email: string;
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
      <div className="overflow-x-auto">
        <table className="min-w-full border border-gray-300 divide-y divide-gray-200">
          <thead className="bg-gray-100">
            <tr>
              <th className="px-4 py-2 text-left text-sm font-medium text-gray-700">
                Account ID
              </th>
              <th className="px-4 py-2 text-left text-sm font-medium text-gray-700">
                Role
              </th>
              <th className="px-4 py-2 text-left text-sm font-medium text-gray-700">
                Username
              </th>
              <th className="px-4 py-2 text-left text-sm font-medium text-gray-700">
                Email
              </th>
              <th className="px-4 py-2 text-left text-sm font-medium text-gray-700">
                Password
              </th>
              <th className="px-4 py-2 text-left text-sm font-medium text-gray-700">
                Action
              </th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-200">
            {accounts.map((account, index) => (
              <tr key={index}>
                <td className="px-4 py-2 text-sm text-gray-700">
                  {account.accountID}
                </td>
                <td className="px-4 py-2 text-sm text-gray-700">
                  {account.role}
                </td>
                <td className="px-4 py-2 text-sm text-gray-700">
                  {account.username}
                </td>
                <td className="px-4 py-2 text-sm text-gray-700">
                  {account.email}
                </td>
                <td className="px-4 py-2 text-sm text-gray-700">
                  {account.password}
                </td>
                <td className="px-4 py-2 flex space-x-2">
                  <button
                    className="flex items-center px-2 py-1 text-sm text-blue-600 border border-blue-600 rounded hover:bg-blue-100"
                    onClick={() => handleView(account.accountID)}
                  >
                    <Eye size={16} className="mr-1" />
                    View
                  </button>
                  <button
                    className="flex items-center px-2 py-1 text-sm text-yellow-600 border border-yellow-600 rounded hover:bg-yellow-100"
                    onClick={() => handleEdit(account.accountID)}
                  >
                    <Edit size={16} className="mr-1" />
                    Edit
                  </button>
                  <button
                    className="flex items-center px-2 py-1 text-sm text-red-600 border border-red-600 rounded hover:bg-red-100"
                    onClick={() => handleDelete(account.accountID)}
                  >
                    <Trash size={16} className="mr-1" />
                    Delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
