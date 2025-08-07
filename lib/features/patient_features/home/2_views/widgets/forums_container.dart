import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/home/2_views/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForumsContainer extends StatelessWidget {
  const ForumsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();

    return GestureDetector(
      onTap: () {
        homeBloc.add(HomeNavigateToForumEvent());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: GinaAppTheme.lightPrimaryColor,
        ),
        height: 160,
        width: MediaQuery.of(context).size.width / 3.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.forumImage,
              width: 120,
              height: 115,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('Forums',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
            ),
            const Gap(10)
          ],
        ),
      ),
    );
  }
}
