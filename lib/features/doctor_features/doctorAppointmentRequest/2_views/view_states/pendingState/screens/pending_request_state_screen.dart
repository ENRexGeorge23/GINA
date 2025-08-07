import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/pendingState/bloc/pending_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/pendingState/screens/view_states/pending_request_details_screen_state.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/pendingState/screens/view_states/pending_request_state_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingRequestStateScreenProvider extends StatelessWidget {
  const PendingRequestStateScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PendingRequestStateBloc>(
      create: (context) {
        final pendingRequestBloc = sl<PendingRequestStateBloc>();
        isFromPendingRequest = false;
        pendingRequestBloc.add(PendingRequestStateInitialEvent());
        return pendingRequestBloc;
      },
      child: const PendingRequestStateScreen(),
    );
  }
}

class PendingRequestStateScreen extends StatelessWidget {
  const PendingRequestStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PendingRequestStateBloc, PendingRequestStateState>(
        listenWhen: (previous, current) => current is PendingRequestActionState,
        buildWhen: (previous, current) => current is! PendingRequestActionState,
        listener: (context, state) {
          if (state is NavigateToPendingRequestDetailState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PendingRequestDetailScreenState(
                  appointment: state.appointment,
                  patientData: state.patientDate,
                ),
              ),
            ).then((value) => context
                .read<PendingRequestStateBloc>()
                .add(PendingRequestStateInitialEvent()));
          }
        },
        builder: (context, state) {
          if (state is GetPendingRequestSuccessState) {
            final pendingRequests = state.pendingRequests;
            return PendingRequestStateScreenLoaded(
              pendingRequests: pendingRequests,
            );
          } else if (state is GetPendingRequestFailedState) {
            return Center(child: Text(state.message));
          } else if (state is PendingRequestLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
