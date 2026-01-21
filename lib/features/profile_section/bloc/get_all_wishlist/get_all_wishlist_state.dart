part of 'get_all_wishlist_cubit.dart';

sealed class GetAllWishlistState extends Equatable {}

final class GetAllWishlistInitial extends GetAllWishlistState {
  @override
  List<Object?> get props => [];
}

final class GetAllWishlistLoadingState extends GetAllWishlistState {
  @override
  List<Object?> get props => [];
}

final class GetAllWishlistLoadedState extends GetAllWishlistState {
  final GetAllWishlistModel model;
  GetAllWishlistLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}

final class GetAllWishlistErrorState extends GetAllWishlistState {
  final String error;
  GetAllWishlistErrorState(this.error);
  @override
  List<Object?> get props => [error];
}