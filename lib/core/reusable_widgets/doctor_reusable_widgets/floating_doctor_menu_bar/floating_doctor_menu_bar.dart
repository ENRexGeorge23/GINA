import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/reusable_widgets/doctor_reusable_widgets/floating_doctor_menu_bar/bloc/floating_doctor_menu_bar_bloc.dart';
import 'package:first_app/core/storage/sharedPreferences/shared_preferences_manager.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/1_controllers/doctor_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FloatingDoctorMenuWidget extends StatelessWidget {
  const FloatingDoctorMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ginaTheme = Theme.of(context);
    final textStyle = ginaTheme.textTheme.titleMedium?.copyWith(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
    final floatingDoctorMenuBloc = context.read<FloatingDoctorMenuBarBloc>();
    return SubmenuButton(
      onOpen: () {
        floatingDoctorMenuBloc.add(GetDoctorNameEvent());
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
          child: Row(
            children: [
              Image.asset(
                Images.doctorProfileIcon,
                width: 35,
              ),
              const Gap(10),
              BlocBuilder<FloatingDoctorMenuBarBloc,
                  FloatingDoctorMenuBarState>(
                builder: (context, state) {
                  if (state is GetDoctorName) {
                    return Text(
                      'Dr. ${state.doctorName}',
                      style: ginaTheme.textTheme.headlineSmall?.copyWith(
                        fontSize: 15,
                      ),
                    );
                  }
                  return Text(
                    'Loading .........',
                    style: ginaTheme.textTheme.headlineSmall?.copyWith(
                      fontSize: 15,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8), // Adjust the width as needed
              const Icon(
                Icons.verified,
                color: Colors.blue,
                size: 18,
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/doctorProfileDetails');
          },
        ),
        // const Divider(
        //   thickness: 0.2,
        //   height: 3,
        // ),
        // MenuItemButton(
        //   child: Row(
        //     children: [
        //       const Gap(30),
        //       Image.asset(
        //         Images.doctorNotificationIcon,
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
        const Divider(
          thickness: 0.2,
          height: 5,
        ),
        MenuItemButton(
          child: Row(
            children: [
              const Gap(30),
              Image.asset(
                Images.doctorPatientListIcon,
                width: 20,
              ),
              const Gap(10),
              Text(
                'Patients List',
                style: textStyle,
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/doctorsPatientsList');
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
                Images.doctorForumsIcon,
                width: 20,
              ),
              const Gap(10),
              Text(
                'Forum Doctor Badge',
                style: textStyle,
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/doctorForumBadge');
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
                Images.doctorConsultationFeeIcon,
                width: 20,
              ),
              const Gap(10),
              Text(
                'Consultation Fee',
                style: textStyle,
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/doctorConsultationFee');
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
                Images.doctorLogoutIcon,
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
            DoctorAuthenticationController().logout().then((value) => {
                  SharedPreferencesManager().logout(),
                  Navigator.pushReplacementNamed(context, '/login'),
                });
          },
        ),
      ],
      child: Image.asset(
        Images.doctorProfileIcon,
        width: 40,
      ),
    );
  }
}
