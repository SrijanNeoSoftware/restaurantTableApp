import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_table_app/models/get_order_details_model.dart';
import 'package:restaurant_table_app/repository/get_order_details_repository.dart';

part 'get_order_details_event.dart';
part 'get_order_details_state.dart';

class GetOrderDetailsBloc
    extends Bloc<GetOrderDetailsEvent, GetOrderDetailsState> {
  final GetOrderDetailsRepository getOrderDetailsRepository;
  GetOrderDetailsBloc({required this.getOrderDetailsRepository})
      : super(GetOrderDetailsInitialState()) {
    on<FetchOrderDetailsEvent>(fetchOrderDetails);
  }

  FutureOr<void> fetchOrderDetails(
      FetchOrderDetailsEvent event, Emitter<GetOrderDetailsState> emit) async {
    try {
      emit(GetOrderDetailsLoadingState());
      GetOrderDetailsModel orderDetails = await getOrderDetailsRepository
          .getOrderItems(tableCode: event.tableCode);

      emit(GetOrderDetailsLoadedState(orderDetails: orderDetails));
    } catch (e) {
      emit(GetOrderDetailsLoadingErrorState(errorMessage: e.toString()));
    }
  }
}
