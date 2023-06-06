import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final  datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  const Post({
    required this.postId,
    required this.description,
    required this.uid,
    required this.postUrl,
    required this.username,
    required this.datePublished,
    required this.likes,
    required this.profileImage,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "postId": postId,
        "postUrl": postUrl,
        "profileImage": profileImage,
        "likes": likes,
        "description": description,
        "datePublished": datePublished,
      };

  static Post fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return Post(
      postUrl: snap['postUrl'],
      uid: snap['uid'],
      likes: snap['likes'],
      username: snap['username'],
      description: snap['description'],
      datePublished: snap['datePublished'],
      profileImage: snap['profileImage'],
      postId: snap['postId'],
    );
  }
}
