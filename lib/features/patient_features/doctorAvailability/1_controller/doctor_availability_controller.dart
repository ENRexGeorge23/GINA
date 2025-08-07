import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/patient_features/doctorAvailability/0_model/doctor_availability_model.dart';
import 'package:flutter/material.dart';

class DoctorAvailabilityController with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late StreamSubscription authStream;
  User? currentPatient;
  FirebaseAuthException? error;
  bool working = false;
  
  Future<Either<Exception, DoctorAvailabilityModel>> getDoctorAvailability(
      {required String doctorId}) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doctorDocument =
          await firestore.collection('doctors').doc(doctorId).get();
      final Map<String, dynamic>? scheduleData =
          doctorDocument.data()?['schedule'];
      if (scheduleData == null) {
        return const Right(DoctorAvailabilityModel(
          days: [],
          startTimes: [],
          endTimes: [],
          modeOfAppointment: [],
        ));
      }
      final DoctorAvailabilityModel doctorAvailabilityModel =
          DoctorAvailabilityModel.fromJson(scheduleData);
      return Right(doctorAvailabilityModel);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      notifyListeners();
      return Left(Exception(e.message));
    }
  }
}
