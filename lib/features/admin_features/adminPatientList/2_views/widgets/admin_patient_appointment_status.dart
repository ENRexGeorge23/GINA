import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';

class AdminPatientAppointmentStatus extends StatelessWidget {
  final int appointmentStatus;
  const AdminPatientAppointmentStatus({
    super.key,
    required this.themeOfContext,
    required this.appointmentStatus,
  });

  final ThemeData themeOfContext;

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

    return Container(
      width: MediaQuery.of(context).size.width * 0.04,
      height: MediaQuery.of(context).size.height * 0.02,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: buttonColor
      ),
      child: Center(
        child: Text(buttonText,
            style: themeOfContext.textTheme.labelSmall?.copyWith(
                color: GinaAppTheme.appbarColorLight,
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
