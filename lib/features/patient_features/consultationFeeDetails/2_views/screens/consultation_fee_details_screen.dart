import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/gina_patient_app_bar/gina_patient_app_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/consultationFeeDetails/2_views/bloc/consultation_fee_details_bloc.dart';
import 'package:first_app/features/patient_features/consultationFeeDetails/2_views/screens/view_states/consultation_fee_details_initial_screen.dart';
import 'package:first_app/features/patient_features/consultationFeeDetails/2_views/screens/view_states/consultation_fee_no_pricing_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ConsultationFeeDetailsScreenProvider extends StatelessWidget {
  const ConsultationFeeDetailsScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConsultationFeeDetailsBloc>(
      create: (context) {
        final consultationFeeDetailsBloc = sl<ConsultationFeeDetailsBloc>();

        consultationFeeDetailsBloc.add(ToggleConsultationPricingEvent());

        return consultationFeeDetailsBloc;
      },
      child: const ConsultationFeeDetailsScreen(),
    );
  }
}

class ConsultationFeeDetailsScreen extends StatelessWidget {
  const ConsultationFeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GinaPatientAppBar(title: 'Consultation Fee Details'),
        body: BlocConsumer<ConsultationFeeDetailsBloc,
            ConsultationFeeDetailsState>(
          listenWhen: (previous, current) =>
              current is ConsultationFeeDetailsActionState,
          buildWhen: (previous, current) =>
              current is! ConsultationFeeDetailsActionState,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ConsultationFeeDetailsInitial) {
              return ConsultationFeeDetailsInitialScreen(
                isPricingShown: state.isPricingShown,
              );
            } else if (state is ConsultationFeeDetailsNoPricingState) {
              return const ConsultationFeeNoPricingScreen();
            }
            return const SizedBox();
          },
        ));
  }
}
