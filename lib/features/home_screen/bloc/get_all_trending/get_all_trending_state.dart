part of 'get_all_trending_cubit.dart';

sealed class GetAllTrendingState extends Equatable {}

final class GetAllTrendingInitial extends GetAllTrendingState {
  @override
  List<Object?> get props => [];
}

final class GetAllTrendingLoadingState extends GetAllTrendingState {
  @override
  List<Object?> get props => [];
}


final class GetAllTrendingLoadedState extends GetAllTrendingState {
  final GetAllTrendingModel model;
  GetAllTrendingLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}


final class GetAllTrendingErrorState extends GetAllTrendingState {
  final String error;
  GetAllTrendingErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
