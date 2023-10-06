import 'package:bloctest3/data/item_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ItemList itemList;
  late TextEditingController textController;
  @override
  void initState() {
    const ItemList(items: []);
    // TODO: implement initState
    textController = TextEditingController();
    itemList = const ItemList(items: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: TextField(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: const Text("Add to List"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                left: 15,
                                right: 15,
                              ),
                              child: ListTile(
                                textColor: Colors.white,
                                shape: ShapeBorder.lerp(const StadiumBorder(),
                                    const StadiumBorder(), 5),
                                tileColor: Colors.black38,
                                title: Text(itemList.items[index]),
                                trailing: const IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                            );
                          },
                          itemCount: itemList.items.length,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
