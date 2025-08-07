// ignore_for_file: collection_methods_unrelated_type

import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/periodTracker/0_models/period_tracker_model.dart';
import 'package:first_app/features/patient_features/periodTracker/2_views/bloc/period_tracker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PeriodTrackerEditDatesScreen extends StatelessWidget {
  final List<PeriodTrackerModel> periodTrackerModel;
  final List<DateTime> storedPeriodDates;

  PeriodTrackerEditDatesScreen(
      {super.key,
      required this.periodTrackerModel,
      required this.storedPeriodDates});

  final datePickerController = DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    final periodTrackerBloc = context.read<PeriodTrackerBloc>();

    // datePickerController.selectedRanges = periodTrackerModel
    //     .map((e) => PickerDateRange(
    //           e.startDate,
    //           e.endDate,
    //         ))
    //     .toList();

    return Center(
      child: Column(
        children: [
          const Gap(20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<PeriodTrackerBloc, PeriodTrackerState>(
                builder: (context, state) {
                  return SfDateRangePicker(
                    selectableDayPredicate: (date) {
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      return date.isBefore(today) ||
                          date.isAtSameMomentAs(today);
                    },
                    showNavigationArrow: true,
                    headerStyle: const DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          color: GinaAppTheme.lightOnPrimaryColor,
                          fontWeight: FontWeight.w700,
                        )),
                    monthCellStyle: const DateRangePickerMonthCellStyle(
                        textStyle: TextStyle(
                      color: GinaAppTheme.lightOnPrimaryColor,
                    )),
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        textStyle: TextStyle(
                          color: GinaAppTheme.lightOnPrimaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    selectionColor: Colors.transparent,
                    selectionMode: DateRangePickerSelectionMode.single,
                    controller: datePickerController,
                    onSelectionChanged:
                        (DateRangePickerSelectionChangedArgs args) {
                      periodTrackerBloc
                          .add(SelectDateEvent(periodDate: args.value!));
                    },
                    cellBuilder: (BuildContext context,
                        DateRangePickerCellDetails details) {
                      final isSelected = periodDates.contains(details.date);
                      final isPeriodDates =
                          storedPeriodDates.contains(details.date);

                      return GestureDetector(
                        onTap: () {
                          final now = DateTime.now();
                          final today = DateTime(now.year, now.month, now.day);
                          if (details.date.isAfter(today)) {
                            return;
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  details.date.day.toString(),
                                  style: const TextStyle(
                                    color: GinaAppTheme.lightOnPrimaryColor,
                                  ),
                                ),
                              ),
                              isSelected || isPeriodDates
                                  ? Positioned(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: GinaAppTheme
                                                  .lightOutline, // Change this to your desired border color
                                              width:
                                                  2, // Change this to your desired border width
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.check_circle,
                                            color:
                                                GinaAppTheme.lightPrimaryColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Positioned(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: GinaAppTheme
                                                  .lightOutline, // Change this to your desired border color
                                              width:
                                                  2, // Change this to your desired border width
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.circle,
                                            color:
                                                GinaAppTheme.appbarColorLight,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 35,
                width: 120,
                child: FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 30,
                    )),
                    backgroundColor: MaterialStateProperty.all(
                        GinaAppTheme.lightSurfaceVariant),
                  ),
                  child: Text('Cancel',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: 35,
                width: 120,
                child: FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 30,
                    )),
                  ),
                  child: Text('Save',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  onPressed: () {
                    final sortDates = periodDates..sort();
                    periodTrackerBloc.add(LogFirstMenstrualPeriodEvent(
                      periodDates: sortDates,
                      startDate: sortDates.first,
                      endDate: sortDates.last,
                    ));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
