part of 'get_all_product_by_catid_and_subcatid_cubit.dart';

sealed class GetAllProductByCatidAndSubcatidState extends Equatable {
}

final class GetAllProductByCatidAndSubcatidInitial extends GetAllProductByCatidAndSubcatidState {
  @override
  List<Object?> get props => [];
}

final class GetAllProductByCatidAndSubcatidLoadingState extends GetAllProductByCatidAndSubcatidState {
  @override
  List<Object?> get props => [];
}


final class GetAllProductByCatidAndSubcatidLoadedState extends GetAllProductByCatidAndSubcatidState {
  final GetAllProductModel model;
  GetAllProductByCatidAndSubcatidLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}


final class GetAllProductByCatidAndSubcatidErrorState extends GetAllProductByCatidAndSubcatidState {
  final String error;
  GetAllProductByCatidAndSubcatidErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
