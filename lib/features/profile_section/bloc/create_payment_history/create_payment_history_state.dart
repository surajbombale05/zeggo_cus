part of 'create_payment_history_cubit.dart';

sealed class CreatePaymentHistoryState extends Equatable {}

final class CreatePaymentHistoryInitial extends CreatePaymentHistoryState {
  @override
  List<Object?> get props => [];
}

final class CreatePaymentHistoryLoadingState extends CreatePaymentHistoryState {
  @override
  List<Object?> get props => [];
}


final class CreatePaymentHistoryLoadedState extends CreatePaymentHistoryState {
  @override
  List<Object?> get props => [];
}


final class CreatePaymentHistoryErrorState extends CreatePaymentHistoryState {
  final String error;
  CreatePaymentHistoryErrorState(this.error);
  @override
  List<Object?> get props => [];
}
