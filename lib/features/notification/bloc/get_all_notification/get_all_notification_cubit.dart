import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_all_notification_state.dart';

class GetAllNotificationCubit extends Cubit<GetAllNotificationState> {
  GetAllNotificationCubit() : super(GetAllNotificationInitial());
}
