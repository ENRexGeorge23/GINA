import 'package:first_app/features/admin_features/adminDashboard/2_views/bloc/admin_dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TableLabelContainer extends StatelessWidget {
  final BuildContext context;
  const TableLabelContainer({
    super.key,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.035,
      width: double.infinity,
      color: const Color(0xffFFE7EB),
      child: Row(
        children: [
          const Gap(80),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.08,
            child: Text(
              'NAME',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(60),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.08,
            child: Text(
              'EMAIL ADDRESS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(50),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.08,
            child: Text(
              'MEDICAL SPECIALITY',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(70),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.09,
            child: Text(
              'OFFICE ADDRESS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(55),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.08,
            child: Text(
              'CONTACT NUMBER',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(60),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.08,
            child: Text(
              'DATE REGISTERED',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(55),
          BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
            builder: (context, state) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
                child: state is PendingDoctorVerificationListState
                    ? Text(
                        'DATE SUBMITTED',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      )
                    : state is ApprovedDoctorVerificationListState
                        ? Text(
                            '      DATE VERIFIED',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        : state is DeclinedDoctorVerificationListState
                            ? Text(
                                'DATE DECLINED',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              )
                            : Text(
                                'DATE SUBMITTED',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
              );
            },
          ),
        ],
      ),
    );
  }
}
