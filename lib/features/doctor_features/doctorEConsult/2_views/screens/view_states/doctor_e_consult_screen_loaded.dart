import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorConsultation/2_views/bloc/doctor_consultation_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/bloc/doctor_e_consult_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/widgets/chat_e_consult_card_list.dart';
import 'package:first_app/features/doctor_features/doctorUpcomingAppointments/2_views/bloc/doctor_upcoming_appointments_bloc.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:first_app/features/patient_features/consultation/0_model/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorEConsultScreenLoaded extends StatelessWidget {
  final AppointmentModel upcomingAppointment;
  final List<ChatMessageModel> chatRooms;
  const DoctorEConsultScreenLoaded(
      {super.key, required this.upcomingAppointment, required this.chatRooms});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final doctorEConsultBloc = context.read<DoctorEConsultBloc>();
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Upcoming appointments",
            style: TextStyle(
              color: GinaAppTheme.lightInverseSurface,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontFamily: "SF UI Display",
            ),
          ),
          const Gap(10),
          upcomingAppointment.patientName == null
              ? Column(
                  children: [
                    const Gap(30),
                    Center(
                      child: Text(
                        "You don't have any upcoming appointments yet",
                        style: textTheme.labelLarge?.copyWith(
                          color: GinaAppTheme.lightOutline,
                        ),
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () {
                    selectedPatientUid = upcomingAppointment.patientUid;

                    doctorEConsultBloc.add(GetPatientDataEvent(
                        patientUid: upcomingAppointment.patientUid!));

                    isFromChatRoomLists = false;

                    appointmentDataFromDoctorUpcomingAppointmentsBloc =
                        upcomingAppointment;
                    Navigator.pushNamed(context, '/doctorOnlineConsultChat')
                        .then((value) => context
                            .read<DoctorEConsultBloc>()
                            .add(GetRequestedEConsultsDiplayEvent()));
                  },
                  child: Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: GinaAppTheme.lightTertiaryContainer,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20.0,
                                      backgroundImage: AssetImage(
                                        Images.findDoctorImage,
                                      ),
                                    ),
                                    const Gap(10),
                                    SizedBox(
                                      width: 250.0,
                                      child: Text(
                                        upcomingAppointment.patientName!,
                                        style: const TextStyle(
                                          color: GinaAppTheme.appbarColorLight,
                                          fontSize: 16.0,
                                          fontFamily: "SF UI Display",
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(8),
                                Row(
                                  children: [
                                    Text(
                                      upcomingAppointment.modeOfAppointment ==
                                              ModeOfAppointmentId
                                                  .onlineConsultation.index
                                          ? "ONLINE CONSULTATION"
                                          : "FACE TO FACE CONSULTATION",
                                      style: const TextStyle(
                                        color: GinaAppTheme.appbarColorLight,
                                        fontSize: 10.0,
                                        fontFamily: "SF UI Display",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Gap(100),
                                    Text(
                                      upcomingAppointment.appointmentTime!,
                                      style: const TextStyle(
                                        color: GinaAppTheme.appbarColorLight,
                                        fontSize: 12.0,
                                        fontFamily: "SF UI Display",
                                        fontWeight: FontWeight.w500,
                                      ),
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
                ),
          upcomingAppointment.patientName == null
              ? const Gap(50)
              : const Gap(10),
          const Divider(
            color: GinaAppTheme.lightOutline,
            thickness: 0.5,
          ),
          chatRooms.isEmpty
              ? Column(
                  children: [
                    const Gap(50),
                    Center(
                      child: Text(
                        "You have no online consultation messages yet ",
                        style: textTheme.labelLarge?.copyWith(
                          color: GinaAppTheme.lightOutline,
                        ),
                      ),
                    ),
                  ],
                )
              : ChatEConsulCardList(
                  chatRooms: chatRooms,
                  doctorEConsultBloc: doctorEConsultBloc,
                )
        ],
      ),
    );
  }
}
