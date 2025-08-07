import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';

class PendingRequestsWidget extends StatelessWidget {
  final int pendingRequests;
  const PendingRequestsWidget({super.key, required this.pendingRequests});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Image.asset(
            Images.pendingRequests,
            width: width * 0.2,
            height: height * 0.148,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 80,
          right: 0,
          top: 35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                pendingRequests == 0 ? "" : pendingRequests.toString(),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: GinaAppTheme.lightOnPrimaryColor,
                    ),
              ),
              Text(
                'Pending\nrequests',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: GinaAppTheme.lightOnPrimaryColor,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
