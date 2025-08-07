import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/pendingState/bloc/pending_request_state_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

Future<dynamic> showConfirmingPendingRequestDialog(BuildContext context,
    {required String appointmentId}) {
  final pendingRequestStateBloc = context.read<PendingRequestStateBloc>();

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: GinaAppTheme.appbarColorLight,
      shadowColor: GinaAppTheme.appbarColorLight,
      surfaceTintColor: GinaAppTheme.appbarColorLight,
      icon: Image.asset(
        Images.questionMark,
        height: 60,
        width: 60,
        fit: BoxFit.contain,
      ),
      content: SizedBox(
        height: 250,
        width: 330,
        child: Column(
          children: [
            Text(
              'Please confirm your action.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const Gap(20),
                  Text(
                    '• Approving this appointment request will add it to your schedule.',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(10),
                  Text(
                    '• Declining will inform the patient that their request has been cancelled.',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
            const Gap(30),
            SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.7,
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    pendingRequestStateBloc.add(
                        ApproveAppointmentEvent(appointmentId: appointmentId));
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Approve',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                )),
            const Gap(10),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.7,
              child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    pendingRequestStateBloc.add(
                        DeclineAppointmentEvent(appointmentId: appointmentId));
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Decline',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  )),
            ),
          ],
        ),
      ),
    ),
  );
}
