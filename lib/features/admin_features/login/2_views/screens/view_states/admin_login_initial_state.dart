import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/login/2_views/bloc/admin_login_bloc.dart';
import 'package:first_app/features/auth/2_views/widgets/login_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';

class AdminLoginInitialState extends StatefulWidget {
  const AdminLoginInitialState({super.key});

  @override
  State<AdminLoginInitialState> createState() => _AdminLoginInitialStateState();
}

class _AdminLoginInitialStateState extends State<AdminLoginInitialState> {
  bool obscurePassword = true;
  TextEditingController emailAdminController = TextEditingController();
  TextEditingController passwordAdminController = TextEditingController();

  final adminFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final adminLoginBloc = context.read<AdminLoginBloc>();
    return Form(
      key: adminFormKey,
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            color: GinaAppTheme.appbarColorLight,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 1.5,
              child: Column(
                children: [
                  const Gap(30),
                  Image.asset(Images.adminLoginLogo),
                  const Gap(40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: loginFields(
                      emailController: emailAdminController,
                      passwordController: passwordAdminController,
                      obscurePassword: obscurePassword,
                      togglePasswordVisibility: _togglePasswordVisibility,
                      onSubmit: () {
                        if (adminFormKey.currentState!.validate()) {
                          adminLoginBloc.add(
                            AdminLoginEventLogin(
                              email: emailAdminController.text,
                              password: passwordAdminController.text,
                            ),
                          );
                        }
                      },
                      context: context,
                    ),
                  ),
                  const Gap(20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.45,
                    height: MediaQuery.of(context).size.height / 20,
                    child: FilledButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (adminFormKey.currentState!.validate()) {
                          adminLoginBloc.add(
                            AdminLoginEventLogin(
                              email: emailAdminController.text,
                              password: passwordAdminController.text,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: GinaAppTheme.lightOnBackground,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
}
