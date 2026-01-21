part of 'get_all_banner_cubit.dart';

sealed class GetAllBannerState extends Equatable {}

final class GetAllBannerInitial extends GetAllBannerState {
  @override
  List<Object?> get props => [];
}

final class GetAllBannerLoadingState extends GetAllBannerState {
  @override
  List<Object?> get props => [];
}


final class GetAllBannerLoadedState extends GetAllBannerState {
  final GetAllBannerModel model;
  GetAllBannerLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}


final class GetAllBannerErrorState extends GetAllBannerState {
  final String error;
  GetAllBannerErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
