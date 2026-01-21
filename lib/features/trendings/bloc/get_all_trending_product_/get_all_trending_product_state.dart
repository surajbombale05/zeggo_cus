part of 'get_all_trending_product_cubit.dart';

sealed class GetAllTrendingProductState extends Equatable {}

final class GetAllTrendingProductInitial extends GetAllTrendingProductState {
  @override
  List<Object?> get props => [];
}

final class GetAllTrendingProductLodingState extends GetAllTrendingProductState {
  @override
  List<Object?> get props => [];
}

final class GetAllTrendingProductLoadedState extends GetAllTrendingProductState {
  final GetAllTrendingProductModel model;
  GetAllTrendingProductLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}

final class GetAllTrendingProductErrorState extends GetAllTrendingProductState {
  final String error;
  GetAllTrendingProductErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
