import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';

class ConsultationFeeDetailsController with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late StreamSubscription authStream;
  User? currentPatient;
  FirebaseAuthException? error;
  bool working = false;

  ConsultationFeeDetailsController() {
    authStream = auth.authStateChanges().listen((User? user) {
      currentPatient = user;
    });
  }

  Future<bool> getConsultationFeeData() async {
    try {
      // Get the document snapshot
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await firestore.collection('doctors').doc(doctorDetails!.uid).get();

      // Get the current value of the showConsultationFee field
      bool currentShowConsultationFee =
          userSnapshot.data()!['showConsultationPrice'];

      // Return the value
      return currentShowConsultationFee;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      rethrow;
    }
  }
}
