import React, { useRef, useEffect } from 'react';
import { ArrowRight } from 'lucide-react';

interface CategoryCardProps {
    title: string;
    image: string;
    video?: string;
    description: string;
    fullHeight?: boolean;
    isHovering?: boolean;
}

export default function CategoryCard({
                                         title,
                                         image,
                                         video,
                                         description,
                                         fullHeight,
                                         isHovering
                                     }: CategoryCardProps) {
    const videoRef = useRef<HTMLVideoElement>(null);

    useEffect(() => {
        if (videoRef.current) {
            if (isHovering) {
                const playPromise = videoRef.current.play();
                if (playPromise !== undefined) {
                    playPromise.catch(() => {
                        // Handle any errors that might occur during playback
                    });
                }
            } else {
                videoRef.current.pause();
                videoRef.current.currentTime = 0;
            }
        }
    }, [isHovering]);

    return (
        <div className="relative group cursor-pointer overflow-hidden h-full">
            <div className={`relative ${fullHeight ? 'h-full' : 'h-[400px]'} w-full overflow-hidden`}>
                {video && (
                    <video
                        ref={videoRef}
                        className="absolute inset-0 h-full w-full object-cover opacity-0 transition-opacity duration-500 will-change-opacity"
                        style={{ opacity: isHovering ? 1 : 0 }}
                        loop
                        muted
                        playsInline
                        preload="metadata"
                    >
                        <source src={video} type="video/mp4" />
                    </video>
                )}
                <img
                    src={image}
                    alt={title}
                    className="h-full w-full object-cover transition-all duration-500"
                    style={{ opacity: isHovering ? 0 : 1 }}
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/70 to-black/20" />
            </div>
            <div className="absolute bottom-0 p-8 w-full">
                <h3 className="text-4xl font-bold text-white mb-3">{title}</h3>
                <p className="text-gray-200 mb-6 text-lg max-w-2xl">{description}</p>
                <button className="flex items-center gap-2 text-white hover:gap-4 transition-all duration-300 group/btn text-lg">
                    Read Reviews
                    <ArrowRight className="w-6 h-6 transition-transform duration-300 group-hover/btn:translate-x-1" />
                </button>
            </div>
        </div>
    );
}