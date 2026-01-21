part of 'get_all_cafe_cubit.dart';

sealed class GetAllCafeState extends Equatable {}

final class GetAllCafeInitial extends GetAllCafeState {
  @override
  List<Object?> get props => [];
}

final class GetAllCafeLoadingState extends GetAllCafeState {
  @override
  List<Object?> get props => [];
}


final class GetAllCafeLoadedState extends GetAllCafeState {
  final GetAllCafeModel model;
  GetAllCafeLoadedState(this.model);
  @override
  List<Object?> get props => [model];
}


final class GetAllCafeErrorState extends GetAllCafeState {
  final String error;
  GetAllCafeErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
