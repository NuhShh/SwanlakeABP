import React, { useState, useEffect } from 'react';
import { ChevronLeft, ChevronRight } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import CategoryCard from './CategoryCard';

const categories = [
    {
        title: "Smartphones",
        image: "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&q=80&w=1400",
        video: "/iphonead.mp4",
        description: "In-depth reviews of the latest flagship phones from Apple, Samsung, Google and more",
        path: "/category/smartphones"
    },
    {
        title: "Laptops & Desktops",
        image: "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=1400",
        video: "/laptopad.mp4",
        description: "From ultrabooks to gaming powerhouses, find your next perfect laptop",
        path: "/category/laptops"
    },
    {
        title: "Consoles",
        image: "https://images.unsplash.com/photo-1612287230202-1ff1d85d1bdf?auto=format&fit=crop&q=80&w=1400",
        video: "/consolead.mp4",
        description: "Reviews of the latest next-gen consoles and peripherals",
        path: "/category/consoles"
    },
    {
        title: "Accessories",
        image: "https://images.unsplash.com/photo-1546435770-a3e426bf472b?auto=format&fit=crop&q=80&w=1400",
        video: "/accad.mp4",
        description: "Premium headphones, speakers, and any other accessories tested by experts",
        path: "/category/accessories"
    }
];

export default function Carousel() {
    const [currentIndex, setCurrentIndex] = useState(0);
    const [isAutoplay, setIsAutoplay] = useState(true);
    const [isHovering, setIsHovering] = useState(false);
    const navigate = useNavigate();

    const next = () => {
        setCurrentIndex((currentIndex + 1) % categories.length);
    };

    const prev = () => {
        setCurrentIndex((currentIndex - 1 + categories.length) % categories.length);
    };

    useEffect(() => {
        let timer: NodeJS.Timeout;
        if (isAutoplay) {
            timer = setInterval(next, 5000);
        }
        return () => clearInterval(timer);
    }, [currentIndex, isAutoplay]);

    const handleCategoryClick = (path: string) => {
        navigate(path);
    };

    return (
        <div
            className="relative w-full"
            onMouseEnter={() => {
                setIsAutoplay(false);
                setIsHovering(true);
            }}
            onMouseLeave={() => {
                setIsAutoplay(true);
                setIsHovering(false);
            }}
        >
            <div className="overflow-hidden h-[calc(100vh-64px)]">
                <div
                    className="flex transition-transform duration-500 ease-out h-full"
                    style={{ transform: `translateX(-${currentIndex * 100}%)` }}
                >
                    {categories.map((category, index) => (
                        <div
                            key={index}
                            className="w-full flex-shrink-0 cursor-pointer"
                            onClick={() => handleCategoryClick(category.path)}
                        >
                            <CategoryCard {...category} isHovering={isHovering} fullHeight />
                        </div>
                    ))}
                </div>
            </div>

            <button
                onClick={(e) => {
                    e.stopPropagation();
                    prev();
                }}
                className="absolute left-8 top-1/2 -translate-y-1/2 bg-black/20 hover:bg-black/40 p-3 rounded-full transition-all z-10 opacity-0 group-hover:opacity-100 backdrop-blur-sm"
                style={{ opacity: isHovering ? 1 : 0 }}
            >
                <ChevronLeft className="w-6 h-6 text-white" />
            </button>

            <button
                onClick={(e) => {
                    e.stopPropagation();
                    next();
                }}
                className="absolute right-8 top-1/2 -translate-y-1/2 bg-black/20 hover:bg-black/40 p-3 rounded-full transition-all z-10 opacity-0 group-hover:opacity-100 backdrop-blur-sm"
                style={{ opacity: isHovering ? 1 : 0 }}
            >
                <ChevronRight className="w-6 h-6 text-white" />
            </button>

            <div className="absolute bottom-8 left-1/2 -translate-x-1/2 flex gap-2 z-10">
                {categories.map((_, index) => (
                    <button
                        key={index}
                        onClick={(e) => {
                            e.stopPropagation();
                            setCurrentIndex(index);
                        }}
                        className={`w-2 h-2 rounded-full transition-all ${
                            index === currentIndex ? 'bg-white w-8' : 'bg-white/50'
                        }`}
                    />
                ))}
            </div>
        </div>
    );
}
