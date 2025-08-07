import 'package:first_app/core/resources/images.dart';
import 'package:first_app/features/auth/2_views/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorApprovedVerificationState extends StatelessWidget {
  const DoctorApprovedVerificationState({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Verification Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.doctorApprovedVerification),
            const Gap(150),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {
                  authBloc.add(ChangeWaitingForApprovalEvent());
                  Navigator.pushReplacementNamed(
                      context, '/doctorBottomNavigation');
                },
                child: Text(
                  'Proceed to Dashboard',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
