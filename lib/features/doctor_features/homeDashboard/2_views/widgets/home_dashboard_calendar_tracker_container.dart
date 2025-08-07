import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeDashboardCalendarTrackerContainer extends StatelessWidget {
  const HomeDashboardCalendarTrackerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/doctorCalendar');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: GinaAppTheme.lightOnTertiary,
        ),
        height: 170,
        width: MediaQuery.of(context).size.width / 1.05,
        child: Column(
          children: [
            const Gap(15),
            EasyDateTimeLine(
              initialDate: DateTime.now(),
              headerProps: EasyHeaderProps(
                monthStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 16,
                    ),
                monthPickerType: MonthPickerType.switcher,
                selectedDateFormat: SelectedDateFormat.fullDateMonthAsStrDY,
                selectedDateStyle:
                    Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 16,
                        ),
              ),
              dayProps: EasyDayProps(
                height: 65.0,
                width: 65.0,
                todayHighlightStyle: TodayHighlightStyle.withBackground,
                todayHighlightColor: GinaAppTheme.lightPrimaryContainer,
                todayStyle: DayStyle(
                  dayNumStyle: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: GinaAppTheme.lightOutline),
                ),
                dayStructure: DayStructure.dayStrDayNum,
                inactiveDayStyle: DayStyle(
                  dayNumStyle: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: GinaAppTheme.lightOutline),
                  dayStrStyle: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: GinaAppTheme.lightOutline),
                ),
                activeDayStyle: DayStyle(
                  dayNumStyle: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: GinaAppTheme.lightOnPrimaryColor),
                  dayStrStyle: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: GinaAppTheme.lightOnPrimaryColor),
                  monthStrStyle: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: GinaAppTheme.lightOnPrimaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
