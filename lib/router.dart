import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_table_app/bloc/get_menu_items_bloc/get_menu_items_bloc.dart';
import 'package:restaurant_table_app/bloc/get_order_details_bloc/get_order_details_bloc.dart';
import 'package:restaurant_table_app/bloc/get_table_list_bloc/get_table_list_bloc.dart';
import 'package:restaurant_table_app/repository/get_menu_items_repository.dart';
import 'package:restaurant_table_app/repository/get_order_details_repository.dart';
import 'package:restaurant_table_app/repository/get_tables_repository.dart';
import 'package:restaurant_table_app/screens/home_screen/home_screen.dart';
import 'package:restaurant_table_app/screens/place_order_screen/place_order_screen.dart';
import 'package:restaurant_table_app/screens/selected_items/selected_items.dart';
import 'package:restaurant_table_app/screens/splash_screen/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final dynamic args = routeSettings.arguments;
    switch (routeSettings.name) {
      //Route for Splashscreen
      case "/":
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      //Route for homeScreen
      case "homeScreen":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GetTableListBloc(
                getTablesListRepository: GetTablesListRepository())
              ..add(FetchTableListEvent()),
            child: const HomeScreen(),
          ),
        );

      //Route for Splashscreen
      case "selectedItemsScreen":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GetOrderDetailsBloc(
                getOrderDetailsRepository: GetOrderDetailsRepository())
              ..add(FetchOrderDetailsEvent(tableCode: args!.tableCode)),
            child: SelectedItemsScreen(
              tableDetails: args,
            ),
          ),
        );

      //Route for Splashscreen
      case "placeOrderScreen":
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => GetMenuItemsBloc(
                          getMenuItemsRepository: GetMenuItemsRepository())
                        ..add(
                          FetchMenuItems(searchItemName: ""),
                        ),
                    ),
                    BlocProvider(
                      create: (context) => GetTableListBloc(
                          getTablesListRepository: GetTablesListRepository())
                        ..add(
                          FetchTableListEvent(),
                        ),
                    ),
                  ],
                  child: const PlaceOrderScreen(),
                ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('Error! Route not found.'),
          ),
        );
      },
    );
  }
}
