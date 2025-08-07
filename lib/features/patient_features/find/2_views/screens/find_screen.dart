import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:first_app/features/patient_features/find/2_views/screens/view_states/find_screen_loaded.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/floating_menu_bar/2_views/floating_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FindScreenProvider extends StatelessWidget {
  const FindScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FindBloc>(
      create: (context) {
        final findBloc = sl<FindBloc>();
        findBloc.add(GetDoctorsNearMeEvent());
        findBloc.add(GetDoctorsInTheNearestCityEvent());

        findBloc.add(GetAllDoctorsEvent());
        return findBloc;
      },
      child: const FindScreen(),
    );
  }
}

class FindScreen extends StatelessWidget {
  const FindScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final findBloc = context.read<FindBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        notificationPredicate: (notification) => false,
        title: Text(
          'Find Doctors',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: const [
          FloatingMenuWidget(),
          Gap(10),
        ],
      ),
      body: BlocConsumer<FindBloc, FindState>(
        listenWhen: (previous, current) => current is FindActionState,
        buildWhen: (previous, current) => current is! FindActionState,
        listener: (context, state) {
          if (state is FindNavigateToDoctorDetailsState) {
            Navigator.pushNamed(
              context,
              '/doctorDetails',
              arguments: state.doctor,
            ).then((value) {
              findBloc.add(GetDoctorsInTheNearestCityEvent());
            });
          }
        },
        builder: (context, state) {
          if (state is FindLoading) {
            return const CircularProgressIndicator();
          } else if (state is FindLoaded) {
            return const FindScreenLoaded();
          }
          return const FindScreenLoaded();
        },
      ),
    );
  }
}
