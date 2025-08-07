import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/features/patient_features/periodTracker/0_models/period_tracker_model.dart';
import 'package:flutter/material.dart';

class PeriodTrackerController with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late StreamSubscription authStream;
  User? currentUser;
  FirebaseAuthException? error;
  bool working = false;

  PeriodTrackerController() {
    authStream = auth.authStateChanges().listen((User? user) {
      currentUser = user;
      notifyListeners();
    });
  }

  //TODO PERIOD TRACKER FORMULA CLARIFY
//-------------------LOG MENSTRUAL PERIOD----------------------
  Future<void> logMenstrualPeriod({
    required DateTime startDate,
    required DateTime endDate,
    required List<DateTime> periodDates,
  }) async {
    try {
      List<Timestamp> periodDatesTimestamps = periodDates
          .map((date) => Timestamp.fromDate(date))
          .toList(); // Convert List<DateTime> to List<Timestamp>

      QuerySnapshot logsSnapshot = await firestore
          .collection('patients')
          .doc(currentUser!.uid)
          .collection('patientLogs')
          .get();

      int cycleLength = 28; // Default value

// TODO CHANGE THE FORMULA
      // Compare the latest logged period to the previous logged period dates
      // Then get the cycle length based from the two logged periods
      if (logsSnapshot.docs.isNotEmpty) {
        Map<String, dynamic> nearestLog = logsSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .reduce((curr, next) {
          DateTime currStartDate = curr['startDate'].toDate();
          DateTime nextStartDate = next['startDate'].toDate();

          // abs() is used to get the absolute value of the difference
          int currDiff = (startDate.difference(currStartDate).inDays - 1).abs();
          int nextDiff = (startDate.difference(nextStartDate).inDays - 1).abs();

          return currDiff < nextDiff ? curr : next;
        });

        DateTime nearestStartDate = nearestLog['startDate'].toDate();
        cycleLength = (startDate.difference(nearestStartDate).inDays - 1).abs();

        DateTime nearestEndDate = nearestLog['endDate'].toDate();

        //debug

        debugPrint('Nearest Log: $nearestLog');
        debugPrint('Nearest Log End Date: $nearestEndDate');
        debugPrint('Nearest Start Date: $nearestStartDate');
        debugPrint('Cycle Length: $cycleLength');
      }

      // Store the menstrual cycle data in Firestore
      String snapId = firestore
          .collection('patients')
          .doc(currentUser!.uid)
          .collection('patientLogs')
          .doc()
          .id;

      await firestore
          .collection('patients')
          .doc(currentUser!.uid)
          .collection('patientLogs')
          .doc(snapId)
          .set({
        'periodDates': periodDatesTimestamps,
        'startDate': startDate,
        'endDate': endDate,
        'cycleLength': cycleLength,
        'isLog': true,
      });
      debugPrint('Menstrual Cycle logged successfully.');
    } catch (e) {
      debugPrint('Error logging menstrual cycle: $e');
    }
  }

//---------------------GET AVERAGE CYCLE LENGTH---------------------
  Future<int?> getAverageCycleLength() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentUser!.uid)
          .collection('patientLogs')
          .orderBy('startDate')
          .get();

      int totalCycleLength = 0;
      int totalCount = 0;
      DateTime? previousStartDate;

      // iterate through all the logged periods of the current user
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final startDate = data['startDate'] as Timestamp;
        final DateTime date = startDate.toDate();

        if (previousStartDate != null) {
          // final cycleLength = date.difference(previousStartDate).inDays + 1;
          final cycleLength = date.difference(previousStartDate).inDays;
          totalCycleLength += cycleLength;
          totalCount++;
        }
        previousStartDate = date;
      }

      if (totalCount == 0) {
        return null;
      }

      // ~/ integer division : round up to the nearest whole number
      final averageCycleLength = totalCycleLength ~/ totalCount;

      debugPrint('Average cycle length: $averageCycleLength');

      return averageCycleLength;
    } catch (e) {
      debugPrint('Error getting average cycle length: $e');
      return null;
    }
  }

