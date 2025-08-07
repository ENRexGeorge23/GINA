import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/2_views/bloc/auth_bloc.dart';
import 'package:first_app/features/auth/2_views/widgets/gina_header.dart';
import 'package:first_app/features/auth/2_views/widgets/sign_up_success_dialog.dart';
import 'package:first_app/features/auth/2_views/widgets/signup_widgets/doctor/doctor_registration_steps/doctor_registration_step_1.dart';
import 'package:first_app/features/auth/2_views/widgets/signup_widgets/doctor/doctor_registration_steps/doctor_registration_step_2.dart';
import 'package:first_app/features/auth/2_views/widgets/signup_widgets/doctor/doctor_registration_steps/doctor_registration_step_3.dart';
import 'package:first_app/features/auth/2_views/widgets/signup_widgets/doctor/doctor_registration_steps/doctor_registration_step_4.dart';
import 'package:first_app/features/auth/2_views/widgets/signup_widgets/patient/patient_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int selectedIndex = 0; // 0 for 'Patient', 1 for 'Doctor'
  bool obscurePassword = true; // Initially hide the password
  int currentDoctorStep = 1; // Track the step for the doctor registration

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is AuthActionState,
        buildWhen: (previous, current) => current is! AuthActionState,
        listener: (context, state) {
          if (state is AuthRegisterPatientSuccessState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: GinaAppTheme.lightSurface,
                title: const Text('Success'),
                content:
                    const Text('Your account has been created successfully'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: GinaAppTheme.lightOnBackground,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is AuthRegisterPatientFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthRegisterDoctorSuccessState) {
            signUpSuccessDialog(context);
            // authBloc.dispose();
          } else if (state is AuthRegisterDoctorFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(30),
                Stack(
                  children: [
                    Positioned(
                      left: 20,
                      top: 25,
                      child: IconButton(
                        onPressed: () {
                          if (selectedIndex == 0) {
                            // If the selected index is 0 (Patient), you can handle the back logic accordingly.
                            // For example, you might want to navigate to a previous screen or perform some action.
                            Navigator.of(context).pop();
                          } else if (selectedIndex == 1) {
                            // If it's the doctor registration
                            if (currentDoctorStep > 1) {
                              // If there are more steps, navigate to the previous step
                              setState(() {
                                currentDoctorStep--;
                              });
                            } else {
                              // If it's the first step of the doctor registration, you might want to navigate back to the PatientRegistration widget.
                              // Adjust this based on your specific requirements.
                              setState(() {
                                selectedIndex = 0;
                              });
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF36344E),
                          size: 30,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GinaHeader(
                          size: 60,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 250,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: buildPositionedOption(
                          'Patient',
                          38,
                          isSelected: selectedIndex == 0,
                          screenWidth: screenWidth,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: buildPositionedOption('Doctor', 38,
                            isSelected: selectedIndex == 1,
                            screenWidth: screenWidth),
                      ),
                    ],
                  ),
                ),
                const Gap(20),

                //form fields
                Expanded(
                  flex: 10,
                  child: SizedBox(
                    height: 500,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (selectedIndex == 0) ...[
                            const PatientRegistration(),
                          ] else if (selectedIndex == 1) ...[
                            if (currentDoctorStep == 1)
                              const DoctorRegistrationStepOne(),
                            if (currentDoctorStep == 2)
                              const DoctorRegistrationStepTwo(),
                            if (currentDoctorStep == 3)
                              const DoctorRegistrationStepThree(),
                            if (currentDoctorStep == 4)
                              const DoctorRegistrationStepFour(),
                          ],
                          const Gap(50),
                          selectedIndex == 0
                              ? const SizedBox()
                              : currentDoctorStep == 4
                                  ? doctorSignUpButton()
                                  : nextButton(),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AnimatedContainer buildPositionedOption(String label, double height,
      {required bool isSelected, required double screenWidth}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 125,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 100,
        height: height,
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFFFFC0CB) : const Color(0xFFF3F3F3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF36344E)
                  : const Color(0xFF9493A0),
              fontSize: 12,
              fontFamily: 'SF UI Display',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton doctorSignUpButton() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final bool isLoading = authBloc.state is AuthRegisterLoadingState;
    return ElevatedButton(
      onPressed: () {
        doctorRegistrationStepFourFormKey.currentState?.validate();

        authBloc.add(AuthRegisterDoctorEvent(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          medicalSpecialty: medicalSpecialtyController.text,
          medicalLicenseNumber: medicalLicenseNumberController.text,
          boardCertificationOrganization:
              boardCertificationOrganizationController.text,
          boardCertificationDate: boardCertificationDateController.text,
          medicalSchool: medicalSchoolController.text,
          medicalSchoolStartDate: medicalSchoolStartDateController.text,
          medicalSchoolEndDate: medicalSchoolEndDateController.text,
          residencyProgram: residencyProgramController.text,
          residencyProgramStartDate: residencyProgramStartDateController.text,
          residencyProgramGraduationYear:
              residencyProgramGraduationYearController.text,
          fellowShipProgram: fellowShipProgramController.text,
          fellowShipProgramStartDate: fellowShipProgramStartDateController.text,
          fellowShipProgramEndDate: fellowShipProgramEndDateController.text,
          officeAdress: officeAdressController.text,
          officeMapsLocationAddress: mapsLocationAddressController.text,
          officeLatLngAddress: officeLatLngAddressController.text,
          officePhoneNumber: officePhoneNumberController.text,
        ));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFC0CB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width / 1.45,
            height: 49,
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Color(0xFF36344E),
                      ),
                    )
                  : const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Color(0xFF36344E),
                        fontSize: 16,
                        fontFamily: 'SF UI Display',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  ElevatedButton nextButton() {
    return ElevatedButton(
      onPressed: () {
        if (selectedIndex == 1) {
          GlobalKey<FormState>? currentFormKey;

          switch (currentDoctorStep) {
            case 1:
              currentFormKey = doctorRegistrationStepOneFormKey;
              break;
            case 2:
              currentFormKey = doctorRegistrationStepTwoFormKey;
              break;
            case 3:
              currentFormKey = doctorRegistrationStepThreeFormKey;
              break;
            // Add more cases if you have additional steps

            default:
              break;
          }
          if (currentFormKey?.currentState?.validate() ?? false) {
            // If validation succeeds, proceed to the next step
            setState(() {
              currentDoctorStep++;
            });
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFC0CB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.45,
        height: 49,
        child: const Center(
          child: Text(
            'Next',
            style: TextStyle(
              color: Color(0xFF36344E),
              fontSize: 16,
              fontFamily: 'SF UI Display',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
