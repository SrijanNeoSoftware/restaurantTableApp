import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_table_app/bloc/get_table_list_bloc/get_table_list_bloc.dart';
import 'package:restaurant_table_app/models/get_tables_list_model.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetTableListBloc getTableListBloc;
    getTableListBloc = BlocProvider.of<GetTableListBloc>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFe4eaf1),
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            // radius: 5.0,
            child: Icon(Icons.person),
          ),
        ),
        title: const Text("Srijan Maharjan"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: BlocBuilder<GetTableListBloc, GetTableListState>(
        bloc: getTableListBloc,
        builder: (context, state) {
          if (state is GetTableListInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetTableListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetTableListLoadedState) {
            return Container(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select a table",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    UIHelper.verticalSpaceSmall(context),
                    GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: state.tableList!.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          List<GetTableListDatum> table =
                              state.tableList!.data!;
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'menuScreen',
                                  arguments: table[index].tableName!);
                            },
                            child: Card(
                              elevation: 5,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      table[index].tableName!.split(" ").first,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      table[index].tableName!.split(" ").last,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );
          }
          if (state is GetTableListLoadingErrorState) {
            return const Center(
              child: Text("Could not load the list of tables"),
            );
          }
          return const Center(
            child: Text("Something went wrong"),
          );
        },
      ),
    );
  }
}
