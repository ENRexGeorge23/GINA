import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/bloc/doctor_forums_bloc.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/widgets/create_post_textfields.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/widgets/posted_confirmation_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CreateDoctorPostScreenState extends StatelessWidget {
  CreateDoctorPostScreenState({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forumsBloc = context.read<DoctorForumsBloc>();
    return Scaffold(
      appBar:  GinaDoctorAppBar(title: 'Create Post'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                DoctorCreatePostTextFields(
                  textFieldController: titleController,
                  contentTitle: 'Title',
                  maxLines: 3,
                ),
                const Gap(15),
                DoctorCreatePostTextFields(
                  textFieldController: descriptionController,
                  contentTitle: 'Description',
                  maxLines: 13,
                ),
                const Gap(20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: BlocConsumer<DoctorForumsBloc, DoctorForumsState>(
                    listenWhen: (previous, current) =>
                        current is DoctorForumsActionState,
                    buildWhen: (previous, current) =>
                        current is! DoctorForumsActionState,
                    listener: (context, state) {
                      if (state is CreateDoctorForumsPostSuccessState) {
                        postedConfirmationDialog(context, 'Posted');
                      }
                    },
                    builder: (context, state) {
                      return FilledButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (titleController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Title can\'t be empty'),
                                    backgroundColor: Colors.red));
                          } else if (descriptionController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Description can\'t be empty'),
                                    backgroundColor: Colors.red));
                          } else {
                            forumsBloc.add(CreateDoctorForumsPostEvent(
                              title: titleController.text,
                              description: descriptionController.text,
                              postedAt: Timestamp.now(),
                            ));
                          }
                        },
                        child: Text(
                          'Post',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
