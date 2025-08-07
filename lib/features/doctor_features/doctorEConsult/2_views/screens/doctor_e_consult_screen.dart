import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/gina_doctor_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/bloc/doctor_e_consult_bloc.dart';
import 'package:first_app/features/doctor_features/doctorEConsult/2_views/screens/view_states/doctor_e_consult_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorEConsultScreenProvider extends StatelessWidget {
  const DoctorEConsultScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorEConsultBloc>(
      create: (context) {
        final doctorEConsultBloc = sl<DoctorEConsultBloc>();
        isFromChatRoomLists = false;
        doctorEConsultBloc.add(GetRequestedEConsultsDiplayEvent());
        return doctorEConsultBloc;
      },
      child: const DoctorEConsultScreen(),
    );
  }
}

class DoctorEConsultScreen extends StatelessWidget {
  const DoctorEConsultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GinaDoctorAppBar(title: 'E-Consult'),
      body: BlocConsumer<DoctorEConsultBloc, DoctorEConsultState>(
        listenWhen: (previous, current) => true,
        buildWhen: (previous, current) => true,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DoctorEConsultLoadedState) {
            return DoctorEConsultScreenLoaded(
              upcomingAppointment: state.upcomingAppointment,
              chatRooms: state.chatRooms,
            );
          } else if (state is DoctorEConsultErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is DoctorEConsultLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
