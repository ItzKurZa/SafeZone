import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    // Simulate network delay for UI/UX Demo
    await Future.delayed(const Duration(seconds: 2));

    // Basic Mock Validation
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      emit(AuthSuccess());
    } else {
      emit(const AuthError('Please enter both email and password'));
    }
  }
}
