part of 'get_table_list_bloc.dart';

abstract class GetTableListState extends Equatable {
  const GetTableListState();

  @override
  List<Object> get props => [];
}

class GetTableListInitialState extends GetTableListState {}

class GetTableListLoadingState extends GetTableListState {}

class GetTableListLoadedState extends GetTableListState {
  final GetTableListModel? tableList;

  const GetTableListLoadedState({@required this.tableList});

  @override
  List<Object> get props => [tableList!];
}

class GetTableListLoadingErrorState extends GetTableListState {
  final String? errorMessage;

  const GetTableListLoadingErrorState({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage!];
}
