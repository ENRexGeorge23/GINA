import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/2_views/bloc/doctor_consultation_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/bloc/doctor_e_consult_bloc.dart';
import 'package:first_app/features/patient_features/consultation/0_model/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ChatEConsulCardList extends StatelessWidget {
  const ChatEConsulCardList({
    super.key,
    required this.chatRooms,
    required this.doctorEConsultBloc,
  });

  final List<ChatMessageModel> chatRooms;
  final DoctorEConsultBloc doctorEConsultBloc;

  @override
  Widget build(BuildContext context) {
    chatRooms.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        itemCount: chatRooms.length, // replace with your list length
        itemBuilder: (context, index) {
          final chatRoom = chatRooms[index];
          DateTime now = DateTime.now();
          DateTime createdAt = chatRoom.createdAt!.toDate();
          String time;
          if (now.difference(createdAt).inHours < 24) {
            time = DateFormat.jm().format(createdAt);
          } else if (now.difference(createdAt).inDays == 1) {
            time = 'Yesterday';
          } else if (now.difference(createdAt).inDays <= 7) {
            time = DateFormat('EEEE').format(createdAt);
          } else {
            time = DateFormat.yMd().format(createdAt);
          }
          return GestureDetector(
            onTap: () {
              selectedPatientUid = chatRoom.patientUid;
              selectedPatientName = chatRoom.patientName;
              // isFromChatRoomLists = true;

              doctorEConsultBloc
                  .add(GetPatientDataEvent(patientUid: chatRoom.patientUid!));
              Navigator.pushNamed(context, '/doctorOnlineConsultChat').then(
                  (value) => context
                      .read<DoctorEConsultBloc>()
                      .add(GetRequestedEConsultsDiplayEvent()));
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 90.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: GinaAppTheme.appbarColorLight,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 23.0,
                                    backgroundImage: AssetImage(
                                      Images.profileIcon,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(10),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          chatRoom
                                              .patientName!, // replace with your data
                                          style: const TextStyle(
                                            color:
                                                GinaAppTheme.cancelledTextColor,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "SF UI Display",
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          (chatRoom.doctorName ==
                                                  chatRoom.authorName)
                                              ? 'You: ${chatRoom.message!}'
                                              : chatRoom
                                                  .message!, // replace with your data
                                          style: const TextStyle(
                                            color:
                                                GinaAppTheme.cancelledTextColor,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "SF UI Display",
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Gap(15),
                              Text(
                                time,
                                style: const TextStyle(
                                  color: GinaAppTheme.cancelledTextColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SF UI Display",
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
