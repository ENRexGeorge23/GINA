import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/declinedState/bloc/declined_request_state_bloc.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/declinedState/screens/view_states/decline_request_details_screen_state.dart';
import 'package:first_app/features/doctor_features/doctorAppointmentRequest/2_views/view_states/declinedState/screens/view_states/declined_request_state_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeclinedRequestStateScreenProvider extends StatelessWidget {
  const DeclinedRequestStateScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeclinedRequestStateBloc>(
      create: (context) {
        final declinedRequestBloc = sl<DeclinedRequestStateBloc>();
        declinedRequestBloc.add(DeclinedRequestStateInitialEvent());
        return declinedRequestBloc;
      },
      child: const DeclinedRequestStateScreen(),
    );
  }
}

class DeclinedRequestStateScreen extends StatelessWidget {
  const DeclinedRequestStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DeclinedRequestStateBloc, DeclinedRequestStateState>(
        listenWhen: (previous, current) =>
            current is DeclinedRequestActionState,
        buildWhen: (previous, current) =>
            current is! DeclinedRequestActionState,
        listener: (context, state) {
          if (state is NavigateToDeclinedRequestDetailState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeclineRequestDetailScreenState(
                  appointment: state.appointment,
                ),
              ),
            ).then((value) => context
                .read<DeclinedRequestStateBloc>()
                .add(DeclinedRequestStateInitialEvent()));
          }
        },
        builder: (context, state) {
          if (state is GetDeclinedRequestSuccessState) {
            final declinedRequests = state.declinedRequests;
            return DeclinedRequestStateScreenLoaded(
              declinedRequests: declinedRequests,
            );
          } else if (state is GetDeclinedRequestFailedState) {
            return Center(child: Text(state.message));
          } else if (state is DeclinedRequestLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
