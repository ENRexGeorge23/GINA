import 'package:flutter/material.dart';

class ConsultationLoadingAppointmentState extends StatelessWidget {
  const ConsultationLoadingAppointmentState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator.adaptive(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Loading",
            ),
          ),
        ],
      ),
    );
  }
}
