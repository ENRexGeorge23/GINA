// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/bloc/doctor_forums_bloc.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/widgets/create_post_textfields.dart';
import 'package:first_app/features/patient_features/forums/0_models/forum_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorReplyPostScreenState extends StatelessWidget {
  final ForumModel forumPost;
  DoctorReplyPostScreenState({super.key, required this.forumPost});

  final TextEditingController replyTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forumsBloc = context.read<DoctorForumsBloc>();

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              DoctorCreatePostTextFields(
                  textFieldController: replyTextFieldController,
                  contentTitle: forumPost.isDoctor
                      ? 'Replying to Dr. ${forumPost.postedBy}'
                      : 'Replying to ${forumPost.postedBy}',
                  maxLines: 13),
              const Gap(20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (replyTextFieldController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Reply can\'t be empty'),
                          backgroundColor: GinaAppTheme.lightError));
                    } else {
                      forumsBloc.add(
                        CreateReplyDoctorForumsPostEvent(
                          docForumPost: forumPost,
                          replyContent: replyTextFieldController.text,
                          repliedAt: Timestamp.now(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Post',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
