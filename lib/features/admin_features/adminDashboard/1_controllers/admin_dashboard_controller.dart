import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AdminDashboardController {
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

  Future<Either<Exception, List<UserModel>>> getAllPatients() async {
    try {
      final patientSnapshot = await firestore.collection('patients').get();

      if (patientSnapshot.docs.isNotEmpty) {
        final patientList = patientSnapshot.docs
            .map((doctor) => UserModel.fromJson(doctor.data()))
            .toList();
        return Right(patientList);
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

  Future<Either<Exception, List<AppointmentModel>>> getAllAppointments() async {
    try {
      final appointmentSnapshot =
          await firestore.collection('appointments').get();

      if (appointmentSnapshot.docs.isNotEmpty) {
        final appointmentList = appointmentSnapshot.docs
            .map((appointment) => AppointmentModel.fromJson(appointment.data()))
            .toList();

        // Sort the appointments by date
        appointmentList.sort((a, b) => DateFormat('MMMM d, yyyy')
            .parse(a.appointmentDate!)
            .compareTo(DateFormat('MMMM d, yyyy').parse(b.appointmentDate!)));

        return Right(appointmentList);
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

  //-----------------Get All Doctor Appointments DRAFT-------------------
  Future<Either<Exception, List<AppointmentModel>>>
      getCurrentDoctorAppointment({
    required doctorUid,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('doctorUid', isEqualTo: doctorUid)
          .get();

      List<AppointmentModel> appointments = [];

      for (var element in snapshot.docs) {
        appointments.add(AppointmentModel.fromDocumentSnap(element));
      }

      appointments.sort((a, b) {
        var aDate = DateFormat('MMMM dd, yyyy').parse(a.appointmentDate!);
        var bDate = DateFormat('MMMM dd, yyyy').parse(b.appointmentDate!);
        return aDate.compareTo(bDate);
      });

      return Right(appointments);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      return Left(Exception(e.message));
    }
  }
  //-----------------Logout Admin-------------------

  Future<void> logoutAdmin() async {
    try {
      await auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      error = FirebaseAuthException(message: e.toString(), code: 'error');
    }
  }
}