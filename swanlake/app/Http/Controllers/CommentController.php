<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use Illuminate\Http\Request;

class CommentController extends Controller
{
    // Mengambil komentar berdasarkan review_id
    public function getComments($reviewId)
    {
        // Mengambil semua komentar yang terkait dengan reviewId
        $comments = Comment::where('commentReviewID', $reviewId)->get();

        // Mengembalikan komentar dalam bentuk JSON
        return response()->json([
            'message' => 'Comments fetched successfully',
            'comments' => $comments,
        ], 200);
    }

    // Menambahkan komentar baru
    public function addComment(Request $request)
    {
        // Validasi input dari request
        $request->validate([
            'commentText' => 'required|string',
            'commentAccountID' => 'required|integer',
            'commentReviewID' => 'required|integer',
            'commentUsername' => 'required|string',
        ]);

        // Menyimpan komentar baru ke dalam database
        $comment = new Comment();
        $comment->commentText = $request->commentText;
        $comment->commentAccountID = $request->commentAccountID;
        $comment->commentReviewID = $request->commentReviewID;
        $comment->commentUsername = $request->commentUsername;
        $comment->save();

        // Mengembalikan respons setelah berhasil menambahkan komentar
        return response()->json([
            'message' => 'Comment added successfully',
            'comment' => $comment,
        ], 201);
    }
}
