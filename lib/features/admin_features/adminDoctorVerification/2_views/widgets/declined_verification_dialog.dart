import 'package:first_app/features/admin_features/adminDashboard/2_views/bloc/admin_dashboard_bloc.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/2_views/bloc/admin_doctor_verification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/theme/theme_service.dart';

Future<dynamic> declinedVerificationDialog(
  BuildContext context,
  TextEditingController declineReasonController,
  String doctorId,
  String doctorVerificationId,
) {
  TextEditingController declineReasonController = TextEditingController();
  final adminDoctorVerificationBloc =
      context.read<AdminDoctorVerificationBloc>();
  final adminDashBoardBloc = context.read<AdminDashboardBloc>();
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: GinaAppTheme.appbarColorLight,
      shadowColor: GinaAppTheme.appbarColorLight,
      surfaceTintColor: GinaAppTheme.appbarColorLight,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.35,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cancel_rounded,
                  color: GinaAppTheme.lightError,
                  size: 80,
                ),
                const Gap(30),
                Text(
                  'Doctor Verification Declined',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Gap(15),
                Text(
                  'Please provide a reason for declining the verification:',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: GinaAppTheme.lightOutline),
                ),
                const Gap(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: TextFormField(
                    controller: declineReasonController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Type here...',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: GinaAppTheme.lightOutline),
      
                    ),
                  ),
                ),
                const Gap(40),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: FilledButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (isFromAdminDashboard) {
                          adminDashBoardBloc.add(AdminDashboardDeclineEvent(
                              doctorId: doctorId,
                              doctorVerificationId: doctorVerificationId,
                              declinedReason: declineReasonController.text));
                        } else {
                          adminDoctorVerificationBloc.add(
                              AdminDoctorVerificationDeclineEvent(
                                  doctorId: doctorId,
                                  doctorVerificationId: doctorVerificationId,
                                  declinedReason:
                                      declineReasonController.text));
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Ok',
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
