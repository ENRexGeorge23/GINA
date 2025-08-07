import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminNavigationDrawer/2_views/bloc/admin_navigation_drawer_bloc.dart';
import 'package:first_app/features/admin_features/login/1_controllers/admin_login_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AdminNavigationDrawerProvider extends StatelessWidget {
  const AdminNavigationDrawerProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminNavigationDrawerBloc>(
      create: (context) => AdminNavigationDrawerBloc(),
      child: const AdminNavigationDrawer(),
    );
  }
}

class AdminNavigationDrawer extends StatelessWidget {
  const AdminNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminLoginControllers adminControllers = AdminLoginControllers();
    return Scaffold(
      body: BlocBuilder<AdminNavigationDrawerBloc, AdminNavigationDrawerState>(
        builder: (context, state) {
          return Container(
            color: GinaAppTheme.appbarColorLight,
            child: Row(
              children: [
                NavigationDrawer(
                  backgroundColor: GinaAppTheme.appbarColorLight,
                  elevation: 0,
                  selectedIndex: state.currentIndex,
                  indicatorShape: const BeveledRectangleBorder(),
                  tilePadding: const EdgeInsets.only(bottom: 5),
                  onDestinationSelected: (index) {
                    context
                        .read<AdminNavigationDrawerBloc>()
                        .add(TabChangedEvent(tab: index));
                  },
                  children: [
                    Image.asset(
                      Images.adminLoginLogo,
                      width: 200,
                      height: 250,
                    ),
                    NavigationDrawerDestination(
                      icon: Image.asset(
                        Images.dashboardLogo,
                        width: 25,
                        height: 25,
                      ),
                      selectedIcon: Image.asset(
                        Images.dashboardLogo,
                      ),
                      label: Text('   Dashboard',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    NavigationDrawerDestination(
                      icon: Image.asset(
                        Images.verifiedLogo,
                        width: 22,
                        height: 22,
                      ),
                      selectedIcon: Image.asset(
                        Images.verifiedLogo,
                      ),
                      label: Text('   Verify',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    NavigationDrawerDestination(
                      icon: Image.asset(
                        Images.doctorLogo,
                        width: 25,
                        height: 25,
                      ),
                      selectedIcon: Image.asset(
                        Images.doctorLogo,
                      ),
                      label: Text('   Doctors',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    NavigationDrawerDestination(
                      icon: Image.asset(
                        Images.patientLogo,
                        width: 25,
                        height: 25,
                      ),
                      selectedIcon: Image.asset(
                        Images.patientLogo,
                        width: 28,
                        height: 28,
                      ),
                      label: Text('   Patients',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    const Gap(400),
                    InkWell(
                      onTap: () async {
                        adminControllers.adminLogout();
                        Navigator.pushReplacementNamed(context, '/adminLogin');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout,
                              color: GinaAppTheme.lightOnPrimaryColor,
                              size: 25,
                            ),
                            const Gap(18),
                            Text('Logout',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<AdminNavigationDrawerBloc,
                      AdminNavigationDrawerState>(
                    builder: (context, state) {
                      return state.selectedScreen;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
