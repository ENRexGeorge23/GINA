import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/2_views/widgets/doctor_chat_input_message_field.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/bloc/doctor_e_consult_bloc.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:first_app/features/patient_features/consultation/2_views/bloc/consultation_bloc.dart';
import 'package:flutter/material.dart';

class DoctorChatConsultationBody extends StatelessWidget {
  const DoctorChatConsultationBody({
    super.key,
    required this.messageFN,
    required this.messageController,
    required this.context,
    required this.messages,
    required this.send,
  });

  final FocusNode messageFN;
  final TextEditingController messageController;
  final BuildContext context;
  final Widget messages;
  final Function send;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          messages,
          isFromChatRoomLists || isAppointmentFinished
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 15,
                    color: GinaAppTheme.appbarColorLight,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          'Note: This conversation is view-only, and the consultation is now complete with no further messaging available.',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                  ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                )
              : isChatWaiting
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                              'Welcome!\n\nYour consultation will begin at ${storedAppointmentTime!.split(" - ")[0]} and lasts until ${storedAppointmentTime!.split(" - ")[1]}.\n\n',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                    fontWeight: FontWeight.w600,
                                  )),
                          DoctorChatInputMessageField(
                              messageFN: messageFN,
                              messageController: messageController,
                              context: context,
                              send: send),
                        ],
                      ),
                    )
                  : DoctorChatInputMessageField(
                      messageFN: messageFN,
                      messageController: messageController,
                      context: context,
                      send: send),
        ],
      ),
    );
  }
}
