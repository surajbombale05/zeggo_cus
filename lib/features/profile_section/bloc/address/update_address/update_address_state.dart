part of 'update_address_cubit.dart';

sealed class UpdateAddressState extends Equatable {}

final class UpdateAddressInitial extends UpdateAddressState {
  @override
  List<Object?> get props => [];
}

final class UpdateAddressLoadingState extends UpdateAddressState {
  @override
  List<Object?> get props => [];
}


final class UpdateAddressLoadedState extends UpdateAddressState {
  @override
  List<Object?> get props => [];
}


final class UpdateAddressErrorState extends UpdateAddressState {
  final String error;
  UpdateAddressErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
