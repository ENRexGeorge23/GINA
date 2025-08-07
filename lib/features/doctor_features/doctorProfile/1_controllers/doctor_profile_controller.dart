import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorProfileController with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late StreamSubscription authStream;
  User? currentUser;
  FirebaseAuthException? error;
  bool working = false;

  DoctorProfileController() {
    authStream = auth.authStateChanges().listen((User? user) {
      currentUser = user;
      notifyListeners();
    });
  }

  Future<String> getCurrentDoctorName() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('doctors')
              .doc(currentUser!.uid)
              .get();

      DoctorModel userModel = DoctorModel.fromJson(userSnapshot.data()!);

      return userModel.name;
    } catch (e) {
      throw Exception('Failed to get current user\'s name: ${e.toString()}');
    }
  }

  Future<Either<Exception, DoctorModel>> getDoctorProfile() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('doctors')
              .doc(currentUser!.uid)
              .get();

      DoctorModel userModel = DoctorModel.fromJson(userSnapshot.data()!);

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      notifyListeners();
      return Left(Exception(e.message));
    }
  }

  Future<void> editDoctorData({
    required String name,
    required String phoneNo,
    required String address,
  }) async {
    try {
      working = true;
      notifyListeners();

      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(currentUser!.uid)
          .update({
        'name': name,
        'officePhoneNumber': phoneNo,
        'officeAddress': address,
        'updated': Timestamp.now(),
      });
      working = false;
      notifyListeners();
      error = null;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      working = false;
      error = e;
      notifyListeners();
      throw Exception(e.message);
    } catch (e) {
      debugPrint('Error editing doctor data: $e');
      working = false;
      error = FirebaseAuthException(
        code: 'unknown',
        message: e.toString(),
      );
      notifyListeners();
      throw Exception(e.toString());
    }
  }
}
