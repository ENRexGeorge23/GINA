import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/patient_features/periodTracker/0_models/period_tracker_model.dart';
import 'package:flutter/material.dart';

class CycleHistoryController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late StreamSubscription authStream;
  User? currentPatient;
  FirebaseAuthException? error;
  bool working = false;

  CycleHistoryController() {
    authStream = auth.authStateChanges().listen((User? user) {
      currentPatient = user;
    });
  }
//-------------------Get Average Cycle length-------------------
  Future<int?> getAverageCycleLength() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentPatient!.uid)
          .collection('patientLogs')
          .orderBy('startDate')
          .get();

      int totalCycleLength = 0;
      int totalCount = 0;
      DateTime? previousStartDate;

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final startDate = data['startDate'] as Timestamp;
        final DateTime date = startDate.toDate();

        if (previousStartDate != null) {
          final cycleLength = date.difference(previousStartDate).inDays;
          totalCycleLength += cycleLength;
          totalCount++;
        }
        previousStartDate = date;
      }

      if (totalCount == 0) {
        return 28;
      }

      final averageCycleLength = totalCycleLength ~/ totalCount;

      return averageCycleLength;
    } catch (e) {
      debugPrint('Error getting average cycle length: $e');
      return null;
    }
  }

//------------------Get the Last Period That Occured -------------------
  Future<DateTime?> getLastPeriodDate() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentPatient!.uid)
          .collection('patientLogs')
          .where('startDate',
              isLessThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
          .orderBy('startDate', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final lastPeriodDate =
            snapshot.docs.first.data()['startDate'] as Timestamp;
        return lastPeriodDate.toDate();
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getting last period date: $e');
      return null;
    }
  }

//------------------Get the Last Period Duration -------------------
  Future<int?> getLastPeriodDuration() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentPatient!.uid)
          .collection('patientLogs')
          .where('startDate',
              isLessThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
          .orderBy('startDate', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final lastPeriodDoc = snapshot.docs.first.data();

        final startDate = (lastPeriodDoc['startDate'] as Timestamp).toDate();
        final endDate = (lastPeriodDoc['endDate'] as Timestamp).toDate();

        final periodDuration = endDate.difference(startDate).inDays + 1;
        return periodDuration;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getting last period duration: $e');
      return null;
    }
  }

//---------------------GET CYCLE HISTORY---------------------
  Future<Either<Exception, List<PeriodTrackerModel>>> getCycleHistory() async {
    try {
      // Retrieve the menstrual cycle data from Firestore
      final menstrualPeriodCycle = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentPatient!.uid)
          .collection('patientLogs')
          .where('startDate',
              isLessThanOrEqualTo:
                  Timestamp.fromDate(DateTime.now())) // Add this line
          .get();

      if (menstrualPeriodCycle.docs.isNotEmpty) {
        //Extract all doc and make it a list
        final allMenstrualPeriods = menstrualPeriodCycle.docs
            .map((e) => PeriodTrackerModel.fromJson(e.data()))
            .toList();

        debugPrint('All menstrual periods: $allMenstrualPeriods');
        return Right(allMenstrualPeriods);
      } else {
        return const Right([]);
      }
    } catch (e) {
      debugPrint('Error retrieving menstrual periods: $e');
      return Left(
        Exception('Error retrieving menstrual periods: $e'),
      );
    }
  }

  //---------------------GET ALL MENSTRUAL PERIODS---------------------
  Future<Either<Exception, List<PeriodTrackerModel>>>
      getMenstrualPeriods() async {
    try {
      // Retrieve the first menstrual cycle data from Firestore
      final menstrualPeriodCycle = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentPatient!.uid)
          .collection('patientLogs')
          .get();

      if (menstrualPeriodCycle.docs.isNotEmpty) {
        //Extract all doc and make it a list
        final allMenstrualPeriods = menstrualPeriodCycle.docs
            .map((e) => PeriodTrackerModel.fromJson(e.data()))
            .toList();

        debugPrint('All menstrual periods: $allMenstrualPeriods');
        return Right(allMenstrualPeriods);
      } else {
        return const Right([]);
      }
    } catch (e) {
      debugPrint('Error retrieving menstrual periods: $e');
      return Left(
        Exception('Error retrieving menstrual periods: $e'),
      );
    }
  }
}
