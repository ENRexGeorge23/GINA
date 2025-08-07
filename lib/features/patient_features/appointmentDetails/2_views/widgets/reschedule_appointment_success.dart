import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Future<dynamic> showRescheduleAppointmentSuccessDialog(
  BuildContext context,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: GinaAppTheme.appbarColorLight,
      shadowColor: GinaAppTheme.appbarColorLight,
      surfaceTintColor: GinaAppTheme.appbarColorLight,
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: 80,
      ),
      content: SizedBox(
        height: 100,
        width: 300,
        child: Column(
          children: [
            Text(
              'Appointment Reschedule Success',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Gap(20),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.5,
              child: FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(
                      context, '/appointmentDetails');
                },
                child: Text(
                  'Okay',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
