import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpRoleStep extends SignUpState {
  final String? selectedRole;
  const SignUpRoleStep({this.selectedRole});
  @override
  List<Object?> get props => [selectedRole];
}

class SignUpCredentialsStep extends SignUpState {
  final String role;
  const SignUpCredentialsStep({required this.role});
  @override
  List<Object?> get props => [role];
}

class SignUpPersonalInfoStep extends SignUpState {
  final String role;
  final String name;
  final String email;
  const SignUpPersonalInfoStep({
    required this.role,
    required this.name,
    required this.email,
  });
  @override
  List<Object?> get props => [role, name, email];
}

class SignUpOtpStep extends SignUpState {
  final String role;
  final String maskedPhone;
  const SignUpOtpStep({required this.role, this.maskedPhone = '036XXXXX582'});
  @override
  List<Object?> get props => [role, maskedPhone];
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignUpSuccess extends SignUpState {
  final String role;
  const SignUpSuccess({required this.role});
  @override
  List<Object?> get props => [role];
}

class SignUpError extends SignUpState {
  final String message;
  const SignUpError(this.message);
  @override
  List<Object?> get props => [message];
}
