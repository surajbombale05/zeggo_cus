part of 'get_nearby_supplier_cubit.dart';

sealed class GetNearbySupplierState extends Equatable {}

final class GetNearbySupplierInitial extends GetNearbySupplierState {
  @override
  List<Object?> get props => [];
}

final class GetNearbySupplierLoadingState extends GetNearbySupplierState {
  @override
  List<Object?> get props => [];
}

final class GetNearbySupplierLoadedState extends GetNearbySupplierState {
  @override
  List<Object?> get props => [];
}

final class GetNearbySupplierErrorState extends GetNearbySupplierState {
  final String error;
  GetNearbySupplierErrorState(this.error);
  @override
  List<Object?> get props => [error];
}