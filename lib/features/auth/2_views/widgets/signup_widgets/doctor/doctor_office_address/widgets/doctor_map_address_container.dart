import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/2_views/widgets/signup_widgets/doctor/doctor_registration_steps/doctor_registration_step_4.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorMapAddressContainer extends StatelessWidget {
  const DoctorMapAddressContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height:
              MediaQuery.of(context).size.height * 0.09,
          width:
              MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(
              color: GinaAppTheme.lightOutline,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.officeAddressLogo),
              const Gap(10),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      mapsLocationAddressController
                          .text,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      officeAdressController.text,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }
}
