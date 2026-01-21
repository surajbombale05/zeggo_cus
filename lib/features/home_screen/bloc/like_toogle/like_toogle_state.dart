part of 'like_toogle_cubit.dart';

sealed class LikeToogleState extends Equatable {}

final class LikeToogleInitial extends LikeToogleState {
  @override
  List<Object?> get props => [];
}

final class LikeToogleLoadingState extends LikeToogleState {
  @override
  List<Object?> get props => [];
}

final class LikeToogleLoadedState extends LikeToogleState {
  @override
  List<Object?> get props => [];
}

final class LikeToogleErrorState extends LikeToogleState {
  final String error;
  LikeToogleErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
