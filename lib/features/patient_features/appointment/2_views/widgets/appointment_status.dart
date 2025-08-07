import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';

class AppointmentStatusContainer extends StatelessWidget {
  final int appointmentStatus;
  const AppointmentStatusContainer({
    required this.appointmentStatus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppointmentStatus status = AppointmentStatus.values[appointmentStatus];
    String buttonText;
    Color buttonColor;

    switch (status) {
      case AppointmentStatus.pending:
        buttonText = 'Pending';
        buttonColor = const Color(0xffFF9839);
        break;
      case AppointmentStatus.confirmed:
        buttonText = 'Approved';
        buttonColor = const Color(0xff33D176);
        break;
      case AppointmentStatus.completed:
        buttonText = 'Completed';
        buttonColor = GinaAppTheme.lightSecondary;
        break;
      case AppointmentStatus.cancelled:
        buttonText = 'Cancelled';
        buttonColor = GinaAppTheme.lightOutline;
        break;
      case AppointmentStatus.declined:
        buttonText = 'Declined';
        buttonColor = const Color(0xffD14633);
        break;
    }

    return SizedBox(
      height: 17,
      width: 80,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
            horizontal: 8,
          )),
        ),
        onPressed: () {},
        child: Text(buttonText,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: GinaAppTheme.lightOnTertiary)),
      ),
    );
  }
}
