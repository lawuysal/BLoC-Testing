import 'package:bloctest3/features/home/bloc/list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController myTextController;
  late ListBloc myBloc;
  @override
  void initState() {
    myTextController = TextEditingController();
    myBloc = context.read<ListBloc>();
    myBloc.add(InitialListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListBloc, ListState>(
      bloc: myBloc,
      listenWhen: (previous, current) => current is ListActionState,
      buildWhen: (previous, current) => current is! ListActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case ListItemAddedState:
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Add to List button clicked.")));
          case ListItemRemovedState:
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Remove button clicked.")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ListLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ListLoadedSuccessState:
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
                            child: TextField(
                              controller: myTextController,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final newItem = myTextController.text;
                              List<String> tempList = List.from(state.itemList);
                              tempList.add(newItem);
                              context.read<ListBloc>().add(
                                  ClickedAddToListEvent(itemList: tempList));
                              debugPrint(state.itemList.toString());
                            },
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
                                        shape: ShapeBorder.lerp(
                                            const StadiumBorder(),
                                            const StadiumBorder(),
                                            5),
                                        tileColor: Colors.black38,
                                        title: Text(state.itemList[index]),
                                        trailing: IconButton(
                                          onPressed: () {
                                            List<String> tempList =
                                                List.from(state.itemList);
                                            tempList.removeAt(index);
                                            context.read<ListBloc>().add(
                                                ClickedDeleteFromListEvent(
                                                    itemList: tempList));
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: state.itemList.length,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text("Unknown State"),
              ),
            );
        }
      },
    );
  }
}
