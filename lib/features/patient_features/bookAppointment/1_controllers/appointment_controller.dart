import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentController with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late StreamSubscription authStream;
  User? currentPatient;
  FirebaseAuthException? error;
  bool working = false;

  AppointmentController() {
    authStream = auth.authStateChanges().listen((User? user) {
      currentPatient = user;
      notifyListeners();
    });
  }

  Future<Either<Exception, String>> requestAnAppointment(
      {required String doctorId,
      required String doctorName,
      required String doctorClinicAddress,
      required String appointmentDate,
      required String appointmentTime,
      required int modeOfAppointment}) async {
    try {
      final currentUserModel = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentPatient!.uid)
          .get()
          .then((value) => UserModel.fromJson(value.data()!));
      DocumentReference<Map<String, dynamic>> snap =
          FirebaseFirestore.instance.collection('appointments').doc();
      await snap.set({
        'appointmentUid': snap.id,
        'patientUid': currentPatient!.uid,
        'patientName': currentUserModel.name,
        'doctorName': doctorName,
        'doctorClinicAddress': doctorClinicAddress,
        'doctorUid': doctorId,
        'appointmentDate': appointmentDate,
        'appointmentTime': appointmentTime,
        'modeOfAppointment': modeOfAppointment,
        'appointmentStatus': 0,
      });

      final docRef = FirebaseFirestore.instance
          .collection('patients')
          .doc(currentPatient!.uid);

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        List<String> doctorsBookedForAppt = List<String>.from(
            docSnapshot.data()!['doctorsBookedForAppt'] ?? []);

        if (!doctorsBookedForAppt.contains(doctorId)) {
          await docRef.update({
            'doctorsBookedForAppt': FieldValue.arrayUnion([doctorId])
          });
        }
      }

      // Add appointment UID to the list
      List<String> appointments =
          List<String>.from(docSnapshot.data()!['appointments'] ?? []);
      if (!appointments.contains(snap.id)) {
        await docRef.update({
          'appointmentsBooked': FieldValue.arrayUnion([snap.id])
        });
      }

      return Right(snap.id);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      notifyListeners();
      return Left(Exception(e.message));
    }
  }

//-----------------------GET CURRENT PATIENT APPOINTMENTS---------------------------------
  Future<Either<Exception, List<AppointmentModel>>>
      getCurrentPatientAppointment() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('patientUid', isEqualTo: currentPatient!.uid)
          .get();

      List<AppointmentModel> appointments = [];

      for (var element in snapshot.docs) {
        appointments.add(AppointmentModel.fromDocumentSnap(element));
      }

      appointments.sort((a, b) {
        final aDate = DateFormat('MMMM d, yyyy').parse(a.appointmentDate!);
        final bDate = DateFormat('MMMM d, yyyy').parse(b.appointmentDate!);
        return bDate.compareTo(
            aDate); // Change to `aDate.compareTo(bDate)` for oldest to newest
      });

      return Right(appointments);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      notifyListeners();
      return Left(Exception(e.message));
    }
  }

  // -----------------------GET Recent Patient Pending/Cancelled/Completed/Declined Appointment For the Appointment Details in Doctor Details Screen  ---------------------------------
  Future<Either<Exception, AppointmentModel>> getRecentPatientAppointment({
    required String doctorUid,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('patientUid', isEqualTo: currentPatient!.uid)
          .where('doctorUid', isEqualTo: doctorUid)
          .where('appointmentStatus', isNotEqualTo: 2)
          .get();

      if (snapshot.docs.isEmpty) {
        return Right(AppointmentModel());
      }

      final docs = snapshot.docs.map((doc) {
        final model = AppointmentModel.fromDocumentSnap(doc);
        // Parse the date string to a DateTime object
        model.appointmentDate = DateFormat('MMMM d, yyyy')
            .format(DateFormat('MMMM d, yyyy').parse(model.appointmentDate!));
        return model;
      }).toList();

      // Sort the appointments by date in descending order
      docs.sort((a, b) => a.appointmentDate!.compareTo(b.appointmentDate!));

      return Right(docs.first);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      notifyListeners();
      return Left(Exception(e.message));
    }
  }

  // -----------------------GET Recent Patient Pending/Cancelled/Completed/Declined Appointment For the Appointment Details in Appointments Tab---------------------------------
  Future<Either<Exception, AppointmentModel>> getAppointmentDetails({
    required String appointmentUid,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentUid)
          .get();

      final appointmentDetails = AppointmentModel.fromDocumentSnap(snapshot);

      return Right(
        appointmentDetails,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      notifyListeners();
      return Left(Exception(e.message));
    }
  }

  //--------------GET Completed Appointment by AppointmentUID for Consultation History-------------------

  Future<Either<Exception, AppointmentModel>> getCompletedAppointment(
      {required String appointmentUid}) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentUid)
          .get();

      final appointmentModel = AppointmentModel.fromDocumentSnap(snapshot);

      return Right(appointmentModel);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      notifyListeners();
      return Left(Exception(e.message));
    }
  }

  //----------------------------------Cancel Appointment-----------------------------------
  Future<Either<Exception, bool>> cancelAppointment(
      {required String appointmentUid}) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentUid)
          .update({'appointmentStatus': 3});
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      notifyListeners();
      return Left(Exception(e.message));
    }
  }
  //--------------------------Reschedule Appointment -----------------------------------

  Future<Either<Exception, bool>> rescheduleAppointment(
      {required String appointmentUid,
      required String appointmentDate,
      required String appointmentTime,
      required int modeOfAppointment}) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentUid)
          .update({
        'appointmentDate': appointmentDate,
        'appointmentTime': appointmentTime,
        'appointmentStatus': 0,
        'modeOfAppointment': modeOfAppointment
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
  //------------------------Get Doctor Details by Doctor UID --------------------------------

  Future<Either<Exception, DoctorModel>> getDoctorDetail(
      {required String doctorUid}) async {
    try {
      final doctorSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctorUid)
          .get();

      final doctorModel = DoctorModel.fromJson(doctorSnapshot.data()!);

      return Right(doctorModel);
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
  //---------------Upload Prescription Images-----------------------------------

  Future<Either<Exception, List<String>>> uploadPrescriptionImages({
    required String appointmentUid,
    required List<File> images,
  }) async {
    List<String> downloadUrls = [];
    try {
      for (var image in images) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('prescriptionImages')
            .child(appointmentUid)
            .child(image.path.split('/').last);
        await ref.putFile(image);

        final uploadTask = ref.putFile(image);
        final taskSnapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();

        downloadUrls.add(downloadUrl);

        if (downloadUrls.isEmpty) {
          return const Right([]);
        }

        await FirebaseFirestore.instance
            .collection('appointments')
            .doc(appointmentUid)
            .update({
          'prescriptionImages': FieldValue.arrayUnion([downloadUrl])
        });
      }

      return Right(downloadUrls);
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

  //---------------Get Appointment Prescription Images -----------------------------------

  Future<Either<Exception, List<String>>> getPrescriptionImages({
    required String appointmentUid,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentUid)
          .get();

      // Check if the 'prescriptionImages' field is null or empty
      if (snapshot.data() == null ||
          snapshot.data()!['prescriptionImages'] == null ||
          (snapshot.data()!['prescriptionImages'] as List).isEmpty) {
        return const Right([]);
      }

      final List<String> images =
          List<String>.from(snapshot.data()!['prescriptionImages']);

      return Right(images);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      debugPrint(e.code);
      return Left(Exception(e.message));
    } catch (e) {
      debugPrint(e.toString());
      return Left(Exception(e.toString()));
    }
  }
}
