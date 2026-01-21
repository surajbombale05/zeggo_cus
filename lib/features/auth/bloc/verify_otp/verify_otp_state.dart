part of 'verify_otp_cubit.dart';

sealed class VerifyOtpState extends Equatable {}

final class VerifyOtpInitial extends VerifyOtpState {
  @override
  List<Object?> get props => [];
}

final class VerifyOtpLoadingState extends VerifyOtpState {
  @override
  List<Object?> get props => [];
}

final class VerifyOtpLoadedState extends VerifyOtpState {
  final VerifyOtpModel model;
  VerifyOtpLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}

final class VerifyOtpErrorState extends VerifyOtpState {
  final String error;
  VerifyOtpErrorState(this.error);
  @override
  List<Object?> get props => [error];
}