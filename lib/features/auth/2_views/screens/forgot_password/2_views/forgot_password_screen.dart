import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/2_views/screens/forgot_password/2_views/bloc/forgot_password_bloc.dart';
import 'package:first_app/features/auth/2_views/widgets/gina_header.dart';
import 'package:first_app/features/auth/2_views/widgets/validators_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final emailKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final forgotPasswordBloc = context.read<ForgotPasswordBloc>();
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is RequestPasswordResetSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "Password reset email sent to ${emailController.text}"),
                backgroundColor: GinaAppTheme.lightOnSecondary,
              ),
            );
          }
          if (state is RequestPasswordResetError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: GinaAppTheme.lightError,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 30),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(40),
                          const Center(child: GinaHeader(size: 60)),
                          const Gap(50),
                          Text(
                            'Forgot your Password?',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const Gap(10),
                          const Text(
                            'Enter the email address associated with your account.',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: GinaAppTheme.lightOutline,
                            ),
                          ),
                          const Gap(10),
                          const Text(
                            'We will email you a link to reset the password of your account.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                      const Gap(40),
                      Form(
                        key: emailKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email-address',
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: validateEmail,
                            ),
                            const Gap(50),
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
                                child: BlocBuilder<ForgotPasswordBloc,
                                    ForgotPasswordState>(
                                  builder: (context, state) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 10, 40, 10),
                                      child: state
                                              is RequestPasswordResetLoading
                                          ? const CircularProgressIndicator(
                                              color:
                                                  GinaAppTheme.lightOnSecondary)
                                          : const Text(
                                              "Send",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    );
                                  },
                                ),
                                onPressed: () async {
                                  if (emailKey.currentState!.validate()) {
                                    forgotPasswordBloc.add(
                                      RequestPasswordReset(
                                          email: emailController.text),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(40),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: "Remember your password? "),
                            TextSpan(
                              text: 'Login',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    Navigator.pushNamed(context, '/login'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
