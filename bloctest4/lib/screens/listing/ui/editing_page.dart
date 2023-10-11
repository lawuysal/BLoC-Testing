import 'package:bloctest4/screens/bloc/list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditingPage extends StatefulWidget {
  const EditingPage({super.key});

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  late TextEditingController _myController;
  //late int _myIndex;
  @override
  void initState() {
    _myController = TextEditingController();
    //_myIndex = ModalRoute.of(context)?.settings.arguments as int;
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
          case ItemEditedActionState:
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Item edited')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Editing Page'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(90.0),
              child: Column(
                children: [
                  Form(
                    child: TextField(
                      controller: _myController
                        ..text = state.itemList[
                            ModalRoute.of(context)?.settings.arguments as int],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      List<String> tempList = List.from(state.itemList);
                      tempList[ModalRoute.of(context)?.settings.arguments
                          as int] = _myController.text;
                      context
                          .read<ListBloc>()
                          .add(ClickedApplyButtonEvent(itemList: tempList));
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
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
