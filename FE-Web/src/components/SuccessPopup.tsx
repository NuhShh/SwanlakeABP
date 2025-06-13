import React, { useRef, useEffect } from "react";
import { gsap } from "gsap";
import { X } from "lucide-react";

interface SuccessPopupProps {
  message: string;
  isOpen: boolean;
  onClose: () => void;
}

const SuccessPopup: React.FC<SuccessPopupProps> = ({
  message,
  isOpen,
  onClose,
}) => {
  const popupRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (isOpen) {
      gsap.to(popupRef.current, {
        opacity: 1,
        scale: 1,
        duration: 0.3,
        ease: "back.out(1.7)",
      });
    } else {
      gsap.to(popupRef.current, {
        opacity: 0,
        scale: 0.9,
        duration: 0.2,
        ease: "power2.in",
        onComplete: () => onClose(),
      });
    }
  }, [isOpen, onClose]);

  if (!isOpen) return null;

  return (
    <div
      className="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center"
      onClick={onClose}
    >
      <div
        ref={popupRef}
        className="bg-white dark:bg-black rounded-xl shadow-lg w-full max-w-sm mx-4 p-6 opacity-0 scale-90"
        onClick={(e) => e.stopPropagation()}
      >
        <button
          onClick={onClose}
          className="absolute right-4 top-4 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors p-2"
        >
          <X className="w-5 h-5" />
        </button>
        <h2 className="text-lg font-bold text-gray-900 dark:text-white mb-4">
          Success!
        </h2>
        <p className="text-sm text-gray-700 dark:text-gray-300">{message}</p>
        <button
          onClick={onClose}
          className="mt-4 w-full bg-blue-600 dark:bg-blue-500 text-white font-medium py-2 px-4 rounded-lg hover:bg-blue-700 dark:hover:bg-blue-600 transition-colors"
        >
          Close
        </button>
      </div>
    </div>
  );
};

export default SuccessPopup;
