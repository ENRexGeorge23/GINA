import 'package:first_app/core/resources/images.dart';
import 'package:flutter/material.dart';

class DoctorWaitingForApprovalState extends StatelessWidget {
  const DoctorWaitingForApprovalState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Verification Status'),
      ),
      body: Center(
        child: Image.asset(Images.doctorWaitingForApproval),
      ),
    );
  }
}
