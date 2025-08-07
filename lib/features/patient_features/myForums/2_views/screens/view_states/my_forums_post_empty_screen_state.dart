import 'package:first_app/core/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyForumsEmptyScreenState extends StatelessWidget {
  const MyForumsEmptyScreenState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset(Images.emptyPlaceholder)),
        const Gap(150),
      ],
    );
  }
}
