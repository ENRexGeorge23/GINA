import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DoctorForumModel extends Equatable {
  final dynamic postId;
  final String posterUid;
  final String title;
  final String description;
  final String postedBy;
  final String profileImage;
  final Timestamp postedAt;
  final bool isDoctor;
  final int doctorRatingId;
  final List<DoctorForumModel> replies;

  const DoctorForumModel(
      {required this.postId,
      required this.posterUid,
      required this.title,
      required this.description,
      required this.postedBy,
      required this.profileImage,
      required this.postedAt,
      required this.replies,
      required this.isDoctor,
      required this.doctorRatingId});

  factory DoctorForumModel.fromDocumentSnap(DocumentSnapshot snap) {
    Map<String, dynamic> json = {};
    if (snap.data() != null) {
      json = snap.data() as Map<String, dynamic>;
    }

    return DoctorForumModel(
      postId: snap.id,
      posterUid: json['posterUid'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      postedBy: json['postedBy'] ?? '',
      profileImage: json['profileImage'] ?? '',
      postedAt: json['postedAt'] ?? Timestamp.now(),
      replies: json['replies'] != null
          ? List<DoctorForumModel>.from(
              json['replies'].map((x) => DoctorForumModel.fromJson(x)))
          : [],
      isDoctor: json['isDoctor'] ?? false,
      doctorRatingId: json['doctorRatingId'] ?? 0,
    );
  }

  factory DoctorForumModel.fromJson(Map<String, dynamic> json) {
    return DoctorForumModel(
      postId: json['id'],
      posterUid: json['posterUid'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      postedBy: json['postedBy'] ?? '',
      profileImage: json['profileImage'] ?? '',
      postedAt: json['postedAt'] ?? Timestamp.now(),
      replies: json['replies'] != null
          ? List<DoctorForumModel>.from(
              json['replies'].map((x) => DoctorForumModel.fromJson(x)))
          : [],
      isDoctor: json['isDoctor'] ?? false,
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
      'replies': replies,
      'isDoctor': isDoctor,
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
        replies,
        isDoctor,
        doctorRatingId,
      ];
}
