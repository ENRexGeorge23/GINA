import 'package:dotted_border/dotted_border.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/periodTracker/0_models/period_tracker_model.dart';
import 'package:first_app/features/patient_features/periodTracker/2_views/bloc/period_tracker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PeriodTrackerInitialScreen extends StatelessWidget {
  final List<PeriodTrackerModel> periodTrackerModel;
  final List<PeriodTrackerModel> allPeriodsWithPredictions;
  PeriodTrackerInitialScreen({
    super.key,
    required this.periodTrackerModel,
    required this.allPeriodsWithPredictions,
  });

  final dateRange = DateRangePickerController();
  final periodDateRange = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    final periodTrackerBloc = context.read<PeriodTrackerBloc>();

    dateRange.selectedDates =
        allPeriodsWithPredictions.expand((p) => p.periodDates).toList();

    periodDateRange.selectedDates = allPeriodsWithPredictions
        .expand((p) => p.periodDatesPredictions)
        .toList();

    return Center(
      child: Column(
        children: [
          const Gap(20),
          // LEGEND
          // const Gap(80),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: DottedBorder(
              dashPattern: const [5, 5],
              color: GinaAppTheme.lightOutline.withOpacity(0.3),
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              padding: const EdgeInsets.all(14),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Legend',
                    //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //         color: GinaAppTheme.lightOnSecondary,
                    //       ),
                    // ),
                    const Gap(20),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: GinaAppTheme.lightPrimaryColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      'Period Logs',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: GinaAppTheme.lightOnSecondary,
                          ),
                    ),
                    const Gap(100),
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: GinaAppTheme.lightOutline.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      'Period Predictions',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: GinaAppTheme.lightOnSecondary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
              child: Stack(
                children: [
                  SfDateRangePicker(
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
                    selectionMode: DateRangePickerSelectionMode.multiple,
                    controller: dateRange,
                    cellBuilder: (context, cellDetails) {
                      final isLog =
                          dateRange.selectedDates!.contains(cellDetails.date);
                      final isNotLog = periodDateRange.selectedDates!
                          .contains(cellDetails.date);
                      final DateTime now = DateTime.now();

                      final isDateToday = cellDetails.date.day == now.day &&
                          cellDetails.date.month == now.month &&
                          cellDetails.date.year == now.year;

                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: isLog
                                ? GinaAppTheme.lightPrimaryColor
                                : isNotLog
                                    ? GinaAppTheme.lightOutline.withOpacity(0.3)
                                    : null,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Text(
                                      isDateToday ? 'TODAY' : '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            color: isLog && isDateToday
                                                ? GinaAppTheme.lightOnSecondary
                                                : GinaAppTheme
                                                    .lightTertiaryContainer,
                                          ),
                                    ),
                                  ],
                                ),
                                Text(cellDetails.date.day.toString(),
                                    style: isDateToday
                                        ? Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: isLog && isDateToday
                                                    ? GinaAppTheme
                                                        .lightOnSecondary
                                                    : GinaAppTheme
                                                        .lightTertiaryContainer)
                                        : null),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.32,
                        color: Colors.white
                            .withOpacity(0.1), // Semi-transparent color
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(20),
          SizedBox(
            height: 35,
            child: FilledButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                  horizontal: 30,
                )),
              ),
              child: Text('Edit Period Dates',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              onPressed: () {
                periodTrackerBloc.add(
                  NavigateToPeriodTrackerEditDatesEvent(
                    periodTrackerModel: periodTrackerModel,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
