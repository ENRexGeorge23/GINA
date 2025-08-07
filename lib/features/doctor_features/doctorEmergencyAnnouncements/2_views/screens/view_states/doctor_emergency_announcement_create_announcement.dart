import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorEmergencyAnnouncements/2_views/bloc/doctor_emergency_announcements_bloc.dart';
import 'package:first_app/features/doctor_features/doctorForums/2_views/widgets/posted_confirmation_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorEmergencyAnnouncementsCreateAnnouncementScreen
    extends StatelessWidget {
  DoctorEmergencyAnnouncementsCreateAnnouncementScreen({super.key});

  final TextEditingController emergencyMessageController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final doctorEmergencyAnnouncementBloc =
        context.read<DoctorEmergencyAnnouncementsBloc>();
    return BlocBuilder<DoctorEmergencyAnnouncementsBloc,
        DoctorEmergencyAnnouncementsState>(
      builder: (context, state) {
        final TextEditingController patientChoosenController =
            TextEditingController(
          text: state is SelectedAPatientState &&
                  state.appointment.patientName != null
              ? state.appointment.patientName
              : '',
        );
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      height: 50,
                      child: Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'To',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: GinaAppTheme.lightOutline,
                                    ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height:
                                  MediaQuery.of(context).size.height * 0.052,
                              child: TextFormField(
                                readOnly: true,
                                controller: patientChoosenController,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          doctorEmergencyAnnouncementBloc.add(
                                              NavigateToPatientListEvent());
                                        },
                                        icon:
                                            const Icon(Icons.person_add_alt))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Gap(15),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: emergencyMessageController,
                        maxLines: 18,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                        enableSuggestions: false,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Write emergency announcement here...',
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: BlocConsumer<DoctorEmergencyAnnouncementsBloc,
                          DoctorEmergencyAnnouncementsState>(
                        listenWhen: (previous, current) =>
                            current is DoctorEmergencyAnnouncementsActionState,
                        buildWhen: (previous, current) =>
                            current is! DoctorEmergencyAnnouncementsActionState,
                        listener: (context, state) {
                          if (state
                              is CreateEmergencyAnnouncementPostSuccessState) {
                            postedConfirmationDialog(context, 'Posted').then(
                                (value) => doctorEmergencyAnnouncementBloc.add(
                                    GetDoctorEmergencyAnnouncementsEvent()));
                          }
                        },
                        builder: (context, state) {
                          final appointment = state is SelectedAPatientState
                              ? state.appointment
                              : null;
                          return FilledButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (emergencyMessageController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Description can\'t be empty'),
                                        backgroundColor: Colors.red));
                              } else if (patientChoosenController
                                  .text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Choose a patient'),
                                        backgroundColor: Colors.red));
                              } else {
                                doctorEmergencyAnnouncementBloc.add(
                                  CreateEmergencyAnnouncementEvent(
                                    message: emergencyMessageController.text,
                                    appointment: appointment!,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Post',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
