import 'package:bloctest4/screens/bloc/list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  @override
  void initState() {
    context.read<ListBloc>().add(InitialListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListBloc, ListState>(
      listenWhen: (previous, current) => current is ListActionState,
      buildWhen: (previous, current) => current is! ListActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case DeletedFromListActionState:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item removed'),
              ),
            );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Listing Page'),
          ),
          body: Center(
              child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: state.itemList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 15,
                        right: 15,
                      ),
                      child: ListTile(
                        onTap: () {
                          context
                              .read<ListBloc>()
                              .add(ClickedGoToEditingPageButtonEvent());
                          Navigator.pushNamed(context, '/listing/editing',
                              arguments: index);
                        },
                        title: Text(state.itemList[index]),
                        trailing: IconButton(
                          onPressed: () {
                            List<String> tempList = List.from(state.itemList);
                            tempList.removeAt(index);
                            context.read<ListBloc>().add(
                                ClickedRemoveButtonEvent(itemList: tempList));
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
        );
      },
    );
  }
}
