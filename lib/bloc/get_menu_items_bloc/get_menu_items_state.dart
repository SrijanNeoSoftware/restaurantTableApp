part of 'get_menu_items_bloc.dart';

abstract class GetMenuItemsState extends Equatable {
  const GetMenuItemsState();

  @override
  List<Object> get props => [];
}

class GetMenuItemsInitialState extends GetMenuItemsState {}

class GetMenuItemsLoadingState extends GetMenuItemsState {}

class GetMenuItemsLoadedState extends GetMenuItemsState {
  final List<ItemsListDatum>? itemsList;

  const GetMenuItemsLoadedState({@required this.itemsList});

  @override
  List<Object> get props => [itemsList!];
}

class GetMenuItemsLoadingErrorState extends GetMenuItemsState {
  final String? errorMessage;

  const GetMenuItemsLoadingErrorState({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage!];
}
