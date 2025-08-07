import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ForumModel extends Equatable {
  final dynamic postId;
  final String posterUid;
  final String title;
  final String description;
  final String postedBy;
  final String profileImage;
  final Timestamp postedAt;
  final bool isDoctor;
  final int doctorRatingId;
  final List<ForumModel> replies;

  const ForumModel(
      {required this.postId,
      required this.posterUid,
      required this.title,
      required this.description,
      required this.postedBy,
      required this.profileImage,
      required this.postedAt,
      required this.isDoctor,
      required this.doctorRatingId,
      required this.replies});

  factory ForumModel.fromFirestore(DocumentSnapshot snap) {
    Map<String, dynamic> json = {};
    if (snap.data() != null) {
      json = snap.data() as Map<String, dynamic>;
    }

    return ForumModel(
      postId: snap.id,
      posterUid: json['posterUid'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      postedBy: json['postedBy'] ?? '',
      profileImage: json['profileImage'] ?? '',
      postedAt: json['postedAt'] ?? Timestamp.now(),
      isDoctor: json['isDoctor'] ?? false,
      replies: json['replies'] != null
          ? List<ForumModel>.from(
              json['replies'].map((x) => ForumModel.fromJson(x)))
          : [],
      doctorRatingId: json['doctorRatingId'] ?? 0,
    );
  }

  factory ForumModel.fromJson(Map<String, dynamic> json) {
    return ForumModel(
      postId: json['id'],
      posterUid: json['posterUid'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      postedBy: json['postedBy'] ?? '',
      profileImage: json['profileImage'] ?? '',
      postedAt: json['postedAt'] ?? Timestamp.now(),
      isDoctor: json['isDoctor'] ?? false,
      replies: json['replies'] != null
          ? List<ForumModel>.from(
              json['replies'].map((x) => ForumModel.fromJson(x)))
          : [],
      doctorRatingId: json['doctorRatingId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': postId,
      'posterUid': posterUid,
      'title': title,
      'description': description,
      'postedBy': postedBy,
      'profileImage': profileImage,
      'postedAt': postedAt,
      'isDoctor': isDoctor,
      'replies': replies,
      'doctorRatingId': doctorRatingId,
    };
  }

  @override
  List<Object?> get props => [
        postId,
        posterUid,
        title,
        description,
        postedBy,
        postedAt,
        isDoctor,
        replies,
        doctorRatingId,
      ];
}
