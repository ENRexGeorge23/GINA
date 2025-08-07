import 'package:first_app/core/resources/images.dart';
import 'package:first_app/features/auth/2_views/widgets/gina_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashScreenInitial extends StatelessWidget {
  const SplashScreenInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                Images.appLogo,
                width: 500,
                fit: BoxFit.contain,
              ),
            ),
            const GinaHeader(size: 60),
            const Gap(15),
            const SizedBox(
              width: 100,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFC0CB)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
