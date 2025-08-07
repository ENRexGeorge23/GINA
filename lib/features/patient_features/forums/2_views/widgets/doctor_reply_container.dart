import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorReplyContainer extends StatelessWidget {
  const DoctorReplyContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          children: [
            const Gap(10),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      AssetImage(Images.doctorProfileImagePlaceholder),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(Images.newDoctorBadge, scale: 1.009),
                    Row(
                      children: [
                        Text(
                          'Dr. Maria Santos',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const Gap(5),
                        const Icon(
                          Icons.verified_rounded,
                          color: Color(0xff29A5FF),
                          size: 15,
                        )
                      ],
                    ),
                    Text(
                      '5 mins',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: GinaAppTheme.lightOutline),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),
            const Text(
                "Hey Dulce!\nTampons:\n • Pros: They're super handy for activities, like swimming or sports, and they're discreet.\n • Cons: At first, they can be a bit tricky to insert, and you have to change them quite often.\nMenstrual Cups:\n • Pros: They're eco-friendly, and in the long run, they're cost-effective. Plus, you can wear them for up to 12 hours.\n • Cons: It might take some getting used to when inserting and removing them, and the initial cost is a bit higher.\n Remember to think about comfort, flow, and the environment when you decide."),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
