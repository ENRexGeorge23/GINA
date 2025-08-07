// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:first_app/core/theme/theme_service.dart';

class BadgesList extends StatelessWidget {
  const BadgesList({
    super.key,
    required this.badgeName,
    required this.badgeDescription,
    required this.badgeColor,
  });

  final String badgeName;
  final String badgeDescription;
  final Color? badgeColor;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: GinaAppTheme.lightOnTertiary,
      ),
      height: height * 0.15,
      width: width * 0.28,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: badgeColor?.withOpacity(0.25),
              child: Icon(
                Icons.star_rounded,
                size: 30,
                color: badgeColor,
              ),
            ),
            const Gap(5),
            Text(
              badgeName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: badgeColor,
                  ),
            ),
            const Gap(5),
            Text(
              badgeDescription,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }
}
