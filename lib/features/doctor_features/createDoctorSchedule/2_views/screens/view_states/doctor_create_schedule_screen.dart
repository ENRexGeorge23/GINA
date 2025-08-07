import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/createDoctorSchedule/2_views/bloc/create_doctor_schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class DoctorCreateScheduleScreenLoaded extends StatelessWidget {
  DoctorCreateScheduleScreenLoaded({
    super.key,
    required this.selectedDays,
    required this.endTimes,
    required this.startTimes,
    required this.selectedMode,
  });
  List<String> endTimes = [];
  List<String> startTimes = [];
  List<int> selectedDays = [];
  List<int> selectedMode = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Choose your office days',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(
              7,
              (index) {
                final daysOfWeek = [
                  "Sun",
                  "Mon",
                  "Tue",
                  "Wed",
                  "Thu",
                  "Fri",
                  "Sat"
                ];
                final isSelected = ValueNotifier<bool>(false);

                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isSelected,
                    builder: (_, selected, __) {
                      return InkWell(
                        onTap: () {
                          isSelected.value = !isSelected.value;
                          if (selectedDays.isEmpty) {
                            selectedDays = <int>[];
                            if (isSelected.value == true) {
                              selectedDays.add(index);
                            } else {
                              selectedDays.remove(index);
                            }
                          } else {
                            if (isSelected.value == true) {
                              selectedDays.add(index);
                            } else {
                              selectedDays.remove(index);
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal:
                                  11.0), // Reduced padding to make the box smaller
                          decoration: BoxDecoration(
                            color: selected
                                ? GinaAppTheme.lightSecondary
                                : Colors.transparent,
                            border: Border.all(
                                color: GinaAppTheme.lightOutlineVariant),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              daysOfWeek[index],
                              style: TextStyle(
                                color: selected
                                    ? GinaAppTheme.appbarColorLight
                                    : GinaAppTheme.lightOnPrimaryColor,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const Gap(30),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select your office hours',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(10),
          Column(
            children: List<Widget>.generate(
              3,
              (rowIndex) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List<Widget>.generate(
                  3,
                  (columnIndex) {
                    final timeSchedule = [
                      "9:00 AM - 10:00 AM",
                      "10:00 AM-11:00 AM",
                      "11:00 AM-12:00 PM",
                      "1:00 PM - 2:00 PM",
                      "2:00 PM - 3:00 PM",
                      "3:00 PM - 4:00 PM",
                      "4:00 PM - 5:00 PM",
                      "5:00 PM - 6:00 PM",
                      "6:00 PM - 7:00 PM",
                    ];
                    final index = rowIndex * 3 + columnIndex;
                    final isSelected = ValueNotifier<bool>(false);

                    return Expanded(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isSelected,
                        builder: (_, selected, __) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.309,
                            child: GestureDetector(
                              onTap: () {
                                isSelected.value = !isSelected.value;
                                if (startTimes.isEmpty && endTimes.isEmpty) {
                                  startTimes = <String>[];
                                  endTimes = <String>[];
                                  switch (index) {
                                    case 0:
                                      startTimes.add("9:00 AM");
                                      endTimes.add("10:00 AM");
                                      break;
                                    case 1:
                                      startTimes.add("10:00 AM");
                                      endTimes.add("11:00 AM");
                                      break;
                                    case 2:
                                      startTimes.add("11:00 AM");
                                      endTimes.add("12:00 PM");
                                      break;
                                    case 3:
                                      startTimes.add("1:00 PM");
                                      endTimes.add("2:00 PM");
                                      break;
                                    case 4:
                                      startTimes.add("2:00 PM");
                                      endTimes.add("3:00 PM");
                                      break;
                                    case 5:
                                      startTimes.add("3:00 PM");
                                      endTimes.add("4:00 PM");
                                      break;
                                    case 6:
                                      startTimes.add("4:00 PM");
                                      endTimes.add("5:00 PM");
                                      break;
                                    case 7:
                                      startTimes.add("5:00 PM");
                                      endTimes.add("6:00 PM");
                                      break;
                                    case 8:
                                      startTimes.add("6:00 PM");
                                      endTimes.add("7:00 PM");
                                      break;
                                  }
                                } else {
                                  switch (index) {
                                    case 0:
                                      startTimes.add("9:00 AM");
                                      endTimes.add("10:00 AM");
                                      break;
                                    case 1:
                                      startTimes.add("10:00 AM");
                                      endTimes.add("11:00 AM");
                                      break;
                                    case 2:
                                      startTimes.add("11:00 AM");
                                      endTimes.add("12:00 PM");
                                      break;
                                    case 3:
                                      startTimes.add("1:00 PM");
                                      endTimes.add("2:00 PM");
                                      break;
                                    case 4:
                                      startTimes.add("2:00 PM");
                                      endTimes.add("3:00 PM");
                                      break;
                                    case 5:
                                      startTimes.add("3:00 PM");
                                      endTimes.add("4:00 PM");
                                      break;
                                    case 6:
                                      startTimes.add("4:00 PM");
                                      endTimes.add("5:00 PM");
                                      break;
                                    case 7:
                                      startTimes.add("5:00 PM");
                                      endTimes.add("6:00 PM");
                                      break;
                                    case 8:
                                      startTimes.add("6:00 PM");
                                      endTimes.add("7:00 PM");
                                      break;
                                  }
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5.5, vertical: 9.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? GinaAppTheme.lightSecondary
                                      : Colors.transparent,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    timeSchedule[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      color: selected
                                          ? GinaAppTheme.appbarColorLight
                                          : GinaAppTheme.lightOnPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const Gap(20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Mode of appointment',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(
              2,
              (index) {
                final daysOfWeek = [
                  "Online Consultation",
                  "Face-to-Face Consultation",
                ];
                final isSelected = ValueNotifier<bool>(false);

                return ValueListenableBuilder<bool>(
                  valueListenable: isSelected,
                  builder: (_, selected, __) {
                    return InkWell(
                      onTap: () {
                        isSelected.value = !isSelected.value;
                        if (selectedMode.isEmpty) {
                          selectedMode = <int>[];
                          if (isSelected.value == true) {
                            selectedMode.add(index);
                          } else {
                            selectedMode.remove(index);
                          }
                        } else {
                          if (isSelected.value == true) {
                            selectedMode.add(index);
                          } else {
                            selectedMode.remove(index);
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: selected
                              ? GinaAppTheme.lightSecondary
                              : Colors.transparent,
                          border: Border.all(color: GinaAppTheme.lightOutline),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            daysOfWeek[index],
                            style: TextStyle(
                              color: selected
                                  ? GinaAppTheme.appbarColorLight
                                  : GinaAppTheme.lightOnPrimaryColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: FilledButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                if (selectedDays.isNotEmpty &&
                    startTimes.isNotEmpty &&
                    endTimes.isNotEmpty) {
                  context.read<CreateDoctorScheduleBloc>().add(
                        SaveScheduleEvent(
                          selectedDays: selectedDays,
                          endTimes: endTimes,
                          startTimes: startTimes,
                          appointmentMode: selectedMode,
                        ),
                      );
                  Navigator.pushReplacementNamed(context, '/doctorSchedule');
                  isFromCreateDoctorSchedule = true;

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Schedule created successfully.'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Please select values for Mode of appointment and Days and Time.'),
                      backgroundColor: Colors.red));
                }
              },
              child: Text(
                'Save Schedule',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          const Gap(30),
        ],
      ),
    );
  }
}
