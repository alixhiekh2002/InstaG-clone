import 'package:flutter/material.dart';
import 'package:i_clone/models/user.dart';
import 'package:i_clone/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isColorRed = false;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profilePic']),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.snap['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['text']}',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isColorRed = !isColorRed;
                });
              },
              child: isColorRed
                  ? Icon(
                      Icons.favorite,
                      size: 16,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite_border_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
