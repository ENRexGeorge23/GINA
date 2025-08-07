import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/0_model/emergency_announcements_model.dart';
import 'package:first_app/features/patient_features/emergencyAnnouncements/2_views/bloc/emergency_announcements_bloc.dart';
import 'package:flutter/material.dart';

class EmergencyAnnouncementsController with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late StreamSubscription authStream;
  User? currentPatient;
  FirebaseAuthException? error;
  bool working = false;

  EmergencyAnnouncementsController() {
    authStream = auth.authStateChanges().listen((User? user) {
      currentPatient = user;
      notifyListeners();
    });
  }

  Future<Either<Exception, EmergencyAnnouncementModel>>
      getNearestEmergencyAnnouncement() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('emergencyAnnouncements')
          .where('patientUid', isEqualTo: currentPatient!.uid)
          .orderBy('createadAt', descending: true)
          .limit(1)
          .get();

      final doctorModel = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(snapshot.docs.first.data()['doctorUid'])
          .get()
          .then((value) => DoctorModel.fromJson(value.data()!));

      docterMedicalSpeciality = doctorModel.medicalSpecialty;

      if (snapshot.docs.isEmpty) {
        return Right(EmergencyAnnouncementModel.empty);
      }

      EmergencyAnnouncementModel announcement =
          EmergencyAnnouncementModel.fromJson(snapshot.docs.first.data());

      return Right(announcement);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      return Left(Exception(e.message));
    }
  }
}
