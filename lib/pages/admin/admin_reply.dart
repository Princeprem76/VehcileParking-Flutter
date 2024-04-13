import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vehicle_parking/constants/global_variables.dart';
import 'package:vehicle_parking/pages/admin/services/admin_services.dart';
import 'package:vehicle_parking/pages/home/services/home_services.dart';

class AdminReplyPage extends StatefulWidget {
  final String id;

  const AdminReplyPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _AdminReplyPageState createState() => _AdminReplyPageState();
}

class _AdminReplyPageState extends State<AdminReplyPage> {
  List comments = [];

  @override
  void initState() {
    super.initState();
    _getComments();
  }

  _getComments() {
    AdminHomeService.getcomments(widget.id).then((response) async {
      if (response.statusCode == 200) {
        var cmtData = json.decode(response.body);
        setState(() {
          comments = cmtData['comments'];
        });
      }
    });
  }

  _submitReply(String id, String comment) {
    HomeService.addreply(id, comment).then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Reply Added')));
        Navigator.pop(context);
        _getComments();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Error')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.blueColor,
        title: const Text(
          "Admin Reply",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          var comment = comments[index];
          List<dynamic> replies = comment['replies'];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(comment['comment']),
                subtitle: Text('By: ${comment['name']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.reply),
                  onPressed: () {
                    _showReplyDialog(comment['id'].toString());
                  },
                ),
              ),
              // Display replies if they exist
              if (replies.isNotEmpty)
                Column(
                  children: replies.map((reply) {
                    return ListTile(
                      title: Text(reply['reply']),
                      subtitle: Text('By: ${reply['name']}'),
                      // You can customize how you want to display replies
                    );
                  }).toList(),
                ),
              Divider(),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showReplyDialog(String commentId) async {
    String reply = '';

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reply to Comment'),
          content: TextField(
            onChanged: (value) {
              reply = value;
            },
            decoration:
                const InputDecoration(hintText: 'Type your reply here...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _submitReply(commentId, reply);
              },
              child: const Text('Reply'),
            ),
          ],
        );
      },
    );
  }
}
