import 'package:first_app/core/resources/images.dart';
import 'package:flutter/material.dart';

class EmergencyAnnouncementEmptyState extends StatelessWidget {
  const EmergencyAnnouncementEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Images.noEmergencyAnnouncementImage,
          ),
        ],
      ),
    );
  }
}
