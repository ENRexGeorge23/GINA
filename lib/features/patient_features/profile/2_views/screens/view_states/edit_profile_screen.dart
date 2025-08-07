import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/profile/2_views/bloc/profile_bloc.dart';
import 'package:first_app/features/patient_features/profile/2_views/widgets/edit_text_fields_form.dart';
import 'package:first_app/features/patient_features/profile/2_views/widgets/profile_update_dialog/bloc/profile_update_bloc.dart';
import 'package:first_app/features/patient_features/profile/2_views/widgets/profile_update_dialog/profile_update_dialog_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatelessWidget {
  final UserModel patientData;
  const EditProfileScreen({super.key, required this.patientData});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController =
        TextEditingController(text: patientData.name);
    final TextEditingController emailController =
        TextEditingController(text: patientData.email);
    final TextEditingController birthdateController =
        TextEditingController(text: patientData.dateOfBirth);
    final TextEditingController genderController =
        TextEditingController(text: patientData.gender);
    final TextEditingController addressController =
        TextEditingController(text: patientData.address);
    final ginaTheme = Theme.of(context);
    final profileBloc = context.read<ProfileBloc>();
    final profileUpdateBloc = context.read<ProfileUpdateBloc>();
    bool isSavedButtonClicked = false;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: GinaAppTheme.lightOnTertiary,
          ),
          height: MediaQuery.of(context).size.height / 1.52,
          width: MediaQuery.of(context).size.width / 1.05,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(30),
                SizedBox(
                  child: Image.asset(
                    Images.editPatientProfilePlaceholder,
                    width: 120,
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                ),
                const Gap(20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditProfileTextField(
                          textController: fullNameController,
                          ginaTheme: ginaTheme,
                          labelText: 'Full Name',
                          readOnly: false),
                      const Gap(15),
                      EditProfileTextField(
                          textController: emailController,
                          ginaTheme: ginaTheme,
                          labelText: 'Email Address',
                          readOnly: true),
                      const Gap(15),
                      EditProfileTextField(
                        textController: birthdateController,
                        ginaTheme: ginaTheme,
                        labelText: 'Birthdate',
                        readOnly: false,
                      ),
                      const Gap(15),
                      EditProfileTextField(
                        textController: genderController,
                        ginaTheme: ginaTheme,
                        labelText: 'Gender',
                        readOnly: true,
                      ),
                      const Gap(15),
                      EditProfileTextField(
                          textController: addressController,
                          ginaTheme: ginaTheme,
                          labelText: 'Address',
                          readOnly: false),
                    ],
                  ),
                ),
                const Gap(20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                GinaAppTheme.lightSurface),
                          ),
                          onPressed: () {
                            profileBloc.add(GetProfileEvent());
                          },
                          child: Text(isSavedButtonClicked == true
                              ? 'Close'
                              : 'Cancel'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            profileUpdateBloc.add(EditProfileSaveButtonEvent(
                              name: fullNameController.text,
                              dateOfBirth: birthdateController.text,
                              address: addressController.text,
                            ));
                            Future.delayed(const Duration(seconds: 1), () {
                              profileBloc.add(GetProfileEvent());
                            });
                            showProfileUpdateStateDialog(context: context);
                          },
                          child: const Text('Save'),
                        ),
                      ),
                    ],
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
