import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/consultation/1_controllers/chat_message_controllers.dart';
import 'package:first_app/features/patient_features/consultation/2_views/bloc/consultation_bloc.dart';
import 'package:first_app/features/patient_features/consultation/2_views/widgets/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class MessageBody extends StatelessWidget {
  const MessageBody({
    super.key,
    required this.chatController,
    required this.scrollController,
    required this.selectedDoctorUID,
  });

  final ChatMessageController chatController;
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
                          // TODO
                          FutureBuilder<Timestamp?>(
                              future: chatController.getFirstMessageTime(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<Timestamp?> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Text(
                                    'Started on ${DateFormat('MMMM dd, yyyy hh:mm a').format(snapshot.data?.toDate() ?? DateTime.now())}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: GinaAppTheme.lightOutline,
                                        ),
                                  );
                                }
                              }),

                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: chatController.messages.length,
                              itemBuilder: (context, index) {
                                return ChatCard(
                                  scrollController: scrollController,
                                  index: index,
                                  chat: chatController.messages,
                                  chatroom: chatController.chatroom ?? '',
                                  recipient: selectedDoctorUID,
                                );
                              }),

                          // TODO
                          const Gap(15),
                          FutureBuilder<Timestamp?>(
                            future: chatController.getLastMessageTime(),
                            builder: (BuildContext context,
                                AsyncSnapshot<Timestamp?> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Text(
                                  'Ended on ${DateFormat('MMMM dd, yyyy hh:mm a').format(snapshot.data?.toDate() ?? DateTime.now())}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: GinaAppTheme.lightOutline,
                                      ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
