import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:first_app/features/patient_features/consultation/0_model/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorEConsultController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late StreamSubscription authStream;
  User? currentDoctor;
  FirebaseAuthException? error;
  bool working = false;

  DoctorEConsultController() {
    authStream = auth.authStateChanges().listen((User? user) {
      currentDoctor = user;
    });
  }
  Future<Either<Exception, AppointmentModel>>
      getUpcomingDoctorAppointments() async {
    try {
      QuerySnapshot<Map<String, dynamic>> appointmentSnapshot = await firestore
          .collection('appointments')
          .where('doctorUid', isEqualTo: currentDoctor!.uid)
          .where('appointmentStatus',
              isEqualTo: AppointmentStatus.confirmed.index)
          .where('modeOfAppointment',
              isEqualTo: ModeOfAppointmentId.onlineConsultation.index)
          .get();

      var patientAppointment = appointmentSnapshot.docs
          .map((doc) => AppointmentModel.fromJson(doc.data()))
          .toList()
        ..sort((a, b) {
          final aDate = DateFormat('MMMM d, yyyy').parse(a.appointmentDate!);
          final bDate = DateFormat('MMMM d, yyyy').parse(b.appointmentDate!);
          return aDate
              .difference(DateTime.now())
              .abs()
              .compareTo(bDate.difference(DateTime.now()).abs());
        });

      if (patientAppointment.isNotEmpty) {
        return Right(patientAppointment.first);
      } else {
        return Right(AppointmentModel());
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      return Left(Exception(e.message));
    }
  }

  Future<Either<Exception, List<ChatMessageModel>>>
      getDoctorChatroomsAndMessages() async {
    try {
      QuerySnapshot<Map<String, dynamic>> chatroomSnapshot = await firestore
          .collection('consultation-chatrooms')
          .where('members', arrayContains: currentDoctor!.uid)
          .get();

      var chatroomDocs = chatroomSnapshot.docs;
      List<Future<ChatMessageModel?>> chatroomMessagesFutures =
          chatroomDocs.map((chatroomDoc) async {
        QuerySnapshot<Map<String, dynamic>> messagesSnapshot = await firestore
            .collection('consultation-chatrooms')
            .doc(chatroomDoc.id)
            .collection('messages')
            .orderBy('createdAt',
                descending:
                    true) // Order by 'createdAt' field in descending order
            .get();

        // Filter out the doctor's messages and convert the remaining messages to ChatMessageModel
        List<ChatMessageModel> messages = messagesSnapshot.docs
            .map((doc) => ChatMessageModel.fromJson(doc.data()))
            .toList();

        // Return the most recent message, or null if there are no messages
        return messages.isNotEmpty ? messages.first : null;
      }).toList();

      List<ChatMessageModel> chatroomMessages =
          (await Future.wait(chatroomMessagesFutures))
              .whereType<ChatMessageModel>()
              .toList();

      return Right(chatroomMessages);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      debugPrint('FirebaseAuthException code: ${e.code}');
      error = e;
      return Left(Exception(e.message));
    }
  }
}
