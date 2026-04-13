import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object?> get props => [];
}

class RoleSelected extends SignUpEvent {
  final String role; // 'civilian' or 'rescuer'
  const RoleSelected(this.role);
  @override
  List<Object?> get props => [role];
}

class SignUpStep1Submitted extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  const SignUpStep1Submitted({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
  @override
  List<Object?> get props => [name, email, password, confirmPassword];
}

class SignUpStep2Submitted extends SignUpEvent {
  final String phone;
  final String address;
  final String bloodType;
  final String medicalHistory;
  const SignUpStep2Submitted({
    required this.phone,
    required this.address,
    required this.bloodType,
    required this.medicalHistory,
  });
  @override
  List<Object?> get props => [phone, address, bloodType, medicalHistory];
}

class OtpSubmitted extends SignUpEvent {
  final String otp;
  const OtpSubmitted(this.otp);
  @override
  List<Object?> get props => [otp];
}

class OtpResendRequested extends SignUpEvent {
  const OtpResendRequested();
}
