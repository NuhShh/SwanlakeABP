import React, { useEffect, useState } from "react";
import axios from "axios";
import UserService from "../service/UserService";
import { User } from "lucide-react"; // Import ikon Lucide React

interface Comment {
  commentID: string;
  commentText: string;
  commentAccountID: string;
  commentReviewID: string;
  commentUsername: string;
}

interface ProfileInfo {
  accountID?: string;
  name?: string;
  [key: string]: any;
}

const CommentSection: React.FC<{ reviewID: string }> = ({ reviewID }) => {
  const [comments, setComments] = useState<Comment[]>([]);
  const [commentText, setCommentText] = useState("");
  const [profileInfo, setProfileInfo] = useState<ProfileInfo>({});

  useEffect(() => {
    fetchProfileInfo();
    fetchComments();
    console.log("Review ID:", reviewID); // Log reviewID
  }, [reviewID]);

  const fetchProfileInfo = async () => {
    try {
      const token = localStorage.getItem("token");
      if (!token) {
        console.error("No token found");
        return;
      }

      const response = await UserService.getYourProfile(token);
      if (response && response.account) {
        setProfileInfo(response.account);
        console.log("Account ID:", response.account.accountID); // Log accountID
      } else {
        console.error("Profile data is missing:", response);
      }
    } catch (error) {
      console.error("Error fetching profile information:", error);
    }
  };

  const fetchComments = async () => {
    try {
      const response = await axios.get<Comment[]>(
        "http://localhost:8080/get/comment"
      );
      console.log("Full comments data:", response.data);

      // Ensure type compatibility between commentReviewID and reviewID
      const filteredComments = response.data.filter(
        (comment) => String(comment.commentReviewID) === String(reviewID)
      );
      console.log(
        "Filtered comments for reviewID:",
        reviewID,
        filteredComments
      );

      setComments(filteredComments);
    } catch (error) {
      console.error("Error fetching comments:", error);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!profileInfo.accountID) {
      console.error("Profile information is missing");
      return;
    }

    const newComment = {
      commentText,
      commentAccountID: profileInfo.accountID,
      commentReviewID: reviewID,
      commentUsername: profileInfo.name || "Anonymous",
    };

    try {
      const response = await axios.post(
        "http://localhost:8080/post/comment",
        newComment
      );
      console.log("Comment posted response:", response.data);
      setCommentText("");
      fetchComments(); // Refresh comments after posting
    } catch (error) {
      console.error("Error posting comment:", error);
    }
  };

  return (
    <div className="p-4 bg-gray-100 rounded-lg shadow-md">
      <h2 className="text-lg font-bold mb-4">Comments</h2>

      {/* Form for Posting Comment */}
      <form onSubmit={handleSubmit} className="mb-6">
        <div className="mb-4">
          <textarea
            className="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            placeholder="Write your comment here..."
            value={commentText}
            onChange={(e) => setCommentText(e.target.value)}
            required
          />
        </div>
        <input
          type="hidden"
          value={profileInfo.accountID || ""}
          name="commentAccountID"
        />
        <input type="hidden" value={reviewID} name="commentReviewID" />
        <button
          type="submit"
          className="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600"
        >
          Post Comment
        </button>
      </form>

      {/* Comments Section */}
      <div>
        {comments.map((comment) => (
          <div
            key={comment.commentID}
            className="flex items-start p-4 mb-3 bg-white rounded-lg shadow"
          >
            {/* User Icon */}
            <div className="mr-4">
              <div className="w-10 h-10 flex items-center justify-center bg-gray-100 rounded-full">
                <User className="text-gray-500 w-6 h-6" />{" "}
                {/* Ikon Lucide React */}
              </div>
            </div>
            {/* Comment Content */}
            <div>
              <p className="text-gray-800 font-bold">
                {comment.commentUsername}
              </p>
              <p className="text-gray-600">{comment.commentText}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default CommentSection;
