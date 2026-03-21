part of 'get_order_by_id_cubit.dart';

sealed class GetOrderByIdState extends Equatable {}

final class GetOrderByIdInitial extends GetOrderByIdState {
  @override
  List<Object?> get props => [];
}

final class GetOrderByIdLoadingState extends GetOrderByIdState {
  @override
  List<Object?> get props => [];
}

final class GetOrderByIdLoadedState extends GetOrderByIdState {
  final GetOrderByIdModel model;
  GetOrderByIdLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}

final class GetOrderByIdErrorState extends GetOrderByIdState {
  final String error;
  GetOrderByIdErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
