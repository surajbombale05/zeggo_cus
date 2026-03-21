part of 'get_all_orders_cubit.dart';

sealed class GetAllOrdersState extends Equatable {}

final class GetAllOrdersInitial extends GetAllOrdersState {
  @override
  List<Object?> get props => [];
}

final class GetAllOrdersLoadingState extends GetAllOrdersState {
  @override
  List<Object?> get props => [];
}

final class GetAllOrdersLaodedState extends GetAllOrdersState {
  final GetAllOrdersModel model;
  GetAllOrdersLaodedState(this.model);
  @override
  List<Object?> get props => [model];
}

final class GetAllOrdersErrorState extends GetAllOrdersState {
  final String error;
  GetAllOrdersErrorState(this.error);
  @override
  List<Object?> get props => [error];
}