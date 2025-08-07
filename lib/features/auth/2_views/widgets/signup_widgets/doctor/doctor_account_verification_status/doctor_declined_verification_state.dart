import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/2_views/widgets/signup_widgets/doctor/doctor_account_verification/doctor_verification_status.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorDeclinedVerificationState extends StatelessWidget {
  final String declineReason;
  const DoctorDeclinedVerificationState(
      {super.key, required this.declineReason});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Verification Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.7,
                child: Image.asset(Images.doctorDeclinedVerification),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                initialValue: declineReason,
                readOnly: true,
                maxLines: null,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: GinaAppTheme.lightOnBackground),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const DoctorVerificationStatusScreen()),
                  );
                },
                child: Text(
                  'Resubmit Verification',
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
