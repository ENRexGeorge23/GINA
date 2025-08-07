import 'package:first_app/dependencies_injection.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/bloc/admin_patient_list_bloc.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/screens/view_states/admin_patient_details_state.dart';
import 'package:first_app/features/admin_features/adminPatientList/2_views/screens/view_states/admin_patient_list_loaded_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPatientListScreenProvider extends StatelessWidget {
  const AdminPatientListScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminPatientListBloc>(
      create: (context) {
        final adminPatientListBloc = sl<AdminPatientListBloc>();
        adminPatientListBloc.add(AdminPatientListGetRequestedEvent());
        return adminPatientListBloc;
      },
      child: const AdminPatientListScreen(),
    );
  }
}

class AdminPatientListScreen extends StatelessWidget {
  const AdminPatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        notificationPredicate: (notification) => false,
        automaticallyImplyLeading: false,
        title: const Text(''),
      ),
      body: BlocConsumer<AdminPatientListBloc, AdminPatientListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AdminPatientListLoadedState) {
            return AdminPatientListLoaded(
              patientList: state.patients,
            );
          } else if (state is AdminPatientListErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is AdminPatientListPatientDetailsState) {
            return AdminPatientDetailsState(
              patientDetails: state.patientDetails,
              appointments: state.appointmentDetails,
            );
          }
          return const AdminPatientListLoaded(
            patientList: [],
          );
        },
      ),
    );
  }
}
