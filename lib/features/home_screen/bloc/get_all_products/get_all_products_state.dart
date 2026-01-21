part of 'get_all_products_cubit.dart';

sealed class GetAllProductsState extends Equatable {}

final class GetAllProductsInitial extends GetAllProductsState {
  @override
  List<Object?> get props => [];
}

final class GetAllProductsLoadingState extends GetAllProductsState {
  @override
  List<Object?> get props => [];
}

final class GetAllProductsLoadedState extends GetAllProductsState {
  final GetAllProductModel model;
  GetAllProductsLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}

final class GetAllProductsErrorState extends GetAllProductsState {
  final String error;
  GetAllProductsErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
