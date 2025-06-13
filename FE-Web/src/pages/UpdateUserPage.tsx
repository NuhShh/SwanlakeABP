import React, { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";

interface ReqRes {
  statusCode?: number;
  message?: string;
  error?: string;
  account?: Account;
}

interface Account {
  accountID: number;
  name: string;
  email: string;
  role: string;
  password: string;
}

const UserUpdatePage: React.FC = () => {
  const { accountID } = useParams<{ accountID: string }>();
  const navigate = useNavigate();

  const [formValues, setFormValues] = useState<Partial<Account>>({});
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (accountID) {
      axios
        .get<ReqRes>(`http://localhost:8080/get/account/${accountID}`)
        .then((response) => {
          const { account } = response.data;
          if (account) {
            setFormValues(account);
          } else {
            setError("Account not found.");
          }
        })
        .catch(() => {
          setError("Failed to fetch account details.");
        })
        .finally(() => setLoading(false));
    }
  }, [accountID]);

  const handleInputChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    const { name, value } = e.target;
    setFormValues((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (accountID) {
      axios
        .put<ReqRes>(`http://localhost:8080/put/account/${accountID}`, {
          name: formValues.name,
          email: formValues.email,
          role: formValues.role,
          password: formValues.password,
        })
        .then((response) => {
          const { message } = response.data;
          alert(message || "Account updated successfully!");
          navigate("/user-management"); 
        })
        .catch(() => {
          setError("Failed to update account.");
        });
    }
  };

  const handleCancel = () => {
    navigate("/user-management");
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
    <div className="flex justify-center items-center h-screen bg-gray-100">
      <div className="w-full max-w-md bg-white shadow-md rounded-lg p-6">
        <h1 className="text-2xl font-semibold text-gray-700 text-center mb-6">
          Update Account
        </h1>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label
              htmlFor="name"
              className="block text-sm font-medium text-gray-600"
            >
              Name
            </label>
            <input
              type="text"
              id="name"
              name="name"
              value={formValues.name || ""}
              onChange={handleInputChange}
              className="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              placeholder="Enter name"
            />
          </div>
          <div>
            <label
              htmlFor="email"
              className="block text-sm font-medium text-gray-600"
            >
              Email
            </label>
            <input
              type="email"
              id="email"
              name="email"
              value={formValues.email || ""}
              onChange={handleInputChange}
              className="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
              placeholder="Enter email"
            />
          </div>
          <div>
            <label
              htmlFor="role"
              className="block text-sm font-medium text-gray-600"
            >
              Role
            </label>
            <select
              id="role"
              name="role"
              value={formValues.role || "USER"}
              onChange={handleInputChange}
              className="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring focus:ring-blue-200"
            >
              <option value="USER">USER</option>
              <option value="ADMIN">ADMIN</option>
            </select>
          </div>
          <div className="flex justify-between">
            <button
              type="submit"
              className="w-5/12 bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600 focus:outline-none focus:ring focus:ring-blue-300"
            >
              Update
            </button>
            <button
              type="button"
              onClick={handleCancel}
              className="w-5/12 bg-gray-500 text-white py-2 px-4 rounded-lg hover:bg-gray-600 focus:outline-none focus:ring focus:ring-gray-300"
            >
              Cancel
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default UserUpdatePage;
