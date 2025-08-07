import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorConsultationFeeController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late StreamSubscription authStream;
  User? currentUser;
  FirebaseAuthException? error;
  bool working = false;

  DoctorConsultationFeeController() {
    authStream = auth.authStateChanges().listen((User? user) {
      currentUser = user;
    });
  }

  Future<Either<Exception, DoctorModel>> getCurrentDoctor() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('doctors')
              .doc(currentUser!.uid)
              .get();

      DoctorModel doctorModel = DoctorModel.fromJson(userSnapshot.data()!);

      return Right(doctorModel);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      return Left(Exception(e.message));
    }
  }

  Future<void> toggleDoctorConsultationPriceFee() async {
    try {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(currentUser!.uid)
          .get()
          .then((DocumentSnapshot<Map<String, dynamic>> userSnapshot) async {
        // Get the current value of the showConsultationPrice field
        bool currentShowConsultationPrice =
            userSnapshot.data()!['showConsultationPrice'];

        // Update the showConsultationPrice field with the opposite value
        await FirebaseFirestore.instance
            .collection('doctors')
            .doc(currentUser!.uid)
            .update({'showConsultationPrice': !currentShowConsultationPrice});
      });
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      working = false;
      error = e;
      throw Exception(e.message);
    } catch (e) {
      debugPrint('Error editing doctor data: $e');
      working = false;
      error = FirebaseAuthException(
        code: 'unknown',
        message: e.toString(),
      );
      throw Exception(e.toString());
    }
  }

  Future<void> updateDoctorConsultationFee({
    required double f2fFollowUpConsultationPrice,
    required double f2fInitialConsultationPrice,
    required double olFollowUpConsultationPrice,
    required double olInitialConsultationPrice,
  }) async {
    try {
      working = true;

      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(currentUser!.uid)
          .update({
        'f2fFollowUpConsultationPrice': f2fFollowUpConsultationPrice,
        'f2fInitialConsultationPrice': f2fInitialConsultationPrice,
        'olFollowUpConsultationPrice': olFollowUpConsultationPrice,
        'olInitialConsultationPrice': olInitialConsultationPrice,
      });
      working = false;
      error = null;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      working = false;
      error = e;
      throw Exception(e.message);
    } catch (e) {
      debugPrint('Error editing doctor data: $e');
      working = false;
      error = FirebaseAuthException(
        code: 'unknown',
        message: e.toString(),
      );
      throw Exception(e.toString());
    }
  }
}
