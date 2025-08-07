// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorBadge extends StatelessWidget {
  const DoctorBadge({
    super.key,
    required this.badgeName,
    this.badgeBgColor,
    this.badgeTextColor,
  });

  final String badgeName;
  final Color? badgeBgColor;
  final Color? badgeTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: badgeBgColor?.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 3.0, 8.0, 3.0),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Make the Row take the minimum space that it needs
          children: [
            CircleAvatar(
              radius: 6,
              backgroundColor: badgeTextColor?.withOpacity(0.25),
              child: Icon(
                Icons.star_rounded,
                color: badgeTextColor,
                size: 10,
              ),
            ),
            const Gap(5),
            Text(
              badgeName,
              style: TextStyle(
                  color: badgeTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
