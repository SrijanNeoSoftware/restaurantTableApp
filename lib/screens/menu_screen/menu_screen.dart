import 'package:flutter/material.dart';
import 'package:restaurant_table_app/screens/place_order_screen/place_order_screen.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class MenuScreen extends StatefulWidget {
  final int? index;
  const MenuScreen({Key? key, @required this.index}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order for Table ${widget.index! + 1}"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: const [],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () {},
                    child: const Text("SAVE"),
                  ),
                ),
                UIHelper.horizontalSpaceSmall(context),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {},
                    child: const Text("DELIVERED"),
                  ),
                ),
                UIHelper.horizontalSpaceSmall(context),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlaceOrderScreen(),
                        ),
                      );
                    },
                    child: const Text("ADD"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
