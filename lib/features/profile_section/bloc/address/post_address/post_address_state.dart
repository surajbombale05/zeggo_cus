part of 'post_address_cubit.dart';

sealed class PostAddressState extends Equatable {}

final class PostAddressInitial extends PostAddressState {
  @override
  List<Object?> get props => [];
}

final class PostAddressLoadingState extends PostAddressState {
  @override
  List<Object?> get props => [];
}

final class PostAddressLoadedState extends PostAddressState {
  @override
  List<Object?> get props => [];
}

final class PostAddressErrorState extends PostAddressState {
  final String error;
  PostAddressErrorState(this.error);
  @override
  List<Object?> get props => [error];
}