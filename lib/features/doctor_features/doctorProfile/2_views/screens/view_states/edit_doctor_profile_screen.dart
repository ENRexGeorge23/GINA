import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/bloc/doctor_profile_bloc.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/widgets/doctor_profile_update_dialog/bloc/doctor_profile_update_bloc.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/widgets/doctor_profile_update_dialog/doctor_profile_update_dialog_state.dart';
import 'package:first_app/features/doctor_features/doctorProfile/2_views/widgets/edit_dcotor_text_fields_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditDoctorProfileScreen extends StatelessWidget {
  final DoctorModel doctorData;
  const EditDoctorProfileScreen({super.key, required this.doctorData});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController =
        TextEditingController(text: doctorData.name);
    final TextEditingController emailController =
        TextEditingController(text: doctorData.email);
    final TextEditingController phoneNoController =
        TextEditingController(text: doctorData.officePhoneNumber);
    final TextEditingController addressController =
        TextEditingController(text: doctorData.officeAdress);
    final ginaTheme = Theme.of(context);
    final profileBloc = context.read<DoctorProfileBloc>();
    final profileUpdateBloc = context.read<DoctorProfileUpdateBloc>();
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
                    Images.doctorProfileImagePlaceholder,
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
                      EditDoctorProfileTextField(
                          textController: fullNameController,
                          ginaTheme: ginaTheme,
                          labelText: 'Full Name',
                          readOnly: false),
                      const Gap(15),
                      EditDoctorProfileTextField(
                          textController: emailController,
                          ginaTheme: ginaTheme,
                          labelText: 'Email Address',
                          readOnly: true),
                      const Gap(15),
                      EditDoctorProfileTextField(
                        textController: phoneNoController,
                        ginaTheme: ginaTheme,
                        labelText: 'Office Phone Number',
                        readOnly: false,
                      ),
                      const Gap(15),
                      EditDoctorProfileTextField(
                        textController: addressController,
                        ginaTheme: ginaTheme,
                        labelText: 'Office Address',
                        readOnly: false,
                      ),
                    ],
                  ),
                ),
                const Gap(40),
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
                            profileBloc.add(GetDoctorProfileEvent());
                          },
                          child: Text(isSavedButtonClicked == true
                              ? 'Close'
                              : 'Cancel'),
                        ),
                      ),
                      const Gap(10),
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
                            profileUpdateBloc
                                .add(EditDoctorProfileSaveButtonEvent(
                              name: fullNameController.text,
                              phoneNo: phoneNoController.text,
                              address: addressController.text,
                            ));
                            Future.delayed(const Duration(seconds: 1), () {
                              profileBloc.add(GetDoctorProfileEvent());
                            });
                            showDoctorProfileUpdateStateDialog(
                                context: context);
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
