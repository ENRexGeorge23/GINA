import 'package:first_app/core/resources/images.dart';
import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/auth/2_views/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DoctorUploadStatusScreen extends StatelessWidget {
  const DoctorUploadStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload Medical License',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Gap(10),
            const Text(
              "The file must be submitted in the format JPG, JPEG, PNG or PDF, and the file size is limited to 2.5 MB.",
              textAlign: TextAlign.left,
            ),
            const Gap(35),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Images.doctorVerificatonBorder,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    authBloc.add(ChooseMedicalIdImageEvent());
                  },
                  child: Image.asset(
                    Images.doctorImportButton,
                  ),
                ),
              ),
            ),
            const Gap(25),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is UploadMedicalImageLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is UploadMedicalImageState) {
                  final image = state.medicalImageId;
                  final imageTitle = state.medicalImageIdTitle;
                  return image.path.isEmpty
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Medical License to be Uploaded for Verification',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const Gap(25),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              decoration: BoxDecoration(
                                color: GinaAppTheme.appbarColorLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Image.file(
                                      image,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.contain,
                                    ),
                                    const Gap(20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Gap(20),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            imageTitle.path.split('/').last,
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
                                        authBloc
                                            .add(RemoveMedicalIdImageEvent());
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
                            const Gap(50),
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
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Upload File',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
