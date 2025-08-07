import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentChatController with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> chatStatusDecider({
    required String appointmentId,
  }) async {
    if (appointmentId.isEmpty) {
      return 'invalid';
    }
    final appointmentSnapshot =
        await _firestore.collection('appointments').doc(appointmentId).get();
    final appointmentData = appointmentSnapshot.data();

    if (appointmentData != null) {
      final String appointmentDate = appointmentData['appointmentDate'];
      final String appointmentTime = appointmentData['appointmentTime'];
      final int appointmentStatus = appointmentData['appointmentStatus'];
      final int modeOfAppointment = appointmentData['modeOfAppointment'];

      storedAppointmentTime = appointmentTime;

      // Parse appointment date and time
      final DateFormat dateFormat = DateFormat("MMMM d, yyyy h:mm a");
      final List<String> times = appointmentTime.split(" - ");
      final DateTime startTime =
          dateFormat.parse("$appointmentDate ${times[0]}");
      final DateTime endTime = dateFormat.parse("$appointmentDate ${times[1]}");

      // Subtract 15 minutes from the start time
      final DateTime preAppointmentTime =
          startTime.subtract(const Duration(minutes: 15));

      // Get current time
      final DateTime now = DateTime.now();

// TODO
      // check nato conditions kung unsay state sa appointment
      if (appointmentStatus == 1 && modeOfAppointment == 0) {
        if (now.isAfter(startTime) && now.isBefore(endTime)) {
          return 'canChat';
        } else if (now.isAfter(preAppointmentTime) && now.isBefore(startTime)) {
          return 'waitingForTheAppointment';
        } else if (now.isBefore(startTime)) {
          return 'appointmentIsNotStartedYet';
        } else if (now.isAfter(endTime)) {
          return 'chatIsFinished';
        }
      } else {
        return 'invalid';
      }
    }

    return 'invalid';
  }
}
