import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/doctor_features/doctorScheduleManagement/0_models/doctor_schedule_model.dart';
import 'package:flutter/material.dart';

class DoctorScheduleController with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late StreamSubscription authStream;
  User? currentUser;
  FirebaseAuthException? error;
  bool working = false;

  DoctorScheduleController() {
    authStream = auth.authStateChanges().listen((User? user) {
      currentUser = user;
      notifyListeners();
    });
  }

  Future<Either<Exception, ScheduleModel>> getDoctorSchedule() async {
    try {
      final doctorScheduleDoc =
          await firestore.collection('doctors').doc(currentUser!.uid).get();

      final data = doctorScheduleDoc.data();
      if (data != null) {
        final scheduleData = data['schedule'] ?? {};
        return Right(ScheduleModel.fromJson({
          'days': scheduleData['days'],
          'startTimes': scheduleData['startTimes'],
          'endTimes': scheduleData['endTimes'],
          'modeOfAppointment': scheduleData['modeOfAppointment'],
          'name': data['name'],
          'medicalSpecialty': data['medicalSpecialty'],
          'officeAddress': data['officeAddress']
        }));
      } else {
        return Left(Exception('No schedule found'));
      }
    } catch (e) {
      debugPrint('Error retrieving schedule: $e');
      return Left(
        Exception('Error retrieving schedule: $e'),
      );
    }
  }
}
