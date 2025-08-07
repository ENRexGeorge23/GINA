import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/bloc/appointment_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

Future<dynamic> showCancelModalDialog(BuildContext context,
    {required String appointmentId}) {
  final appointmnetDetailBloc = context.read<AppointmentDetailsBloc>();
  final appointmnetBloc = context.read<AppointmentBloc>();
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
        height: 190,
        width: 330,
        child: Column(
          children: [
            Text(
              'Are you sure you want to cancel\n your appointment?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
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
                    if (isFromAppointmentTabs) {
                      isFromAppointmentTabs = false;
                      appointmnetBloc.add(
                        CancelAppointmentInAppointmentTabsEvent(
                            appointmentUid: appointmentId),
                      );
                      Navigator.of(context).pop();
                    } else {
                      appointmnetDetailBloc.add(
                        CancelAppointmentEvent(appointmentUid: appointmentId),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'Yes',
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
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
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
