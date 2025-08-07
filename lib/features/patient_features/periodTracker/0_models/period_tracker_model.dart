// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PeriodTrackerModel extends Equatable {
  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> periodDates;
  final List<DateTime> periodDatesPredictions;
  final int periodLenght;
  final bool isLog;
  int cycleLength;

  PeriodTrackerModel({
    required this.startDate,
    required this.endDate,
    required this.periodDates,
    required this.isLog,
    required this.periodDatesPredictions,
    this.cycleLength = 0,
  }) : periodLenght = endDate.difference(startDate).inDays + 1;

  factory PeriodTrackerModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    Map<String, dynamic> data = {};
    if (snap.data() != null) {
      data = snap.data() as Map<String, dynamic>;
    }
    return PeriodTrackerModel(
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      isLog: data['isLog'],
      periodDatesPredictions: data['periodDatesPredictions'] != null
          ? (data['periodDatesPredictions'] as List)
              .map((e) => (e as Timestamp).toDate())
              .toList()
          : [],
      periodDates: data['periodDates'] != null
          ? (data['periodDates'] as List)
              .map((e) => (e as Timestamp).toDate())
              .toList()
          : [],
      cycleLength: data['cycleLength'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'isLog': isLog,
      'cycleLength': cycleLength,
    };
  }

  factory PeriodTrackerModel.fromJson(Map<String, dynamic> json) {
    return PeriodTrackerModel(
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      isLog: json['isLog'],
      periodDatesPredictions: json['periodDatesPredictions'] != null
          ? (json['periodDatesPredictions'] as List)
              .map((e) => (e as Timestamp).toDate())
              .toList()
          : [],
      periodDates: json['periodDates'] != null
          ? (json['periodDates'] as List)
              .map((e) => (e as Timestamp).toDate())
              .toList()
          : [],
      cycleLength: json['cycleLength'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'cycleLength': cycleLength,
    };
  }

  @override
  List<Object> get props => [
        startDate,
        endDate,
        periodDates,
        periodLenght,
        isLog,
        cycleLength,
      ];
}
