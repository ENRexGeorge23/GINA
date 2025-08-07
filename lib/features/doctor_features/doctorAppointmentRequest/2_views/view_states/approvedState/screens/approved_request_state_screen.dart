import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/approvedState/bloc/approved_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/approvedState/screens/view_states/approved_request_details_screen_state.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/approvedState/screens/view_states/approved_request_state_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovedRequestStateScreenProvider extends StatelessWidget {
  const ApprovedRequestStateScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApprovedRequestStateBloc>(
      create: (context) {
        final approvedRequestBloc = sl<ApprovedRequestStateBloc>();
        approvedRequestBloc.add(ApprovedRequestStateInitialEvent());
        return approvedRequestBloc;
      },
      child: const ApprovedRequestStateScreen(),
    );
  }
}

class ApprovedRequestStateScreen extends StatelessWidget {
  const ApprovedRequestStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ApprovedRequestStateBloc, ApprovedRequestStateState>(
        listenWhen: (previous, current) =>
            current is ApprovedRequestActionState,
        buildWhen: (previous, current) =>
            current is! ApprovedRequestActionState,
        listener: (context, state) {
          if (state is NavigateToApprovedRequestDetailState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ApprovedRequestDetailsScreenState(
                  appointment: state.appointment,
                  patientData: state.patientDate,
                ),
              ),
            ).then((value) => context
                .read<ApprovedRequestStateBloc>()
                .add(ApprovedRequestStateInitialEvent()));
          }
        },
        builder: (context, state) {
          if (state is GetApprovedRequestSuccessState) {
            final approvedRequests = state.approvedRequests;
            return ApprovedRequestStateScreenLoaded(
              approvedRequests: approvedRequests,
            );
          } else if (state is GetApprovedRequestFailedState) {
            return Center(child: Text(state.message));
          } else if (state is ApprovedRequestLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
