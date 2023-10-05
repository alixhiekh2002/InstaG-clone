import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String uid;
  final String descrip;
  final String postID;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  const Post({
    required this.username,
    required this.uid,
    required this.descrip,
    required this.postID,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      username: snapshot["username"],
      uid: snapshot["uid"],
      descrip: snapshot["descrip"],
      postID: snapshot["postID"],
      datePublished: snapshot["datePublished"],
      postUrl: snapshot["postUrl"],
      profileImage: snapshot["profileImage"],
      likes: snapshot['likes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'descrip': descrip,
        'postID': postID,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profileImage': profileImage,
        'likes': likes,
      };
}
