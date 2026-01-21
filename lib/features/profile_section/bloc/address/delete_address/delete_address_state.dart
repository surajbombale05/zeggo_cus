part of 'delete_address_cubit.dart';

sealed class DeleteAddressState extends Equatable {}

final class DeleteAddressInitial extends DeleteAddressState {
  @override
  List<Object?> get props => [];
}

final class DeleteAddressLoadingState extends DeleteAddressState {
  @override
  List<Object?> get props => [];
}


final class DeleteAddressLoadedState extends DeleteAddressState {
  @override
  List<Object?> get props => [];
}


final class DeleteAddressErrorState extends DeleteAddressState {
  final String error;
  DeleteAddressErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
