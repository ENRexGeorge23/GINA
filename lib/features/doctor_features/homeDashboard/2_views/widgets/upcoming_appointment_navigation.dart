import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UpcomingAppointmentsWidget extends StatelessWidget {
  final int confirmedAppointments;
  const UpcomingAppointmentsWidget(
      {super.key, required this.confirmedAppointments});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // const Gap(10),
        Image.asset(
          Images.upcomingAppointments,
          fit: BoxFit.cover,
          height: height * 0.28,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 128,
          child: Container(
            width: width * 0.45,
            height: height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(10),
                Text(
                  confirmedAppointments == 0
                      ? ""
                      : confirmedAppointments.toString(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        // fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: GinaAppTheme.lightTertiaryContainer,
                      ),
                ),
                const Gap(10),
                Text(
                  'Upcoming\nappointments',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: GinaAppTheme.lightOnPrimaryColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
