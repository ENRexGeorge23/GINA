import 'dart:io';

import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/patient_features/appointment/2_views/bloc/appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PrescriptionImagesList extends StatelessWidget {
  const PrescriptionImagesList({
    super.key,
    required this.prescriptionImage,
    required this.imageTitle,
    required this.appointmentBloc,
  });

  final List<File> prescriptionImage;
  final List<File> imageTitle;
  final AppointmentBloc appointmentBloc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.43,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Prescription(s) to be Uploaded',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Gap(10),
            Expanded(
              child: ListView.builder(
                  itemCount: prescriptionImage.length,
                  itemBuilder: (context, index) {
                    final image = prescriptionImage[index];
                    final title = imageTitle[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                          color: GinaAppTheme.appbarColorLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.file(
                                image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                              const Gap(20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      title.path.split('/').last,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(10),
                              InkWell(
                                onTap: () {
                                  appointmentBloc
                                      .add(RemoveImageEvent(index: index));
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: GinaAppTheme.lightOutline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {
                  isUploadPrescriptionMode = true;
                  appointmentBloc.add(
                    UploadPrescriptionEvent(
                      appointmentUid: storedAppointmentUid!,
                      images: prescriptionImage,
                    ),
                  );
                },
                child: Text(
                  'Upload',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
