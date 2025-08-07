import 'package:first_app/core/enum/enum.dart';
import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/pendingState/bloc/pending_request_state_bloc.dart';
import 'package:first_app/features/patient_features/appointment/2_views/widgets/appointment_status.dart';
import 'package:first_app/features/patient_features/bookAppointment/0_model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class PendingRequestStateScreenLoaded extends StatelessWidget {
  final Map<DateTime, List<AppointmentModel>> pendingRequests;
  const PendingRequestStateScreenLoaded({
    super.key,
    required this.pendingRequests,
  });

  @override
  Widget build(BuildContext context) {
    final pendingRequestStateBloc = context.read<PendingRequestStateBloc>();
    var dates = pendingRequests.keys.toList();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: pendingRequests.length,
      itemBuilder: (context, index) {
        final date = dates[index];
        final requestsOnDate = pendingRequests[date]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat('MMMM d, EEEE').format(date),
                style: const TextStyle(
                  color: GinaAppTheme.lightTertiaryContainer,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "SF UI Display",
                ),
              ),
            ),
            ...requestsOnDate.map(
              (request) => GestureDetector(
                onTap: () {
                  pendingRequestStateBloc.add(
                    NavigateToPendingRequestDetailEvent(
                      appointment: request,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: GinaAppTheme.lightOnTertiary,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.53,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Gap(10),
                                    CircleAvatar(
                                      radius: 20.0,
                                      backgroundImage: AssetImage(
                                        Images.patientProfileImagePlaceholder,
                                      ),
                                    ),
                                    const Gap(10),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.33,
                                      child: Text(
                                        request.patientName ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(8),
                                Text(
                                  request.modeOfAppointment ==
                                          ModeOfAppointmentId
                                              .onlineConsultation.index
                                      ? " ONLINE CONSULTATION"
                                      : " FACE-TO-FACE CONSULTATION",
                                  style: const TextStyle(
                                    color: GinaAppTheme.cancelledTextColor,
                                    fontSize: 10.0,
                                    fontFamily: "SF UI Display",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              request.appointmentTime ?? "",
                              style: const TextStyle(
                                color: GinaAppTheme.cancelledTextColor,
                                fontSize: 12.0,
                                fontFamily: "SF UI Display",
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Gap(8.0),
                            AppointmentStatusContainer(
                              appointmentStatus: request.appointmentStatus,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
