part of 'place_order_cubit.dart';

sealed class PlaceOrderState extends Equatable {}

final class PlaceOrderInitial extends PlaceOrderState {
  @override
  List<Object> get props => [];
}

final class PlaceOrderLoadingState extends PlaceOrderState {
  @override
  List<Object> get props => [];
}

final class PlaceOrderLoadedState extends PlaceOrderState {
  final PlaceOrderModel model;
  PlaceOrderLoadedState(this.model);
  @override
  List<Object> get props => [model];
}

final class PlaceOrderErrorState extends PlaceOrderState {
  final String error;
  PlaceOrderErrorState(this.error);
  @override
  List<Object> get props => [error];
}