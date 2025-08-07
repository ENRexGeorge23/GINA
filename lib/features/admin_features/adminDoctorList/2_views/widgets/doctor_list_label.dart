import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorListLabel extends StatelessWidget {
  final BuildContext context;
  const DoctorListLabel({super.key, required this.context});

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
          const Gap(70),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.08,
            child: Text(
              'EMAIL ADDRESS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(55),
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
          const Gap(60),
          Text(
            'DATE VERIFIED',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}