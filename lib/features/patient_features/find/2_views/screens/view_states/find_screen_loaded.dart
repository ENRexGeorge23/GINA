import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:first_app/features/patient_features/find/2_views/widgets/doctores_near_me_lists.dart';
import 'package:first_app/features/patient_features/find/2_views/widgets/doctors_in_the_nearest_city_list.dart';
import 'package:first_app/features/patient_features/find/2_views/widgets/find_doctors_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FindScreenLoaded extends StatelessWidget {
  const FindScreenLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    final findBloc = BlocProvider.of<FindBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(15),
            //-----------------
            FindDoctorsSearchBar(
              findBloc: findBloc,
            ),
            //-----------------
            const Gap(25),
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  size: 20,
                  color: GinaAppTheme.lightOnPrimaryColor,
                ),
                const Gap(5),
                Text(
                  'Near me',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: GinaAppTheme.lightOnPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const Gap(5),

            BlocConsumer<FindBloc, FindState>(
              listenWhen: (previous, current) => current is FindActionState,
              buildWhen: (previous, current) => current is! FindActionState,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetDoctorNearMeSuccessState) {
                  final doctorLists = state.doctorLists;
                  return DoctorsNearMeList(
                    doctorLists: doctorLists,
                  );
                } else if (state is GetDoctorNearMeFailedState) {
                  return const SizedBox(
                    height: 180,
                    child: Center(
                      child: Text(
                        'No doctors found near your area',
                      ),
                    ),
                  );
                } else if (state is GetDoctorNearMeLoadingState) {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: CircularProgressIndicator(),
                  ));
                }
                return DoctorsNearMeList(
                  doctorLists: doctorNearMeLists ?? [],
                );
              },
            ),

            const Gap(25),
            const Divider(
              thickness: 0.2,
              height: 3,
            ),
            const Gap(15),

            BlocConsumer<FindBloc, FindState>(
              listenWhen: (previous, current) => current is FindActionState,
              buildWhen: (previous, current) => current is! FindActionState,
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetDoctorsInTheNearestCitySuccessState) {
                  final citiesWithDoctors = state.citiesWithDoctors;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: citiesWithDoctors.entries.map((entry) {
                      final cityName = entry.key;
                      final doctors = entry.value;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.14 *
                            doctors.length,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              cityName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const Gap(5),
                            DoctorsInTheNearestCityList(
                              doctorLists: doctors,
                            ),
                            const Gap(5),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: const Divider(
                                  thickness: 0.2,
                                  // height: 5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                } else if (state is GetDoctorsInTheNearestCityFailedState) {
                  return Text(state.message);
                } else if (state is GetDoctorsInTheNearestCityLoadingState) {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: CircularProgressIndicator(),
                  ));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
