import React from 'react';
import {Calendar, MapPin} from 'lucide-react';

interface AuthorCardProps {
    author?: { name: string; role: string; avatar: string; joinDate: string; location: string; bio: string }
}

export default function AuthorCard({author}: AuthorCardProps) {
    return (
        <div className="bg-white dark:bg-gray-800 rounded-lg shadow-lg p-6">
            <div className="flex items-center gap-4 mb-4">
                <img
                    src="https://cdn.rafled.com/anime-icons/images/kylNBdonrzXXrvQNwfgGR62U59yIoojM.jpg"
                    alt="Author"
                    className="w-16 h-16 rounded-full object-cover"
                />
                <div>
                    <h3 className="text-xl font-bold dark:text-white">Johan Naibaho</h3>
                    <p className="text-gray-600 dark:text-gray-300">
                        <span
                            className="inline-block bg-blue-500 text-white text-sm font-semibold px-3 py-1 rounded-full">
                            Senior Tech Reviewer
                        </span>
                    </p>
                </div>
            </div>

            <div className="space-y-2 mb-4">
                <div className="flex items-center gap-2 text-gray-600 dark:text-gray-300">
                    <Calendar className="w-4 h-4"/>
                    <span>Admin since 2020</span>
                </div>
            </div>

            <p className="text-gray-600 dark:text-gray-300 mb-4">
                Passionate about technology and its impact on our daily lives.
                Specialized in mobile devices and photography.
            </p>


        </div>
    );
}