//---------------------PREDICT NEXT 12 PERIODS---------------------

  // generate a range of dates within a specified date interval
  List<DateTime> getDatesBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> dates = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      dates.add(startDate.add(Duration(days: i)));
    }
    return dates;
  }

  Future<void> predictNext12Periods() async {
    try {
      // Fetch all logs
      QuerySnapshot logsSnapshot = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentUser!.uid)
          .collection('patientLogs')
          .orderBy('endDate',
              descending: true) // Order by endDate in descending order
          .get();

      // If there are no logs, return
      if (logsSnapshot.docs.isEmpty) {
        debugPrint('No menstrual cycle data logged yet.');
        return;
      }

      // Get the log nearest to the current date
      DocumentSnapshot nearestLog = logsSnapshot.docs.first;

      DateTime nearestStartDate =
          (nearestLog.data() as Map)['startDate'].toDate();

      DateTime nearestEndDate = (nearestLog.data() as Map)['endDate'].toDate();

      // inDays - gets the number of whole days of the previous cycle before the current logged period
      int periodLength = nearestEndDate.difference(nearestStartDate).inDays;

      final getTheAverageCycleLength = await getAverageCycleLength();
      final averagePeriodCycleInDays = getTheAverageCycleLength ?? 28;

      debugPrint('Average period cycle in days: $averagePeriodCycleInDays');

      // Iterate over the next 12 months to predict the start dates of menstrual cycles
      for (int i = 1; i <= 12; i++) {
        // Predict the start date of the next period based on a typical 28-day cycle length
        // DateTime nextStartDate =
        //     nearestEndDate.add(Duration(days: i * averagePeriodCycleInDays));
        DateTime nextStartDate =
            nearestStartDate.add(Duration(days: i * averagePeriodCycleInDays));
        DateTime nextEndDate = nextStartDate.add(Duration(days: periodLength));

        // Store the predicted start date of the period in Firestore
        await FirebaseFirestore.instance
            .collection('patients')
            .doc(currentUser!.uid)
            .collection('periodPredictions')
            .doc('menstrualDate_$i')
            .set({
          'startDate': nextStartDate,
          'endDate': nextEndDate,
          'periodDatesPredictions': getDatesBetween(nextStartDate, nextEndDate),
          'cycleLength': getTheAverageCycleLength,
          'isLog': false,
        });

        debugPrint('Menstrual cycle $i predicted successfully.');
      }
    } catch (e) {
      debugPrint('Error predicting menstrual cycles: $e');
    }
  }

//---------------------GET Log MENSTRUAL PERIODS---------------------
  Future<Either<Exception, List<PeriodTrackerModel>>>
      getMenstrualPeriods() async {
    try {
      // Retrieve the first menstrual cycle data from Firestore
      final menstrualPeriodCycle = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentUser!.uid)
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

  //---------------------GET ALL MENSTRUAL PERIODS---------------------
  Future<Either<Exception, List<PeriodTrackerModel>>> getAllPeriods() async {
    try {
      // Retrieve menstrual cycle data from Firestore
      final menstrualPeriodCycle = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentUser!.uid)
          .collection('patientLogs')
          .get();

      final periodPredictions = await FirebaseFirestore.instance
          .collection('patients')
          .doc(currentUser!.uid)
          .collection('periodPredictions')
          .get();

      List<PeriodTrackerModel> allPeriods = [];

      if (menstrualPeriodCycle.docs.isNotEmpty) {
        allPeriods.addAll(menstrualPeriodCycle.docs
            .map((e) => PeriodTrackerModel.fromJson(e.data()))
            .toList());
      }

      if (periodPredictions.docs.isNotEmpty) {
        allPeriods.addAll(periodPredictions.docs
            .map((e) => PeriodTrackerModel.fromJson(e.data()))
            .toList());
      }

      debugPrint('All periods: $allPeriods');
      return Right(allPeriods);
    } catch (e) {
      debugPrint('Error retrieving all periods: $e');
      return Left(
        Exception('Error retrieving all periods: $e'),
      );
    }
  }
}
