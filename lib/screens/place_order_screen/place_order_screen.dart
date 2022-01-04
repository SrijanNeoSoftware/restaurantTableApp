import 'package:flutter/material.dart';
import 'package:restaurant_table_app/utils/ui_helper.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  final List<int> text = List.generate(50, (index) => index);

  final List selectedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Order"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchTextEditingController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(248.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpaceSmall(context),
            Text(
              "Select order items",
              style: Theme.of(context).textTheme.headline6,
            ),
            UIHelper.verticalSpaceSmall(context),
            Expanded(
              child: GridView.builder(
                addAutomaticKeepAlives: true,
                cacheExtent: 100.0,
                primary: false,
                shrinkWrap: true,
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) => GridItem(
                  index: index,
                  isSelected: (bool value) {
                    setState(() {
                      if (value) {
                        selectedList.add(index);
                      } else {
                        selectedList.remove(index);
                      }
                    });
                    debugPrint("$index : $value");
                    debugPrint(selectedList.toString());
                  },
                  key: Key(index.toString()),
                ),
              ),
            ),
            UIHelper.verticalSpaceSmall(context),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, selectedList);
                    },
                    child: const Text("SUBMIT"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatefulWidget {
  final int? index;
  final ValueChanged<bool>? isSelected;

  const GridItem({Key? key, this.index, this.isSelected}) : super(key: key);

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem>
    with AutomaticKeepAliveClientMixin {
  bool isSelected = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected!(isSelected);
        });
      },
      child: Stack(
        children: <Widget>[
          Card(
            color: isSelected ? Colors.black12 : Colors.white,
            elevation: 5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Menu Item",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    "${widget.index! + 1}",
                    style: Theme.of(context).textTheme.headline3,
                  )
                ],
              ),
            ),
          ),
          isSelected
              ? const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
