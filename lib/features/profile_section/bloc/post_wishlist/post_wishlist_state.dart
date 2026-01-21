part of 'post_wishlist_cubit.dart';

sealed class PostWishlistState extends Equatable {}

final class PostWishlistInitial extends PostWishlistState {
  @override
  List<Object?> get props => [];
}

final class PostWishlistLoadingState extends PostWishlistState {
  @override
  List<Object?> get props => [];
}

final class PostWishlistLaodedState extends PostWishlistState {
  @override
  List<Object?> get props => [];
}

final class PostWishlistErrorState extends PostWishlistState {
  final String error;
  PostWishlistErrorState(this.error);
  @override
  List<Object?> get props => [error];
}