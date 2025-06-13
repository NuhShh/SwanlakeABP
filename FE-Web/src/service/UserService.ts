import axios, { AxiosResponse } from "axios";

export interface Profile {
  accountID: string;
  email: string;
  name: string;
  role: string;
  [key: string]: any;
}

interface UserData {
  name: string;
  email: string;
  password: string;
  [key: string]: any; // for flexibility
}

class UserService {
  static BASE_URL: string = "http://127.0.0.1:8000/api"; // Pastikan URL ini sesuai dengan API kamu

  // Login function
  static async login(
    email: string,
    password: string
  ): Promise<{ token: string; role: string } | { message: string }> {
    try {
      const response: AxiosResponse<
        { token: string; role: string } | { message: string }
      > = await axios.post(`${UserService.BASE_URL}/login`, {
        email,
        password,
      });
      return response.data;
    } catch (err) {
      throw err;
    }
  }

  // Register function
  static async register(userData: UserData): Promise<AxiosResponse> {
    try {
      const response: AxiosResponse<{ message: string }> = await axios.post(
        `${UserService.BASE_URL}/register`,
        userData
      );
      return response;  // Return the full Axios response object
    } catch (err: any) {
      if (err.response?.data?.message) {
        throw new Error(err.response.data.message);
      }
      throw err;
    }
  }


  // Get all users - Updated route
  static async getAllUsers(token: string): Promise<{ users: Profile[] }> {
    try {
      const response: AxiosResponse<{ users: Profile[] }> =
        await axios.get(`${UserService.BASE_URL}/get/user`, {
          headers: { Authorization: `Bearer ${token}` }, // Token dikirimkan di header
        });
      return response.data;
    } catch (err) {
      throw err;
    }
  }

  // Get profile function
  static async getYourProfile(token: string): Promise<Profile> {
    try {
      const response: AxiosResponse<Profile> = await axios.get(
        `${UserService.BASE_URL}/adminuser/get-profile`,
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );
      return response.data;
    } catch (err) {
      throw err;
    }
  }

  // Get user by ID
  static async getUserById(accountID: string, token: string): Promise<Profile> {
    try {
      const response: AxiosResponse<Profile> = await axios.get(
        `${UserService.BASE_URL}/get/user${accountID}`,
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );
      return response.data;
    } catch (err) {
      throw err;
    }
  }

  // Delete user function
  static async deleteUser(
    accountID: string,
    token: string
  ): Promise<{ message: string }> {
    try {
      const response: AxiosResponse<{ message: string }> = await axios.delete(
        `${UserService.BASE_URL}/delete/user/${accountID}`,
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );
      return response.data;
    } catch (err) {
      throw err;
    }
  }

  // Update user function
  static async updateUser(
    accountID: string,
    userData: Partial<UserData>,
    token: string
  ): Promise<{ message: string }> {
    try {
      const response: AxiosResponse<{ message: string }> = await axios.put(
        `${UserService.BASE_URL}/update/user/${accountID}`,
        userData,
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );
      return response.data;
    } catch (err) {
      throw err;
    }
  }

  /** AUTHENTICATION CHECKER */
  static logout(): void {
    localStorage.removeItem("token");
    localStorage.removeItem("role");
  }

  static isAuthenticated(): boolean {
    const token = localStorage.getItem("token");
    return !!token;
  }

  static isAdmin(): boolean {
    const role = localStorage.getItem("role");
    return role === "ADMIN";
  }

  static isUser(): boolean {
    const role = localStorage.getItem("role");
    return role === "USER";
  }

  static adminOnly(): boolean {
    return this.isAuthenticated() && this.isAdmin();
  }
}

export default UserService;
