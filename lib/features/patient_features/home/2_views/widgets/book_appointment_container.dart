import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/home/2_views/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BookAppointmentContainer extends StatelessWidget {
  const BookAppointmentContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: GinaAppTheme.lightOnTertiary,
      ),
      height: 160,
      width: MediaQuery.of(context).size.width / 1.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Text('Book\nappointment',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 18,
                              )),
                ),
                const Gap(30),
                SizedBox(
                  height: 25,
                  child: FilledButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5)),
                    ),
                    onPressed: () {
                      homeBloc.add(HomeNavigateToFindDoctorEvent());
                    },
                    child: Row(children: [
                      Text('Next',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      const Gap(8),
                      const Icon(
                        Icons.arrow_forward,
                        size: 15,
                      ),
                    ]),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                Images.appointmentImage,
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.12,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
