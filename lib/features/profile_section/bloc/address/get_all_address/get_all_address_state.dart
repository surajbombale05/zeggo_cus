part of 'get_all_address_cubit.dart';

sealed class GetAllAddressState extends Equatable {}

final class GetAllAddressInitial extends GetAllAddressState {
  @override
  List<Object?> get props => [];
}

final class GetAllAddressLoadingState extends GetAllAddressState {
  @override
  List<Object?> get props => [];
}

final class GetAllAddressLoadedState extends GetAllAddressState {
  final GetAllAddressModel model;
  GetAllAddressLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}

final class GetAllAddressErrorState extends GetAllAddressState {
  final String error;
  GetAllAddressErrorState(this.error);
  @override
  List<Object?> get props => [error];
}