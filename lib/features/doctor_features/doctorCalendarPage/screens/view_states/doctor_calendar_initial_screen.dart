import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DoctorCalendarInitialScreen extends StatelessWidget {
  const DoctorCalendarInitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: SfDateRangePicker(
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
                selectionColor: GinaAppTheme.lightOnPrimaryColor,
                rangeSelectionColor: GinaAppTheme.lightPrimaryColor,
                selectionMode: DateRangePickerSelectionMode.range,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
