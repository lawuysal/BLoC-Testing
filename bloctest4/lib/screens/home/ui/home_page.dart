import 'package:bloctest4/screens/bloc/list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _myController;

  @override
  void initState() {
    _myController = TextEditingController();
    context.read<ListBloc>().add(InitialListEvent());
    super.initState();
  }

  @override
  void dispose() {
    _myController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListBloc, ListState>(
      listenWhen: (previous, current) => current is ListActionState,
      buildWhen: (previous, current) => current is! ListActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case AddedToListActionState:
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Item added.')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home Page"),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(90.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    child: TextField(
                      controller: _myController,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var newItem = _myController.text;
                      List<String> tempList = List.from(state.itemList);
                      tempList.add(newItem);
                      context
                          .read<ListBloc>()
                          .add(ClickedAddToListButtonEvent(itemList: tempList));
                      _myController.clear();
                    },
                    child: const Text('Add to List'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/listing');
                    },
                    child: const Text('Listing Page'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
