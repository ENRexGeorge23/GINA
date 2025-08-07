import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContainerDoctorDetails extends StatelessWidget {
  const ContainerDoctorDetails({
    super.key,
    required this.ginaTheme,
    required this.containerText,
    required this.containerImage,
    required this.onTap,
  });

  final ThemeData ginaTheme;
  final String containerText;
  final String containerImage;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(10),
            Image.asset(containerImage),
            Text(
              containerText,
              textAlign: TextAlign.center,
              style: ginaTheme.textTheme.headlineMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
