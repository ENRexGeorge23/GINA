import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/theme/theme_service.dart';

Future<dynamic> declineConfirmationDialog(
  BuildContext context,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: GinaAppTheme.appbarColorLight,
      shadowColor: GinaAppTheme.appbarColorLight,
      surfaceTintColor: GinaAppTheme.appbarColorLight,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 80,
              ),
              const Gap(30),
              Text(
                'Doctor Declined Successfully!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Gap(40),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.04,
                child: FilledButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Ok',
                    )),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
