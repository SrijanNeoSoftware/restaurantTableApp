import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_table_app/bloc/get_table_list_bloc/get_table_list_bloc.dart';
import 'package:restaurant_table_app/repository/get_tables_repository.dart';
import 'package:restaurant_table_app/screens/home_screen/home_screen.dart';
import 'package:restaurant_table_app/screens/menu_screen/menu_screen.dart';
import 'package:restaurant_table_app/screens/splash_screen/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
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
      case "menuScreen":
        return MaterialPageRoute(
          builder: (_) => MenuScreen(
            index: args,
          ),
        );

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
