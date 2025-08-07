import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:first_app/features/admin_features/login/1_controllers/admin_login_controllers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_login_event.dart';
part 'admin_login_state.dart';

class AdminLoginBloc extends Bloc<AdminLoginEvent, AdminLoginState> {
  final AdminLoginControllers adminLoginControllers;
  AdminLoginBloc({
    required this.adminLoginControllers,
  }) : super(AdminLoginInitial()) {
    on<AdminLoginEventLogin>(adminLoginEventLogin);
  }

  FutureOr<void> adminLoginEventLogin(
      AdminLoginEventLogin event, Emitter<AdminLoginState> emit) async {
    emit(AdminLoginLoadingState());

    try {
      await adminLoginControllers.adminLogin(
        email: event.email,
        password: event.password,
      );

      emit(AdminLoginSuccessState());
    } catch (e) {
      emit(AdminLoginFailureState("Your account don't have admin access"));
    }
  }
}
