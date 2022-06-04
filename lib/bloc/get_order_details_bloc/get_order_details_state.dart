part of 'get_order_details_bloc.dart';

abstract class GetOrderDetailsState extends Equatable {
  const GetOrderDetailsState();

  @override
  List<Object> get props => [];
}

class GetOrderDetailsInitialState extends GetOrderDetailsState {}

class GetOrderDetailsLoadingState extends GetOrderDetailsState {}

class GetOrderDetailsLoadedState extends GetOrderDetailsState {
  final GetOrderDetailsModel orderDetails;

  GetOrderDetailsLoadedState({required this.orderDetails});

  @override
  List<Object> get props => [orderDetails];
}

class GetOrderDetailsLoadingErrorState extends GetOrderDetailsState {
  final String errorMessage;

  GetOrderDetailsLoadingErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
