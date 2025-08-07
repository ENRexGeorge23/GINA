import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/bloc/appointment_details_bloc.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/doctor_card_container.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/reschedule_appointment_success.dart';
import 'package:first_app/features/patient_features/appointmentDetails/2_views/widgets/reschedule_filled_button.dart';
import 'package:first_app/features/patient_features/bookAppointment/2_views/bloc/book_appointment_bloc.dart';
import 'package:first_app/features/patient_features/doctorAvailability/0_model/doctor_availability_model.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class BookAppointmentInitialScreen extends StatelessWidget {
  final DoctorAvailabilityModel doctorAvailabilityModel;
  const BookAppointmentInitialScreen({
    super.key,
    required this.doctorAvailabilityModel,
  });

  @override
  Widget build(BuildContext context) {
    final bookAppointmentBloc = context.read<BookAppointmentBloc>();
    final appointmentDetailsBloc = context.read<AppointmentDetailsBloc>();
    final modeOfAppointmentList =
        bookAppointmentBloc.getModeOfAppointment(doctorAvailabilityModel);
    final startTimes = doctorAvailabilityModel.startTimes;
    final endTimes = doctorAvailabilityModel.endTimes;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(10),
                DoctorCardContainer(
                  doctor: doctorDetails!,
                ),
                const Gap(20),
                doctorAvailabilityModel.startTimes.isEmpty
                    ? Center(
                        child: Text(
                          'Doctor is not yet available for appointments.\nPlease check back later.',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select a date',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: TextFormField(
                                controller: bookAppointmentBloc.dateController,
                                readOnly: true,
                                onTap: () async {
                                  DateTime now = DateTime.now();
                                  DateTime today =
                                      DateTime(now.year, now.month, now.day);
                                  DateTime firstDayOfThisWeek = now.subtract(
                                      Duration(days: now.weekday - 1));
                                  DateTime lastDayOfThisWeek =
                                      firstDayOfThisWeek
                                          .add(const Duration(days: 6));
                                  DateTime firstDayOfNextWeek =
                                      firstDayOfThisWeek
                                          .add(const Duration(days: 7));

                                  DateTime firstDate =
                                      now.isAfter(lastDayOfThisWeek)
                                          ? firstDayOfNextWeek
                                          : firstDayOfThisWeek;
                                  DateTime lastDate =
                                      firstDate.add(const Duration(days: 6));

                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: now,
                                    firstDate: firstDate,
                                    lastDate: lastDate,
                                    helpText:
                                        'Next week dates available on Sunday',
                                    selectableDayPredicate: (date) {
                                      return date.isAfter(today.subtract(
                                              const Duration(days: 1))) &&
                                          doctorAvailabilityModel.days
                                              .contains(date.weekday % 7);
                                    },
                                  );

                                  if (selectedDate != null) {
                                    bookAppointmentBloc.dateController.text =
                                        DateFormat('EEEE, d ' 'of' ' MMMM y')
                                            .format(selectedDate);
                                  } else {
                                    showDialog(
                                      // ignore: use_build_context_synchronously
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('No Date Selected'),
                                          content: const Text(
                                              'Please select a date'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                      Icons.calendar_today_rounded,
                                      color: GinaAppTheme.lightOutline),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Select a date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(20),
                            Text(
                              'Select a Time',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const Gap(20),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                                child: GridView.builder(
                                  itemCount: startTimes.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisExtent: 40,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 25),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        bookAppointmentBloc.add(
                                          SelectTimeEvent(
                                              index: index,
                                              startingTime: startTimes[index],
                                              endingTime: endTimes[index]),
                                        );
                                      },
                                      child: BlocBuilder<BookAppointmentBloc,
                                          BookAppointmentState>(
                                        builder: (context, state) {
                                          final selectedIndex = state
                                                  is GetDoctorAvailabilityLoaded
                                              ? state.selectedTimeIndex
                                              : -1;

                                          return Container(
                                            decoration: BoxDecoration(
                                              color: selectedIndex == index
                                                  ? GinaAppTheme
                                                      .lightPrimaryColor
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color:
                                                    GinaAppTheme.lightOutline,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${startTimes[index]} - ${endTimes[index]}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 11,
                                                      letterSpacing: 0.001,
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
                            const Gap(20),
                            Text(
                              'Mode of appointment',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const Gap(15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List<Widget>.generate(
                                modeOfAppointmentList.length,
                                (index) {
                                  return InkWell(
                                    onTap: () {
                                      bookAppointmentBloc.add(
                                        SelectedModeOfAppointmentEvent(
                                          index: index,
                                          modeOfAppointment:
                                              modeOfAppointmentList[index],
                                        ),
                                      );
                                    },
                                    child: BlocBuilder<BookAppointmentBloc,
                                        BookAppointmentState>(
                                      builder: (context, state) {
                                        final selectedIndex = state
                                                is GetDoctorAvailabilityLoaded
                                            ? state
                                                .selectedModeofAppointmentIndex
                                            : -1;

                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          decoration: BoxDecoration(
                                            color: selectedIndex == index
                                                ? GinaAppTheme.lightPrimaryColor
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: GinaAppTheme.lightOutline,
                                            ),
                                          ),
                                          height: 35,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                modeOfAppointmentList[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
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
                            const Gap(40),
                            BlocBuilder<BookAppointmentBloc,
                                BookAppointmentState>(
                              builder: (context, state) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: FilledButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (bookAppointmentBloc
                                              .dateController.text.isEmpty ||
                                          bookAppointmentBloc
                                                  .selectedTimeIndex ==
                                              -1 ||
                                          bookAppointmentBloc
                                                  .selectedModeofAppointmentIndex ==
                                              -1) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Please select a date, time and mode of appointment',
                                            ),
                                            backgroundColor:
                                                GinaAppTheme.lightError,
                                          ),
                                        );
                                      } else {
                                        final selectedTime =
                                            '${startTimes[bookAppointmentBloc.selectedTimeIndex]} - ${endTimes[bookAppointmentBloc.selectedTimeIndex]}';
                                        if (isRescheduleMode) {
                                          appointmentDetailsBloc.add(
                                            RescheduleAppointmentEvent(
                                                appointmentUid:
                                                    appointmentUidToReschedule!,
                                                appointmentDate:
                                                    bookAppointmentBloc
                                                        .dateController.text,
                                                appointmentTime: selectedTime,
                                                modeOfAppointment:
                                                    bookAppointmentBloc
                                                        .selectedModeofAppointmentIndex),
                                          );
                                          isRescheduleMode = false;
                                          showRescheduleAppointmentSuccessDialog(
                                              context);
                                        } else {
                                          bookAppointmentBloc.add(
                                            BookForAnAppointmentEvent(
                                              doctorId: doctorDetails!.uid,
                                              doctorName: doctorDetails!.name,
                                              doctorClinicAddress:
                                                  doctorDetails!.officeAdress,
                                              appointmentDate:
                                                  bookAppointmentBloc
                                                      .dateController.text,
                                              appointmentTime: selectedTime,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Book appointment',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
