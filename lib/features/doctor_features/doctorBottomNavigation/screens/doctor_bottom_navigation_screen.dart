import 'package:first_app/core/resources/images.dart';
import 'package:first_app/features/doctor_features/doctorBottomNavigation/bloc/doctor_bottom_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorBottomNavigationProvider extends StatelessWidget {
  const DoctorBottomNavigationProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorBottomNavigationBloc>(
      create: (context) => DoctorBottomNavigationBloc(),
      child: const DoctorBottomNavigation(),
    );
  }
}

class DoctorBottomNavigation extends StatelessWidget {
  const DoctorBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocBuilder<DoctorBottomNavigationBloc, DoctorBottomNavigationState>(
        builder: (context, state) {
          return NavigationBar(
            selectedIndex: state.currentIndex,
            onDestinationSelected: (index) {
              context
                  .read<DoctorBottomNavigationBloc>()
                  .add(TabChangedEvent(tab: index));
            },
            destinations: [
              NavigationDestination(
                icon: Image.asset(Images.homeUnselectedIcon,
                    width: 24, height: 24),
                selectedIcon:
                    Image.asset(Images.homeSelectedIcon, width: 30, height: 30),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Image.asset(Images.doctorRequestsUnselectedIcon,
                    width: 24, height: 24),
                selectedIcon: Image.asset(Images.doctorRequestsSelectedIcon,
                    width: 28, height: 28),
                label: 'Requests',
              ),
              NavigationDestination(
                icon: Image.asset(Images.appointmentsUnselectedIcon,
                    width: 24, height: 24),
                selectedIcon: Image.asset(Images.appointmentsSelectedIcon,
                    width: 28, height: 28),
                label: 'E-Consult',
              ),
              NavigationDestination(
                icon: Image.asset(Images.forumsUnselectedIcon,
                    width: 24, height: 24),
                selectedIcon: Image.asset(Images.forumsSelectedIcon,
                    width: 30, height: 30),
                label: 'Forums',
              ),
              NavigationDestination(
                icon: Image.asset(Images.profileUnselectedIcon,
                    width: 24, height: 24),
                selectedIcon: Image.asset(Images.profileSelectedIcon,
                    width: 28, height: 28),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
      body:
          BlocBuilder<DoctorBottomNavigationBloc, DoctorBottomNavigationState>(
        builder: (context, state) {
          return state.selectedScreen;
        },
      ),
    );
  }
}
