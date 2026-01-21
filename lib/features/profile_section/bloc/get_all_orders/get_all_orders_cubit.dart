import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_all_orders_state.dart';

class GetAllOrdersCubit extends Cubit<GetAllOrdersState> {
  GetAllOrdersCubit() : super(GetAllOrdersInitial());
}
