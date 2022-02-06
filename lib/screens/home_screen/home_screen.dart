import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_table_app/bloc/get_table_list_bloc/get_table_list_bloc.dart';
import 'package:restaurant_table_app/main.dart';
import 'package:restaurant_table_app/models/get_tables_list_model.dart';
import 'package:restaurant_table_app/models/selected_items_list_model.dart';
import 'package:restaurant_table_app/screens/login_screen/login_screen.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    GetTableListBloc getTableListBloc;
    getTableListBloc = BlocProvider.of<GetTableListBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: const AssetImage(
                        'assets/tables.jpg',
                      ),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(.6), BlendMode.colorBurn),
                      fit: BoxFit.fitHeight)),
              child: Center(
                child: BlocBuilder<GetTableListBloc, GetTableListState>(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: Colors.white),
                              ),
                              UIHelper.verticalSpaceSmall(context),
                              GridView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: state.tableList!.data!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 20),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    List<GetTableListDatum> table =
                                        state.tableList!.data!;
                                    List<SelectedItemsListDatum>
                                        tableOrderData =
                                        box.get(table[index].tableName!) ?? [];

                                    return GestureDetector(
                                      onTap: () async {
                                        await Navigator.pushNamed(
                                          context,
                                          'selectedItemsScreen',
                                          arguments: SelectedItemsListDatum(
                                            table: table[index].tableName!,
                                            tableCode: table[index].tableCode!,
                                          ),
                                        );
                                        setState(() {});
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            table[index]
                                                    .tableName!
                                                    .toLowerCase()
                                                    .contains("away")
                                                ? 'assets/take-away.png'
                                                : 'assets/dining-table.png',
                                            height: 60,
                                            width: 60,
                                          ),
                                          Text(
                                            table[index].tableName!,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          UIHelper.verticalSpace(2),
                                          tableOrderData.isEmpty
                                              ? Container()
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  color: Colors.red,
                                                  child: Text(
                                                    'OCCUPIED',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                )
                                        ],
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
              ),
            ),
            Positioned(
                top: 10,
                left: 10,
                child: Text(
                  "Admin",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white),
                )),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  box.clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
