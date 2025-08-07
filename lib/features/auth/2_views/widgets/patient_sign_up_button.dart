import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/2_views/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.dobController,
    required this.selectedGender,
    required this.patientRegistrationFormKey,

    required this.addressController,

  });
  final GlobalKey<FormState> patientRegistrationFormKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController dobController;
  final TextEditingController addressController;

  final String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final authBloc = context.read<AuthBloc>();
        final bool isLoading = authBloc.state is AuthRegisterLoadingState;
        return ElevatedButton(
          onPressed: () async {
            if (patientRegistrationFormKey.currentState?.validate() ?? false) {
              final name = nameController.text;
              final email = emailController.text;
              final password = passwordController.text;
              final dateOfBirth = dobController.text;
              final gender = selectedGender!;

              authBloc.add(
                AuthRegisterPatientEvent(
                  name: name,
                  email: email,
                  password: password,
                  dateOfBirth: dateOfBirth,
                  gender: gender,
                  address: addressController.text,
                ),
              );
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
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: GinaAppTheme.lightOnBackground))
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
          ),
        );
      },
    );
  }
}
