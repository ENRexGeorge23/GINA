import 'package:first_app/core/theme/theme_service.dart';
import 'package:first_app/features/admin_features/adminDoctorList/2_views/widgets/doctor_list_label.dart';
import 'package:first_app/features/admin_features/adminDoctorList/2_views/widgets/list_of_all_doctors_list.dart';
import 'package:first_app/features/auth/0_model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminDoctorListLoaded extends StatelessWidget {
  final List<DoctorModel> approvedDoctorList;
  const AdminDoctorListLoaded({
    super.key,
    required this.approvedDoctorList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: GinaAppTheme.appbarColorLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    'List of all Doctors',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Gap(20),
                DoctorListLabel(
                  context: context,
                ),
                ListOfAllDoctors(
                  approvedDoctorList: approvedDoctorList,
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}