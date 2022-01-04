import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_app/models/get_items_list_model.dart';
import 'package:restaurant_table_app/repository/get_menu_items_repository.dart';

part 'get_menu_items_event.dart';
part 'get_menu_items_state.dart';

class GetMenuItemsBloc extends Bloc<GetMenuItemsEvent, GetMenuItemsState> {
  final GetMenuItemsRepository? getMenuItemsRepository;

  GetMenuItemsBloc({@required this.getMenuItemsRepository})
      : super(GetMenuItemsInitialState()) {
    on<FetchMenuItems>(fetchItemsList);
  }

  FutureOr<void> fetchItemsList(
      GetMenuItemsEvent event, Emitter<GetMenuItemsState> emit) async {
    try {
      emit(GetMenuItemsLoadingState());
      GetItemsListModel itemsList = await getMenuItemsRepository!.getMenuItem();
      emit(GetMenuItemsLoadedState(itemsList: itemsList));
    } catch (e) {
      emit(GetMenuItemsLoadingErrorState(errorMessage: e.toString()));
    }
  }
}
