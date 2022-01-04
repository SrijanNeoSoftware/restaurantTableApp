part of 'get_table_list_bloc.dart';

abstract class GetTableListEvent extends Equatable {
  const GetTableListEvent();

  @override
  List<Object> get props => [];
}

class FetchTableListEvent extends GetTableListEvent {}
