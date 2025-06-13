import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Comment {
  final String username;
  final String commentText;
  final String timestamp;

  Comment({
    required this.username,
    required this.commentText,
    required this.timestamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      username: json['commentUsername'] ?? 'Anonymous',
      commentText: json['commentText'] ?? '',
      timestamp: json['created_at'] ?? 'Unknown',
    );
  }
}

class CommentThreadModel {
  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['name'];
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  Future<int?> getAccountID() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['accountID'];
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  // Fetch comments for a specific review
  Future<List<Comment>> fetchComments(int reviewID) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token tidak ditemukan');
    }

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/get/comments/$reviewID'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> commentsJson = jsonResponse['comments'] ?? [];
        return commentsJson.map((item) => Comment.fromJson(item)).toList();
      } else {
        throw Exception('Gagal memuat komentar: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal fetch comments: $e');
    }
  }

  // Add a comment
  Future<void> addComment(int reviewID, String commentText, int accountID, String userName) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token tidak ditemukan');
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/add/comment'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'review_id': reviewID,
          'commentText': commentText,
          'commentAccountID': accountID,
          'commentUsername': userName,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal menambahkan komentar');
      }
    } catch (e) {
      throw Exception('Gagal mengirim komentar: $e');
    }
  }
}
