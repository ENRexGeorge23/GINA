import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/0_model/user_model.dart';
import 'package:first_app/features/patient_features/profile/2_views/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProfileScreenLoaded extends StatelessWidget {
  final UserModel patientData;
  const ProfileScreenLoaded({super.key, required this.patientData});

  @override
  Widget build(BuildContext context) {
    final ginaTheme = Theme.of(context);
    final profileBloc = context.read<ProfileBloc>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: GinaAppTheme.lightOnTertiary,
          ),
          height: MediaQuery.of(context).size.height / 1.52,
          width: MediaQuery.of(context).size.width / 1.05,
          child: Column(
            children: [
              const Gap(30),
              SizedBox(
                child: Image.asset(
                  Images.patientProfileImagePlaceholder,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(15),
              Column(
                children: [
                  Text(
                    patientData.name,
                    style: ginaTheme.textTheme.headlineSmall?.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  Text(patientData.email,
                      style: ginaTheme.textTheme.bodySmall
                          ?.copyWith(color: GinaAppTheme.lightOutline)),
                ],
              ),
              const Gap(10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.038,
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        width: 1.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    profileBloc.add(NavigateToEditProfileEvent());
                  },
                  child: Text('Edit Profile',
                      style: ginaTheme.textTheme.labelLarge?.copyWith(
                        color: GinaAppTheme.lightOnPrimaryColor,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
              const Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Birth date',
                                style: ginaTheme.textTheme.bodySmall?.copyWith(
                                    color: GinaAppTheme.lightOutline)),
                            const Gap(3),
                            Text(
                              patientData.dateOfBirth,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gender',
                                style: ginaTheme.textTheme.bodySmall?.copyWith(
                                    color: GinaAppTheme.lightOutline)),
                            const Gap(3),
                            Text(
                              patientData.gender,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      thickness: 0.5,
                      color: GinaAppTheme.lightOutline,
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address',
                            style: ginaTheme.textTheme.bodySmall
                                ?.copyWith(color: GinaAppTheme.lightOutline)),
                        const Gap(3),
                        Text(
                          patientData.address,
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      thickness: 0.5,
                      color: GinaAppTheme.lightOutline,
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            profileBloc
                                .add(ProfileNavigateToCycleHistoryEvent());
                          },
                          child: Container(
                            height: 90,
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: GinaAppTheme.lightOnTertiary,
                              image: DecorationImage(
                                image: AssetImage(Images.patientCycleHistory),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child: Text('View \nCycle History',
                                  style: ginaTheme.textTheme.headlineSmall
                                      ?.copyWith(
                                    color: GinaAppTheme.lightOnTertiary,
                                    fontSize: 18,
                                  )),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            profileBloc
                                .add(ProfileNavigateToMyForumsPostEvent());
                          },
                          child: Container(
                            height: 90,
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: GinaAppTheme.lightOnTertiary,
                              image: DecorationImage(
                                image: AssetImage(Images.patientForumPost),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'My Forum\nPost',
                                style:
                                    ginaTheme.textTheme.headlineSmall?.copyWith(
                                  color: GinaAppTheme.lightOnTertiary,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
