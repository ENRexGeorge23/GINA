import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminDashboard/2_views/bloc/admin_dashboard_bloc.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DashboardSummaryContainers extends StatelessWidget {
  final List<DoctorModel> doctors;
  final List<UserModel> patients;

  const DashboardSummaryContainers({
    super.key,
    required this.doctors,
    required this.patients,
  });

  @override
  Widget build(BuildContext context) {
    final adminDashboardBloc = context.read<AdminDashboardBloc>();
    final patientCount = patients.length;
    final approvedDoctorCount = doctors
        .where((element) =>
            element.doctorVerificationStatus ==
            DoctorVerificationStatus.approved.index)
        .length;

    final pendingDoctorCount = doctors
        .where((element) =>
            element.doctorVerificationStatus ==
            DoctorVerificationStatus.pending.index)
        .length;

    final appointsBookedCount = patients.fold(
        0, (prev, patient) => prev + (patient.appointmentsBooked.length));
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            adminDashboardBloc.add(PendingDoctorVerificationListEvent());
          },
          child: FittedBox(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.12,
              height: MediaQuery.of(context).size.height * 0.14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffF5E0CD),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.pendingDoctorVerification,
                    width: MediaQuery.of(context).size.width * 0.05,
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  const Gap(20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pending\nDoctor\nVerification',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.0075,
                        ),
                      ),
                      const Gap(3),
                      Text(
                        pendingDoctorCount.toString(),
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.014,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(15),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: const VerticalDivider(
            color: GinaAppTheme.lightScrim,
            thickness: 0.1,
          ),
        ),
        const Gap(15),
        InkWell(
          onTap: () {
            adminDashboardBloc.add(ApprovedDoctorVerificationListEvent());
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.12,
            height: MediaQuery.of(context).size.height * 0.14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: GinaAppTheme.lightPrimaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.totalVerifiedDoctors,
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const Gap(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total\nVerified\nDoctors  ',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.0075,
                      ),
                    ),
                    const Gap(3),
                    Text(
                      approvedDoctorCount.toString(),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.014,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Gap(20),
        InkWell(
          onTap: () {
            adminDashboardBloc
                .add(AdminDashboardNavigatetoListofAllPatientsEvent());
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.12,
            height: MediaQuery.of(context).size.height * 0.14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffCCEBD9),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.totalPatients,
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const Gap(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total\nPatients   ',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.0075,
                      ),
                    ),
                    const Gap(3),
                    Text(
                      patientCount.toString(),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.014,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Gap(20),
        InkWell(
          onTap: () {
            adminDashboardBloc
                .add(AdminDashboardNavigatetoListofAllAppointmentsEvent());
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.12,
            height: MediaQuery.of(context).size.height * 0.14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffE3CDF5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.totalAppoinmentsBooked,
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const Gap(15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total\nAppointments\nBooked',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.0075,
                      ),
                    ),
                    const Gap(3),
                    Text(
                      appointsBookedCount.toString(),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.014,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
