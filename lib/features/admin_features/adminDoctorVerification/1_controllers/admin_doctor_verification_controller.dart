import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/doctor_verification_model.dart';
import 'package:flutter/foundation.dart';

class AdminDoctorVerificationController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late StreamSubscription authStream;
  FirebaseAuthException? error;
  bool working = false;

  Future<Either<Exception, List<DoctorModel>>> getAllDoctors() async {
    try {
      final doctorSnapshot = await firestore.collection('doctors').get();

      if (doctorSnapshot.docs.isNotEmpty) {
        final doctorList = doctorSnapshot.docs
            .map((doctor) => DoctorModel.fromJson(doctor.data()))
            .toList();

        return Right(doctorList);
      }
      return const Right([]);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      debugPrint(e.code);
      working = false;
      error = e;
      return Left(Exception(e.message));
    } catch (e) {
      debugPrint(e.toString());
      working = false;
      error = FirebaseAuthException(message: e.toString(), code: 'error');
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, List<DoctorVerificationModel>>>
      getDoctorSubmittedMedicalLicense({
    required String doctorId,
  }) async {
    try {
      final doctorSnapshot = await firestore
          .collection('doctors')
          .doc(doctorId)
          .collection('doctorSubmittedDocuments')
          .get();

      if (doctorSnapshot.docs.isNotEmpty) {
        final doctorSubmittedDocuments = doctorSnapshot.docs
            .map((doctor) => DoctorVerificationModel.fromJson(doctor.data()))
            .toList();

        // Sort the documents based on the dateSubmitted field
        doctorSubmittedDocuments
            .sort((a, b) => a.dateSubmitted.compareTo(b.dateSubmitted));

        return Right(doctorSubmittedDocuments);
      }
      return const Right([]);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      debugPrint(e.code);
      working = false;
      error = e;
      return Left(Exception(e.message));
    } catch (e) {
      debugPrint(e.toString());
      working = false;
      error = FirebaseAuthException(message: e.toString(), code: 'error');
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, bool>> approveDoctorVerification({
    required String doctorId,
    required String doctorVerificationId,
  }) async {
    try {
      await firestore
          .collection('doctors')
          .doc(doctorId)
          .collection('doctorSubmittedDocuments')
          .doc(doctorVerificationId)
          .update({
        'verificationStatus': DoctorVerificationStatus.approved.index,
      });

      await firestore.collection('doctors').doc(doctorId).update({
        'doctorVerificationStatus': DoctorVerificationStatus.approved.index,
        'isVerified': true,
        'verifiedDate': Timestamp.now(),
      });

      return const Right(true);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      debugPrint(e.code);
      working = false;
      error = e;
      return Left(Exception(e.message));
    } catch (e) {
      debugPrint(e.toString());
      working = false;
      error = FirebaseAuthException(message: e.toString(), code: 'error');
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, bool>> declineDoctorVerification({
    required String doctorId,
    required String doctorVerificationId,
    required String declineReason,
  }) async {
    try {
      await firestore
          .collection('doctors')
          .doc(doctorId)
          .collection('doctorSubmittedDocuments')
          .doc(doctorVerificationId)
          .update({
        'verificationStatus': DoctorVerificationStatus.declined.index,
        'declineReason': declineReason,
      });

      await firestore.collection('doctors').doc(doctorId).update({
        'doctorVerificationStatus': DoctorVerificationStatus.declined.index,
        'verifiedDate': Timestamp.now(),
      });

      return const Right(true);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      debugPrint(e.code);
      working = false;
      error = e;
      return Left(Exception(e.message));
    } catch (e) {
      debugPrint(e.toString());
      working = false;
      error = FirebaseAuthException(message: e.toString(), code: 'error');
      return Left(Exception(e.toString()));
    }
  }
}
