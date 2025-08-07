import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/auth/2_views/widgets/gina_header.dart';
import 'package:first_app/features/patient_features/home/2_views/bloc/home_bloc.dart';
import 'package:first_app/features/patient_features/home/2_views/screens/view_states/home_screen_loaded.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/floating_menu_bar/2_views/floating_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreenProvider extends StatelessWidget {
  const HomeScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) {
        final homeBloc = sl<HomeBloc>();
        homeBloc.add(GetPatientCurrentLocationEvent());
        homeBloc.add(HomeGetPeriodTrackerDataAndConsultationHistoryEvent());

        return homeBloc;
      },
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const GinaHeader(
          size: 45,
        ),
        actions: const [
          FloatingMenuWidget(),
          Gap(10),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeNavigateToFindDoctorActionState) {
            Navigator.pushNamed(context, '/find').then((value) => {
                  homeBloc.add(
                      HomeGetPeriodTrackerDataAndConsultationHistoryEvent()),
                });
          } else if (state is HomeNavigateToForumActionState) {
            Navigator.pushNamed(context, '/forums').then((value) => {
                  homeBloc.add(
                      HomeGetPeriodTrackerDataAndConsultationHistoryEvent()),
                });
          }
        },
        builder: (context, state) {
          if (state is HomeInitial) {
            return const HomeScreenLoaded();
          }

          return const HomeScreenLoaded();
        },
      ),
    );
  }
}
