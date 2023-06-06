import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta/domain/models/coment.dart';
import 'package:insta/domain/models/post.dart';
import 'package:insta/domain/repository/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/reply_comment.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImage,
  ) async {
    String res = "unknown error occured";
    try {
      String photoUrl =
          await StorageMethodes().uploadingImageToFirebase("Posts", file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        postId: postId,
        description: description,
        uid: uid,
        postUrl: photoUrl,
        username: username,
        datePublished: DateTime.now(),
        profileImage: profileImage,
        likes: [],
      );
      _firestore.collection('Posts').doc(postId).set(
            post.toJson(),
          );
      return res = 'success';
    } catch (e) {
      return res = e.toString();
    }
  }

  //like post function
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("Posts").doc(postId).update({
          'likes': FieldValue.arrayRemove(
            [uid],
          ),
        });
      } else {
        await _firestore.collection("Posts").doc(postId).update({
          'likes': FieldValue.arrayUnion(
            [uid],
          ),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //like comment function
  Future<void> likeComment(
      String commentId, String uid, List likes, String postId) async {
    try {
      if (likes.contains(uid)) {
        await _firestore
            .collection("Posts")
            .doc(postId)
            .collection('Comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayRemove(
            [uid],
          ),
        });
      } else {
        await _firestore
            .collection("Posts")
            .doc(postId)
            .collection('Comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayUnion(
            [uid],
          ),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // post comments
  Future<void> postComents(
    String postId,
    String text,
    String uid,
    String name,
    String profilePic,
    
  ) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        Comment comment = Comment(
          profilePic: profilePic,
          name: name,
          uid: uid,
          text: text,
          likes: [],
          commentId: commentId,
          datePublished: DateTime.now(),
        );

        _firestore
            .collection('Posts')
            .doc(postId)
            .collection('Comments')
            .doc(commentId)
            .set(
              comment.toJson(),
            );
      } else {
        print('Text is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //deleting post
  Future<void> deletePost(
    String postId,
  ) async {
    try {
      await _firestore.collection('Post').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //following function
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
          List following = (snap.data()! as dynamic)['following'];
          if (following.contains(followId)) {
            await _firestore.collection('Users').doc(followId).update({
              'followers': FieldValue.arrayRemove([uid])
            });

              await _firestore.collection('Users').doc(followId).update({
              'following': FieldValue.arrayRemove([followId])
            });
          }else{
              await _firestore.collection('Users').doc(followId).update({
              'followers': FieldValue.arrayUnion([uid])
            });

              await _firestore.collection('Users').doc(followId).update({
              'following': FieldValue.arrayUnion([followId])
            });
          }
    } catch (e) {
      print(e.toString());
    }
  }

  //reply comments
  Future<void> replyComments(
    String commentId,
    String postId,
    String text,
    String uid,
    String name,
    String profilePic,
  )async{
    try {
      if (text.isNotEmpty) {
         String replyCommentId = const Uuid().v1();
        ReplyComments  reply = ReplyComments(
          profilePic: profilePic,
          name: name,
          uid: uid,
          text: text,
          replyCommentId: replyCommentId,
          datePublished: DateTime.now(),
        );
        _firestore
            .collection('Posts')
            .doc(postId)
            .collection('Comments')
            .doc(commentId)
            .collection('reply')
            .doc(replyCommentId)
            .set(
              reply.toJson()
            );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
