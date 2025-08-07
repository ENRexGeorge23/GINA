import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/bloc/admin_dashboard_bloc.dart';
import 'package:first_app/features/admin_features/adminDoctorVerification/2_views/bloc/admin_doctor_verification_bloc.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DeclinedDoctorVerificationList extends StatelessWidget {
  final List<DoctorModel> declinedDoctorList;
  final BuildContext context;
  const DeclinedDoctorVerificationList({
    super.key,
    required this.context,
    required this.declinedDoctorList,
  });

  @override
  Widget build(BuildContext context) {
    final adminDoctorVerificationBloc =
        context.read<AdminDoctorVerificationBloc>();
    final adminDashBoardBloc = context.read<AdminDashboardBloc>();
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: GinaAppTheme.lightScrim,
          thickness: 0.2,
          height: 5,
        ),
        itemCount: declinedDoctorList.length,
        itemBuilder: (context, index) {
          final declinedDoctor = declinedDoctorList[index];
          return InkWell(
            onTap: () {
              if (isFromAdminDashboard) {
                adminDashBoardBloc.add(NavigateToDoctorDetailsDeclinedEvent(
                  declinedDoctorDetails: declinedDoctor,
                ));
              } else {
                adminDoctorVerificationBloc
                    .add(NavigateToAdminDoctorDetailsDeclinedEvent(
                  declinedDoctorDetails: declinedDoctor,
                ));
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: const VerticalDivider(
                    color: Color(0xffD14633),
                    thickness: 3,
                  ),
                ),
                Image.asset(
                  Images.doctorProfileIcon,
                  height: 30,
                  width: 30,
                ),
                const Gap(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: Text(
                    'Dr. ${declinedDoctor.name}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Gap(60),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: Text(
                    declinedDoctor.email,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(60),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.09,
                  child: Text(
                    declinedDoctor.medicalSpecialty,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(50),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.09,
                  child: Text(
                    declinedDoctor.officeAdress,
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(85),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: Text(
                    declinedDoctor.officePhoneNumber,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(70),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                  child: Text(
                    DateFormat('MM/dd/yyyy')
                        .format(declinedDoctor.created!.toDate()),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const Gap(120),
                declinedDoctor.verifiedDate == null
                    ? const SizedBox()
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.05,
                        height: MediaQuery.of(context).size.height * 0.025,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffFFE7EB),
                        ),
                        child: Center(
                          child: Text(
                            DateFormat('MM/dd/yyyy')
                                .format(declinedDoctor.verifiedDate!.toDate()),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}