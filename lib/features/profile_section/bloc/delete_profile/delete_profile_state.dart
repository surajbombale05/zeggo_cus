part of 'delete_profile_cubit.dart';

sealed class DeleteProfileState extends Equatable {}

final class DeleteProfileInitial extends DeleteProfileState {
  @override
  List<Object?> get props => [];
}

final class DeleteProfileLoadingState extends DeleteProfileState {
  @override
  List<Object?> get props => [];
}

final class DeleteProfileLoadedState extends DeleteProfileState {
  @override
  List<Object?> get props => [];
}

final class DeleteProfileErrorState extends DeleteProfileState {
  final String error;
  DeleteProfileErrorState(this.error);
  @override
  List<Object?> get props => [];
}