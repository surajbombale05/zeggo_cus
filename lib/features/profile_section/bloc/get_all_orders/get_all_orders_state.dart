part of 'get_all_orders_cubit.dart';

sealed class GetAllOrdersState extends Equatable {
  const GetAllOrdersState();

  @override
  List<Object> get props => [];
}

final class GetAllOrdersInitial extends GetAllOrdersState {}
