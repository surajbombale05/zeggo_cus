part of 'get_product_by_id_cubit.dart';

sealed class GetProductByIdState extends Equatable {}

final class GetProductByIdInitial extends GetProductByIdState {
  @override
  List<Object?> get props => [];
}

final class GetProductByIdLoadingState extends GetProductByIdState {
  @override
  List<Object?> get props => [];
}

final class GetProductByIdLoadedState extends GetProductByIdState {
  final GetProductByIdModel model;
  GetProductByIdLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}

final class GetProductByIdErrorState extends GetProductByIdState {
  final String error;
  GetProductByIdErrorState(this.error);
  @override
  List<Object?> get props => [error];
}