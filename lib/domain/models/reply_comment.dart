import 'package:cloud_firestore/cloud_firestore.dart';

class ReplyComments {
    final String profilePic;
  final String name;
  final String uid;
  final String text;
  final datePublished;
  final String replyCommentId;
  ReplyComments(
      {required this.profilePic,
      required this.name,
      required this.uid,
      required this.text,
      required this.replyCommentId,
      required this.datePublished});

  Map<String, dynamic> toJson() => {
        "profilePic": profilePic,
        "uid": uid,
        "commentId": replyCommentId,
        "name": name,
        "text": text,
        "datePublished": datePublished,
      };

  static ReplyComments fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return ReplyComments(
      profilePic: snap['profilePic'],
      uid: snap['uid'],
      replyCommentId: snap['commentId'],
      name: snap['name'],
      text: snap['text'],
      datePublished: snap['datePublished'],
    );
  }
}