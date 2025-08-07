import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorForumPostWidget extends StatelessWidget {
  const DoctorForumPostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.23,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        child: Column(
          children: [
            const Gap(10),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(Images.profileIcon),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valerie Marie Astanas',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'Posted 2 hours ago',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: GinaAppTheme.lightOutline),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(10),
            Text(
                "I'm a teenage girl and I'm not sure which period product to use. What are the pros and cons of tampons, pads, and menstrual cups?",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    )),
            const Gap(10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                "I'm a 14-year-old girl and I just got my first period a few months ago. I've been using pads, but I'm not sure if th",
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Gap(10),
            Row(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.favorite_border_rounded,
                      color: GinaAppTheme.lightOnPrimaryColor,
                      size: 20,
                    ),
                    const Gap(5),
                    Text(
                      '142',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  children: [
                    Image.asset(
                      Images.forumComment,
                    ),
                    const Gap(5),
                    Text(
                      '12 replies',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
