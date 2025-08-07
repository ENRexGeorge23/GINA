import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/floating_doctor_menu_bar/floating_doctor_menu_bar.dart';
import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/auth/2_views/widgets/doctor_gina_header.dart';

import 'package:first_app/features/doctor_features/homeDashboard/2_views/bloc/home_dashboard_bloc.dart';
import 'package:first_app/features/doctor_features/homeDashboard/2_views/screens/view_states/home_dashboard_screen_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreenDashBoardProvider extends StatelessWidget {
  const HomeScreenDashBoardProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeDashboardBloc>(
      create: (context) {
        final homeDashboardBloc = sl<HomeDashboardBloc>();
        homeDashboardBloc.add(HomeInitialEvent());
        return homeDashboardBloc;
      },
      child: const HomeDashboardScreen(),
    );
  }
}

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const GinaDoctorHeader(
          size: 45,
        ),
        actions: const [
          FloatingDoctorMenuWidget(),
          Gap(10),
        ],
      ),
      body: BlocConsumer<HomeDashboardBloc, HomeDashboardState>(
        listenWhen: (previous, current) => current is HomeDashboardActionState,
        buildWhen: (previous, current) => current is! HomeDashboardActionState,
        listener: (context, state) {
          if (state is HomeDashboardNavigateToFindDoctorActionState) {
            Navigator.pushNamed(context, '/find');
          }
        },
        builder: (context, state) {
          if (state is HomeDashboardInitial) {
            return HomeDashboardScreenLoaded(
              pendingRequests: state.pendingAppointments,
              confirmedAppointments: state.confirmedAppointments,
            );
          }

          return const HomeDashboardScreenLoaded(
            pendingRequests: 0,
            confirmedAppointments: 0,
          );
        },
      ),
    );
  }
}
