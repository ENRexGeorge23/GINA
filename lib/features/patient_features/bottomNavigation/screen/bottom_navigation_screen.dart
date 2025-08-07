import 'package:first_app/core/resources/images.dart';
import 'package:first_app/features/patient_features/bottomNavigation/bloc/bottom_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationProvider extends StatelessWidget {
  const BottomNavigationProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBloc>(
      create: (context) => BottomNavigationBloc(),
      child: const BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          return NavigationBar(
            selectedIndex: state.currentIndex,
            onDestinationSelected: (index) {
              context
                  .read<BottomNavigationBloc>()
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
                icon: Image.asset(Images.findUnselectedIcon,
                    width: 24, height: 24),
                selectedIcon:
                    Image.asset(Images.findSelectedIcon, width: 28, height: 28),
                label: 'Find',
              ),
              NavigationDestination(
                icon: Image.asset(Images.appointmentsUnselectedIcon,
                    width: 24, height: 24),
                selectedIcon: Image.asset(Images.appointmentsSelectedIcon,
                    width: 28, height: 28),
                label: 'Appointments',
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
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          return state.selectedScreen;
        },
      ),
    );
  }
}
