import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_table_app/models/get_tables_list_model.dart';
import 'package:restaurant_table_app/repository/get_tables_repository.dart';

part 'get_table_list_event.dart';
part 'get_table_list_state.dart';

class GetTableListBloc extends Bloc<GetTableListEvent, GetTableListState> {
  final GetTablesListRepository? getTablesListRepository;
  GetTableListBloc({@required this.getTablesListRepository})
      : super(GetTableListInitialState()) {
    on<FetchTableListEvent>(fetchTableList);
  }

  FutureOr<void> fetchTableList(
      GetTableListEvent event, Emitter<GetTableListState> emit) async {
    try {
      emit(GetTableListLoadingState());
      GetTableListModel tableList =
          await getTablesListRepository!.getTablesList();
      emit(GetTableListLoadedState(tableList: tableList));
    } catch (e) {
      emit(GetTableListLoadingErrorState(errorMessage: e.toString()));
    }
  }
}
