import React, { useEffect, useRef, useState } from "react";
import { gsap } from "gsap";
import { X, Mail, Lock, Github, Chrome, User } from "lucide-react";
import axios from "axios";

// SuccessPopup Component
function SuccessPopup({
  message,
  isOpen,
  onClose,
}: {
  message: string;
  isOpen: boolean;
  onClose: () => void;
}) {
  if (!isOpen) return null;

  return (
    <div
      className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center"
      onClick={onClose}
    >
      <div
        className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6 w-96"
        onClick={(e) => e.stopPropagation()}
      >
        <button
          onClick={onClose}
          className="absolute top-4 right-4 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300"
        >
          <X className="w-5 h-5" />
        </button>
        <p className="text-lg font-semibold text-gray-900 dark:text-white">
          {message}
        </p>
        <button
          onClick={onClose}
          className="mt-4 w-full bg-blue-600 text-white py-2 px-4 rounded-lg hover:bg-blue-700 dark:bg-gray-700 dark:hover:bg-gray-600 transition"
        >
          Close
        </button>
      </div>
    </div>
  );
}

// AuthModal Component
interface AuthModalProps {
  isOpen: boolean;
  onClose: () => void;
}

export default function AuthModal({ isOpen, onClose }: AuthModalProps) {
  const [isLogin, setIsLogin] = useState(true);
  const modalRef = useRef<HTMLDivElement>(null);
  const contentRef = useRef<HTMLDivElement>(null);
  const formRef = useRef<HTMLDivElement>(null);

  const [user, setUser] = useState({
    username: "",
    email: "",
    password: "",
  });
  const [isSuccessPopupOpen, setIsSuccessPopupOpen] = useState(false);

  const { username, email, password } = user;

  const onInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setUser({ ...user, [e.target.name]: e.target.value });
  };

  const onSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      await axios.post("http://127.0.0.1:8000/api/register", user);
      setIsSuccessPopupOpen(true); // Tampilkan success popup
      handleClose(); // Tutup modal setelah berhasil
    } catch (err: any) {
      if (err.response && err.response.data) {
        alert(err.response.data); // Tampilkan pesan error dari backend
      } else {
        console.error("Error creating user:", err);
      }
    }
  };

  useEffect(() => {
    if (isOpen) {
      gsap.to(modalRef.current, {
        opacity: 1,
        duration: 0.3,
        ease: "power2.out",
      });

      gsap.fromTo(
        contentRef.current,
        {
          opacity: 0,
          y: 20,
          scale: 0.95,
        },
        {
          opacity: 1,
          y: 0,
          scale: 1,
          duration: 0.4,
          ease: "back.out(1.7)",
        }
      );
    }
  }, [isOpen]);

  useEffect(() => {
    if (formRef.current) {
      gsap.fromTo(
        formRef.current,
        { opacity: 0, x: isLogin ? -20 : 20 },
        { opacity: 1, x: 0, duration: 0.3, ease: "power2.out" }
      );
    }
  }, [isLogin]);

  const handleClose = () => {
    gsap.to(modalRef.current, {
      opacity: 0,
      duration: 0.2,
      ease: "power2.in",
    });
    gsap.to(contentRef.current, {
      opacity: 0,
      y: 20,
      scale: 0.95,
      duration: 0.2,
      ease: "power2.in",
      onComplete: () => {
        onClose();
        setIsLogin(true); // Reset to login view when closing
        setUser({ username: "", email: "", password: "" }); // Reset form values
      },
    });
  };

  return (
    <>
      {/* Success Popup */}
      <SuccessPopup
        message="Your account has been successfully created! Please log in to continue."
        isOpen={isSuccessPopupOpen}
        onClose={() => setIsSuccessPopupOpen(false)}
      />

      {/* Auth Modal */}
      {isOpen && (
        <div
          ref={modalRef}
          className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center opacity-0"
          onClick={handleClose}
        >
          <div
            ref={contentRef}
            className="bg-white dark:bg-black rounded-2xl shadow-xl w-full max-w-md mx-4 overflow-hidden"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="relative p-6">
              <button
                onClick={handleClose}
                className="absolute right-4 top-4 p-2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors"
              >
                <X className="w-5 h-5" />
              </button>

              <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-6">
                {isLogin ? "Welcome Back" : "Create Account"}
              </h2>

              <div ref={formRef}>
                <form className="space-y-4" onSubmit={onSubmit}>
                  {!isLogin && (
                    <div>
                      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                        Username
                      </label>
                      <div className="relative">
                        <User className="w-5 h-5 text-gray-400 absolute left-3 top-1/2 -translate-y-1/2" />
                        <input
                          type="username"
                          name="username"
                          className="w-full pl-10 pr-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent transition-colors"
                          placeholder="Enter your username"
                          value={username}
                          onChange={onInputChange}
                        />
                      </div>
                    </div>
                  )}

                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                      Email
                    </label>
                    <div className="relative">
                      <Mail className="w-5 h-5 text-gray-400 absolute left-3 top-1/2 -translate-y-1/2" />
                      <input
                        type="email"
                        name="email"
                        className="w-full pl-10 pr-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent transition-colors"
                        placeholder="Enter your email"
                        value={email}
                        onChange={onInputChange}
                      />
                    </div>
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                      Password
                    </label>
                    <div className="relative">
                      <Lock className="w-5 h-5 text-gray-400 absolute left-3 top-1/2 -translate-y-1/2" />
                      <input
                        type="password"
                        name="password"
                        className="w-full pl-10 pr-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent transition-colors"
                        placeholder={
                          isLogin ? "Enter your password" : "Create a password"
                        }
                        value={password}
                        onChange={onInputChange}
                      />
                    </div>
                  </div>

                  <button
                    type="submit"
                    className="w-full bg-blue-600 dark:bg-black border dark:border-gray-600  hover:bg-blue-700 dark:hover:bg-gray-700 text-white font-medium py-2 px-4 rounded-lg transition-colors duration-200"
                  >
                    {isLogin ? "Sign In" : "Create Account"}
                  </button>
                </form>

                <p className="mt-6 text-center text-sm text-gray-600 dark:text-gray-400">
                  {isLogin
                    ? "Don't have an account?"
                    : "Already have an account?"}{" "}
                  <button
                    onClick={() => setIsLogin(!isLogin)}
                    className="text-blue-600 dark:text-white hover:text-blue-800 dark:hover:text-white font-medium"
                  >
                    {isLogin ? "Sign up" : "Sign in"}
                  </button>
                </p>
              </div>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
