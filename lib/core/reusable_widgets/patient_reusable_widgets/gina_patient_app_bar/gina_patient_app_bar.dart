// ignore_for_file: must_be_immutable

import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/floating_menu_bar/2_views/floating_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GinaPatientAppBar extends StatelessWidget implements PreferredSizeWidget {
  GinaPatientAppBar({
    required this.title,
    this.leading,
    super.key,
  });
  Widget? leading;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
      ),
      actions: const [
        FloatingMenuWidget(),
        Gap(10),
      ],
      notificationPredicate: (notification) => false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
