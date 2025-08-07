import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<RequestPasswordReset>(requestPasswordReset);
  }
  final FirebaseAuth auth = FirebaseAuth.instance;

  FutureOr<void> requestPasswordReset(
      RequestPasswordReset event, Emitter<ForgotPasswordState> emit) async {
    emit(RequestPasswordResetLoading());
    try {
      await auth.sendPasswordResetEmail(email: event.email);
      emit(RequestPasswordResetSuccess());
    } catch (error) {
      emit(RequestPasswordResetError(errorMessage: error.toString()));
    }
  }
}
