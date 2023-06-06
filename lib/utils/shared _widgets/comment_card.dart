import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta/domain/models/coment.dart';
import 'package:insta/domain/models/user.dart';
import 'package:insta/domain/repository/firestore_methodes.dart';
import 'package:insta/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              widget.snap['profilePic'],
            ),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.snap['name']} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //time
                        TextSpan(
                          text: DateFormat.yMMMd().format(
                            widget.snap['datePublished'].toDate(),
                          ),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                    ),
                    child: Text(
                      ' ${widget.snap['text']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                child: IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likeComment(
                      widget.snap['commentId'],
                      user.uid,
                      widget.snap['likes'],
                      widget.snap['postId'],
                    );
                  },
                  icon: const Icon(
                    Icons.favorite,
                    size: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                child: StreamBuilder(
                  builder: (context, snapshot) {
                    return Text('${snapshot.data!.docs.length}');
                  },
                  stream: FirebaseFirestore.instance
                      .collection("Posts")
                      .doc(widget.snap['postId'])
                      .collection('comments')
                      .where('likes')
                      .snapshots(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
