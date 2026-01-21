part of 'send_otp_cubit.dart';

sealed class SendOtpState extends Equatable {}

final class SendOtpInitial extends SendOtpState {
  @override
  List<Object?> get props => [];
}

final class SendOtpLoadingState extends SendOtpState {
  @override
  List<Object?> get props => [];
}

final class SendOtpLoadedState extends SendOtpState {
  final SendOtpModel model;
  SendOtpLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}

final class SendOtpErrorState extends SendOtpState {
  final String error;
  SendOtpErrorState(this.error);
  @override
  List<Object?> get props => [];
}
