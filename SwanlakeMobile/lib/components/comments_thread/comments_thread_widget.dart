import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentsThreadWidget extends StatefulWidget {
  final int reviewID;

  const CommentsThreadWidget({Key? key, required this.reviewID}) : super(key: key);

  @override
  _CommentsThreadWidgetState createState() => _CommentsThreadWidgetState();
}

class _CommentsThreadWidgetState extends State<CommentsThreadWidget> {
  bool isLoading = false;
  String? error;
  List<Comment> comments = [];
  TextEditingController _commentController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  late String userName;
  late int accountID;

  Future<void> addComment(String commentText) async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final responseAccount = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (responseAccount.statusCode == 200) {
        final data = jsonDecode(responseAccount.body);
        userName = data['name'];
        accountID = data['accountID'] ?? 0;
      } else {
        print('Failed to fetch user: ${responseAccount.body}');
      }

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/add/comment'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'commentText': commentText,
          'commentAccountID': accountID.toString(),
          'commentReviewID': widget.reviewID.toString(),
          'commentUsername': userName,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Comment added successfully');
        fetchComments();
      } else {
        throw Exception('Failed to add comment');
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fetch comments from API
  Future<void> fetchComments() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/get/comments/${widget.reviewID}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> commentsJson = jsonResponse['comments'] ?? [];

        setState(() {
          comments = commentsJson.map((item) => Comment.fromJson(item)).toList();
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);  // Scroll to the top
          }
        });

      } else {
        throw Exception('Gagal memuat komentar: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading spinner
            : error != null
            ? Center(child: Text('Error: $error')) // Show error message if any
            : Column(
          children: [
            // Displaying the fetched comments in ListView, reverse the order of comments to show the latest at the top
            Expanded(
              child: ListView.builder(
                controller: _scrollController,  // Use scroll controller to manage the scroll position
                reverse: true,  // This will make the newest comment appear at the top
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return CommentCard(
                    username: comment.username,
                    commentText: comment.commentText,
                    timestamp: comment.timestamp,
                  );
                },
              ),
            ),
            // TextField to add a new comment
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                      style: TextStyle(  // This will set the text color while typing
                        color: Colors.black,  // Ensure text color is black or any contrasting color
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send_rounded,
                      color: Colors.blue,
                      size: 30.0,
                    ),
                    onPressed: () {
                      String commentText = _commentController.text;
                      if (commentText.isNotEmpty) {
                        // Send comment action
                        addComment(commentText);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final String username;
  final String commentText;
  final String timestamp;

  const CommentCard({
    Key? key,
    required this.username,
    required this.commentText,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the timestamp using timeago
    String formattedTimestamp = _formatTimestamp(timestamp);

    return Card(
      margin: EdgeInsets.only(bottom: 12.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Username and timestamp
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formattedTimestamp,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            // Comment text
            Text(commentText),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    try {
      // Parse the original timestamp into DateTime object
      DateTime parsedDate = DateTime.parse(timestamp);
      // Format the timestamp into a more readable format using timeago
      return timeago.format(parsedDate); // e.g., "2 minutes ago"
    } catch (e) {
      return timestamp; // If the parsing fails, return the raw timestamp
    }
  }
}

// Comment model for parsing JSON data
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