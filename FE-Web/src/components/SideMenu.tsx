import React from "react";
import { useNavigate } from "react-router-dom";
import {
  X,
  Smartphone,
  Laptop,
  Gamepad,
  Headphones,
  TrendingUp,
  Star,
} from "lucide-react";

interface SideMenuProps {
  isOpen: boolean;
  onClose: () => void;
}

export default function SideMenu({ isOpen, onClose }: SideMenuProps) {
  const navigate = useNavigate();

  const handleNavigate = (path: string) => {
    navigate(path);
    onClose(); // Tutup menu setelah navigasi
  };

  return (
    <>
      {/* Overlay */}
      <div
        className={`fixed inset-0 bg-black/50 transition-opacity z-40 ${
          isOpen ? "opacity-100" : "opacity-0 pointer-events-none"
        }`}
        onClick={onClose}
      />

      {/* Menu */}
      <div
        className={`fixed top-0 right-0 h-full w-80 bg-white dark:bg-black shadow-lg transform transition-transform z-50 ${
          isOpen ? "translate-x-0" : "translate-x-full"
        }`}
      >
        <div className="p-4">
          <div className="flex justify-between items-center mb-8">
            <h2 className="text-xl font-bold dark:text-white">Menu</h2>
            <button
              onClick={onClose}
              className="p-2 text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-black rounded-lg"
            >
              <X className="w-6 h-6" />
            </button>
          </div>

          <div className="space-y-6">
            <div>
              <h3 className="text-sm font-semibold text-gray-500 dark:text-gray-400 mb-3">
                FEATURED
              </h3>
              <div className="space-y-2">
                <MenuItem
                  icon={<TrendingUp />}
                  text="Newest Review"
                  onClick={() => handleNavigate("/newest-review")} // Contoh navigasi lain
                />
                <MenuItem
                  icon={<Star />}
                  text="Top Rated"
                  onClick={() => handleNavigate("/top-rated")} // Navigasi ke Top Rated
                />
              </div>
            </div>

            <div>
              <h3 className="text-sm font-semibold text-gray-500 dark:text-gray-400 mb-3">
                CATEGORIES
              </h3>
              <div className="space-y-2">
                <MenuItem
                  icon={<Smartphone />}
                  text="Smartphones"
                  onClick={() => handleNavigate("/category/smartphones")}
                />
                <MenuItem
                  icon={<Laptop />}
                  text="Laptops and Desktops"
                  onClick={() => handleNavigate("/category/laptops")}
                />
                <MenuItem
                  icon={<Gamepad />}
                  text="Consoles"
                  onClick={() => handleNavigate("/category/consoles")}
                />
                <MenuItem
                  icon={<Headphones />}
                  text="Accessories"
                  onClick={() => handleNavigate("/category/accessories")}
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}

function MenuItem({
  icon,
  text,
  onClick,
}: {
  icon: React.ReactNode;
  text: string;
  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      className="flex items-center gap-3 w-full p-2 text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg transition-colors"
    >
      {icon}
      <span>{text}</span>
    </button>
  );
}
