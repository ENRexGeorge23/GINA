import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/1_controllers/doctor_chat_message_controller.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/2_views/widgets/doctor_chat_card.dart';
import 'package:first_app/features/patient_features/consultation/2_views/bloc/consultation_bloc.dart';
import 'package:flutter/material.dart';

class DoctorChatMessageBody extends StatelessWidget {
  const DoctorChatMessageBody({
    super.key,
    required this.chatController,
    required this.scrollController,
    required this.selectedDoctorUID,
  });

  final DoctorChatMessageController chatController;
  final ScrollController scrollController;
  final String selectedDoctorUID;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedBuilder(
          animation: chatController,
          builder: (context, Widget? w) {
            return isChatWaiting
                ? const SizedBox()
                : SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    controller: scrollController,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Your scheduled appointment has now begun. Happy chatting!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: GinaAppTheme.lightOutline,
                                  ),
                            ),
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: chatController.messages.length,
                              itemBuilder: (context, index) {
                                return DoctorChatCard(
                                  scrollController: scrollController,
                                  index: index,
                                  chat: chatController.messages,
                                  chatroom: chatController.chatroom ?? '',
                                  recipient: selectedDoctorUID,
                                );
                              }),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
