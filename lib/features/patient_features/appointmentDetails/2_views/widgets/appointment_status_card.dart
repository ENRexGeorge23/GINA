import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppointmentStatusCard extends StatelessWidget {
  final int appointmentStatus;
  const AppointmentStatusCard({
    super.key,
    required this.appointmentStatus,
  });

  @override
  Widget build(BuildContext context) {
    AppointmentStatus status = AppointmentStatus.values[appointmentStatus];
    String buttonText;
    Color buttonColor;
    String statusText;

    switch (status) {
      case AppointmentStatus.pending:
        buttonText = 'Pending';
        buttonColor = const Color(0xffFF9839);
        statusText = 'Your appointment is waiting for approval.';
        break;
      case AppointmentStatus.confirmed:
        buttonText = 'Approved';
        buttonColor = const Color(0xff33D176);
        statusText = 'Your appointment has been approved.';
        break;
      case AppointmentStatus.completed:
        buttonText = 'Completed';
        buttonColor = GinaAppTheme.lightSecondary;
        statusText = 'Your appointment is finished.';
        break;
      case AppointmentStatus.cancelled:
        buttonText = 'Cancelled';
        buttonColor = GinaAppTheme.lightOutline;
        statusText = 'You cancelled your appointment.';
        break;
      case AppointmentStatus.declined:
        buttonText = 'Declined';
        buttonColor = const Color(0xffD14633);
        statusText = 'Your appointment has been declined.';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.09,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Status',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: GinaAppTheme.lightOutline,
                      ),
                ),
                const Gap(10),
                SizedBox(
                  height: 17,
                  width: 70,
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(buttonColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.symmetric(
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
                ),
                const Gap(20),
              ],
            ),
            const Gap(5),
            Text(statusText, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
