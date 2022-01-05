part of 'get_menu_items_bloc.dart';

abstract class GetMenuItemsEvent extends Equatable {
  const GetMenuItemsEvent();

  @override
  List<Object> get props => [];
}

class FetchMenuItems extends GetMenuItemsEvent {
  final String? searchItemName;

  FetchMenuItems({@required this.searchItemName});
}
