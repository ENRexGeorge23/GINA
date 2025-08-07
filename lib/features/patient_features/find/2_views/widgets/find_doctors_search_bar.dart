import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/find/2_views/bloc/find_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindDoctorsSearchBar extends StatelessWidget {
  final FindBloc findBloc;
  const FindDoctorsSearchBar({
    super.key,
    required this.findBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        child: BlocBuilder<FindBloc, FindState>(
          bloc: findBloc,
          builder: (context, state) {
            return SearchAnchor(
              headerTextStyle:
                  Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: GinaAppTheme.lightOnPrimaryColor,
                        fontSize: 15,
                      ),
              isFullScreen: false,
              viewBackgroundColor: Colors.white,
              viewElevation: 0,
              viewShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              viewConstraints: const BoxConstraints(
                minHeight: 100,
                maxHeight: 350,
              ),
              dividerColor: GinaAppTheme.lightOnSecondary,
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: GinaAppTheme.lightOnPrimaryColor,
                          fontSize: 15,
                        ),
                  ),
                  hintStyle: MaterialStateProperty.all<TextStyle>(
                    Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: GinaAppTheme.lightOutline,
                          fontSize: 15,
                        ),
                  ),
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  elevation: MaterialStateProperty.all<double>(0),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      GinaAppTheme.lightOnTertiary),
                  hintText: 'Search for doctors',
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      Images.findUnselectedIcon,
                      width: 20,
                    ),
                  ),
                  onTap: () {
                    findBloc.add(GetAllDoctorsEvent());
                  },
                  onChanged: (value) {
                    controller.openView();
                    controller.text = value;
                  },
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                final filteredDoctors = getAllDoctors!
                    .where((doctor) => doctor.name
                        .toLowerCase()
                        .contains(controller.text.toLowerCase()))
                    .toList();

                if (filteredDoctors.isEmpty) {
                  return [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 120.0),
                      child: Center(
                          child: Text(
                        'No doctors found',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: GinaAppTheme.lightOnPrimaryColor,
                                  fontSize: 15,
                                ),
                      )),
                    )
                  ];
                }
                return filteredDoctors.map((doctor) {
                  return ListTile(
                    leading: Image.asset(Images.findDoctorImage),
                    title: Text(
                      'Dr. ${doctor.name}',
                      style: const TextStyle(
                        color: GinaAppTheme.lightOnPrimaryColor,
                      ),
                    ),
                    subtitle: Text(
                      doctor.medicalSpecialty,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: GinaAppTheme.lightOutline,
                          ),
                    ),
                    onTap: () {
                      controller.closeView(doctor.name);
                      findBloc.add(
                        FindNavigateToDoctorDetailsEvent(doctor: doctor),
                      );
                    },
                  );
                });
              },
            );
          },
        ),
      ),
    );
  }
}
