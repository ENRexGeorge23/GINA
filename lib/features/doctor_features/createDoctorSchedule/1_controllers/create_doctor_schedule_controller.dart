import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:flutter/material.dart';

class CreateDoctorScheduleController with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late StreamSubscription authStream;
  User? currentUser;

  FirebaseAuthException? error;
  bool working = false;

  CreateDoctorScheduleController() {
    authStream = auth.authStateChanges().listen((User? user) {
      currentUser = user;
      notifyListeners();
    });
  }

  Future<Either<Exception, bool>> createDoctorSchedule({
    required List<int> days,
    required List<String> startTimes,
    required List<String> endTimes,
    required List<int> modeOfAppointment,
  }) async {
    try {
      DocumentReference<Map<String, dynamic>> doctorDocRef = FirebaseFirestore
          .instance
          .collection('doctors')
          .doc(currentUser!.uid);

      final currentUserModel = await doctorDocRef
          .get()
          .then((value) => UserModel.fromJson(value.data()!));

      await doctorDocRef.update({
        'schedule': {
          'days': days,
          'startTimes': startTimes,
          'endTimes': endTimes,
          'modeOfAppointment': modeOfAppointment,
          'createdDate': DateTime.now(),
          'createdBy': currentUserModel.name,
        },
      });

      return const Right(true);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      notifyListeners();
      return Left(Exception(e.message));
    }
  }
}
