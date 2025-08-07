import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileUpdatingStatus extends StatelessWidget {
  const ProfileUpdatingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: GinaAppTheme.appbarColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 250,
        width: 200,
        padding: const EdgeInsets.all(15.0),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Gap(30),
            Text(
              'Updating Profile...',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
