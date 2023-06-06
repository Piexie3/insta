import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String profilePic;
  final String name;
  final String uid;
  final String text;
  final datePublished;
  final String commentId;
  final likes;
  Comment(
      {required this.profilePic,
      required this.name,
      required this.uid,
      required this.text,
      required this.commentId,
      required this.datePublished,
      required this.likes
      });

  Map<String, dynamic> toJson() => {
        "profilePic": profilePic,
        "uid": uid,
        "commentId": commentId,
        "name": name,
        "text": text,
        "likes": likes,
        "datePublished": datePublished,
      };

  static Comment fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return Comment(
      profilePic: snap['profilePic'],
      uid: snap['uid'],
      commentId: snap['commentId'],
      likes: snap['likes'],
      name: snap['name'],
      text: snap['text'],
      datePublished: snap['datePublished'],
    );
  }
}
