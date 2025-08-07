import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import '../../../../../core/theme/theme_service.dart';

Future<dynamic> declinedVerificationInformationDialog(
  BuildContext context,
  String declinedReason,
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
      content: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                left: MediaQuery.of(context).size.width * 0.29,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    color: GinaAppTheme.lightOutline,
                  ),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.cancel_rounded,
                      color: GinaAppTheme.lightError,
                      size: 80,
                    ),
                    const Gap(30),
                    Text(
                      'Doctor Verification Declined',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Gap(15),
                    Text(
                      'Reason for declining the verification:',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: GinaAppTheme.lightOutline),
                    ),
                    const Gap(20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextFormField(
                        initialValue: declinedReason,
                        readOnly: true,
                        maxLines: null,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: GinaAppTheme.lightOnBackground),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const Gap(40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
