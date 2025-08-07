import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';

class DoctorVerificationStatusChip extends StatelessWidget {
  final int verificationStatus;
  const DoctorVerificationStatusChip({
    super.key,
    required this.verificationStatus,
  });

  @override
  Widget build(BuildContext context) {
    DoctorVerificationStatus status =
        DoctorVerificationStatus.values[verificationStatus];
    String buttonText;
    Color buttonColor;

    switch (status) {
      case DoctorVerificationStatus.pending:
        buttonText = 'Pending';
        buttonColor = const Color(0xffFF9839);
        break;
      case DoctorVerificationStatus.approved:
        buttonText = 'Approved';
        buttonColor = const Color(0xff33D176);
        break;

      case DoctorVerificationStatus.declined:
        buttonText = 'Declined';
        buttonColor = const Color(0xffD14633);
        break;
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.04,
      height: MediaQuery.of(context).size.height * 0.02,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: buttonColor,
      ),
      child: Center(
        child: Text(buttonText,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: GinaAppTheme.appbarColorLight,
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
