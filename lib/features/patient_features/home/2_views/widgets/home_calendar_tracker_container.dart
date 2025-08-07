import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/home/2_views/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeCalendarTrackerContainer extends StatelessWidget {
  final List<DateTime> periodTrackerModel;
  const HomeCalendarTrackerContainer({
    super.key,
    required this.periodTrackerModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: GinaAppTheme.lightOnTertiary,
      ),
      height: 225,
      width: MediaQuery.of(context).size.width / 1.05,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              const Gap(15),
              EasyDateTimeLine(
                initialDate: DateTime.now(),
                disabledDates: periodTrackerModel,
                headerProps: EasyHeaderProps(
                  monthStyle:
                      Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                    disabledDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: GinaAppTheme.lightPrimaryContainer,
                      ),
                      dayNumStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: GinaAppTheme.lightOutline),
                      dayStrStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: GinaAppTheme.lightOutline),
                    ),
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
                    )),
              ),
              const Gap(30),
              SizedBox(
                height: 35,
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
                  child: Text('Log Period',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/periodTracker');
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
