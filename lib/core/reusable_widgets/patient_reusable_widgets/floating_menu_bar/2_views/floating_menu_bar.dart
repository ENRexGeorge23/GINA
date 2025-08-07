import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/patient_reusable_widgets/floating_menu_bar/2_views/bloc/floating_menu_bloc.dart';
import 'package:first_app/core/storage/sharedPreferences/shared_preferences_manager.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/1_controllers/patient_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FloatingMenuWidget extends StatelessWidget {
  const FloatingMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ginaTheme = Theme.of(context);
    final floatingMenuBloc = context.read<FloatingMenuBloc>();
    final textStyle = ginaTheme.textTheme.titleMedium?.copyWith(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
    return SubmenuButton(
      onOpen: () {
        floatingMenuBloc.add(GetPatientNameEvent());
      },
      style: const ButtonStyle(
        shape: MaterialStatePropertyAll<CircleBorder>(
          CircleBorder(
            side: BorderSide(
              color: GinaAppTheme.appbarColorLight,
            ),
          ),
        ),
      ),
      menuStyle: const MenuStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(
          GinaAppTheme.appbarColorLight,
        ),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
          )),
        ),
      ),
      menuChildren: [
        MenuItemButton(
          child: Row(children: [
            Image.asset(
              Images.profileIcon,
              width: 35,
            ),
            const Gap(10),
            BlocBuilder<FloatingMenuBloc, FloatingMenuState>(
              builder: (context, state) {
                if (state is GetPatientName) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: Text(
                      state.patientName,
                      style: ginaTheme.textTheme.headlineSmall?.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  );
                }

                return Text(
                  'Loading .....',
                  style: ginaTheme.textTheme.headlineSmall?.copyWith(
                    fontSize: 15,
                  ),
                );
              },
            ),
          ]),
          onPressed: () {},
        ),
        const Divider(
          thickness: 0.2,
          height: 3,
        ),
        // MenuItemButton(
        //   child: Row(
        //     children: [
        //       const Gap(30),
        //       Image.asset(
        //         Images.notificationIcon,
        //         width: 20,
        //       ),
        //       const Gap(10),
        //       Text(
        //         'Notifications',
        //         style: textStyle,
        //       ),
        //     ],
        //   ),
        //   onPressed: () {},
        // ),
        // const Divider(
        //   thickness: 0.2,
        //   height: 5,
        // ),
        MenuItemButton(
          child: Row(
            children: [
              const Gap(30),
              Image.asset(
                Images.emergencyNotificationIcon,
                width: 20,
              ),
              const Gap(10),
              Text(
                'Emergency \nAnnouncements',
                style: textStyle,
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/emergencyAnnouncements');
          },
        ),
        const Divider(
          thickness: 0.2,
          height: 5,
        ),
        MenuItemButton(
          child: Row(
            children: [
              const Gap(30),
              Image.asset(
                Images.logoutIcon,
                width: 20,
              ),
              const Gap(10),
              Text(
                'Logout',
                style: textStyle,
              ),
            ],
          ),
          onPressed: () {
            AuthenticationController().logout().then((value) => {
                  SharedPreferencesManager().logout(),
                  Navigator.pushReplacementNamed(context, '/login'),
                });
          },
        ),
      ],
      child: Image.asset(
        Images.profileIcon,
        width: 40,
      ),
    );
  }
}
