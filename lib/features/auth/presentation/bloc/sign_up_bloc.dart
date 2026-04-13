import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpRoleStep()) {
    on<RoleSelected>(_onRoleSelected);
    on<SignUpStep1Submitted>(_onStep1Submitted);
    on<SignUpStep2Submitted>(_onStep2Submitted);
    on<OtpSubmitted>(_onOtpSubmitted);
    on<OtpResendRequested>(_onOtpResend);
  }

  void _onRoleSelected(RoleSelected event, Emitter<SignUpState> emit) {
    emit(SignUpRoleStep(selectedRole: event.role));
  }

  void _onStep1Submitted(
      SignUpStep1Submitted event, Emitter<SignUpState> emit) {
    final currentState = state;
    if (currentState is SignUpRoleStep) {
      // Role step → advance
      final role = currentState.selectedRole ?? 'civilian';
      if (role == 'rescuer') {
        // Rescuers skip the Name/Email/Password step and go straight to their specific fields
        emit(SignUpPersonalInfoStep(role: role, name: '', email: ''));
      } else {
        emit(SignUpCredentialsStep(role: role));
      }
    } else if (currentState is SignUpCredentialsStep) {
      // Credentials step → advance to personal info
      emit(SignUpPersonalInfoStep(
        role: currentState.role,
        name: event.name,
        email: event.email,
      ));
    }
  }

  void _onStep2Submitted(
      SignUpStep2Submitted event, Emitter<SignUpState> emit) {
    // Personal info step → OTP
    final currentState = state;
    if (currentState is SignUpPersonalInfoStep) {
      emit(SignUpOtpStep(role: currentState.role));
    }
  }

  Future<void> _onOtpSubmitted(
      OtpSubmitted event, Emitter<SignUpState> emit) async {
    final currentState = state;
    if (currentState is SignUpOtpStep) {
      final role = currentState.role;
      emit(const SignUpLoading());
      await Future.delayed(const Duration(seconds: 1));
      // Mock: always succeed for demo UI
      emit(SignUpSuccess(role: role));
    }
  }

  void _onOtpResend(
      OtpResendRequested event, Emitter<SignUpState> emit) {
    // Mock: resend — stay on OTP step, UI shows snackbar
    final currentState = state;
    if (currentState is SignUpOtpStep) {
      emit(SignUpOtpStep(role: currentState.role));
    }
  }
}
