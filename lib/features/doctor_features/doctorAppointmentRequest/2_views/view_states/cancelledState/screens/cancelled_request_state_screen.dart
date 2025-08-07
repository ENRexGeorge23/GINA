import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/cancelledState/bloc/cancelled_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/cancelledState/screens/view_states/cancel_request_details_state_screen.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/cancelledState/screens/view_states/cancelled_request_state_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelledRequestStateScreenProvider extends StatelessWidget {
  const CancelledRequestStateScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CancelledRequestStateBloc>(
      create: (context) {
        final cancelledRequestBloc = sl<CancelledRequestStateBloc>();
        cancelledRequestBloc.add(CancelledRequestStateInitialEvent());
        return cancelledRequestBloc;
      },
      child: const CancelledRequestStateScreen(),
    );
  }
}

class CancelledRequestStateScreen extends StatelessWidget {
  const CancelledRequestStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CancelledRequestStateBloc, CancelledRequestStateState>(
        listenWhen: (previous, current) =>
            current is CancelledRequestActionState,
        buildWhen: (previous, current) =>
            current is! CancelledRequestActionState,
        listener: (context, state) {
          if (state is NavigateToCancelledRequestDetailState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CancelledRequestDetailScreenState(
                  appointment: state.appointment,
                ),
              ),
            ).then((value) => context
                .read<CancelledRequestStateBloc>()
                .add(CancelledRequestStateInitialEvent()));
          }
        },
        builder: (context, state) {
          if (state is GetCancelledRequestSuccessState) {
            final cancelledRequests = state.cancelledRequests;
            return CancelledRequestStateScreenLoaded(
              cancelledRequests: cancelledRequests,
            );
          } else if (state is GetCancelledRequestFailedState) {
            return Center(child: Text(state.message));
          } else if (state is CancelledRequestLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
