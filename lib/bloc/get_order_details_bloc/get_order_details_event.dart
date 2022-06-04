part of 'get_order_details_bloc.dart';

abstract class GetOrderDetailsEvent extends Equatable {
  const GetOrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchOrderDetailsEvent extends GetOrderDetailsEvent {
  final dynamic tableCode;

  FetchOrderDetailsEvent({required this.tableCode});

  @override
  List<Object> get props => [tableCode];
}
