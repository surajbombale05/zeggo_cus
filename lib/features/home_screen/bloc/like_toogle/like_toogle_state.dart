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
  final LikeToggleResponse model;
  LikeToogleLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}

final class LikeToogleErrorState extends LikeToogleState {
  final String error;
  LikeToogleErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
