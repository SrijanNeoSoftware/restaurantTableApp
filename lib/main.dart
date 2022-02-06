import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_table_app/models/selected_items_list_model.dart';
import 'package:restaurant_table_app/router.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  runApp(const MyApp());

  box = await Hive.openBox('orderedItems');
  Hive.registerAdapter(SelectedItemsListDatumAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
