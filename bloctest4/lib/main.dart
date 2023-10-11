import 'package:bloctest4/screens/bloc/list_bloc.dart';
import 'package:bloctest4/screens/home/ui/home_page.dart';
import 'package:bloctest4/screens/listing/ui/editing_page.dart';
import 'package:bloctest4/screens/listing/ui/listing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ListBloc _myBloc;
  @override
  void initState() {
    _myBloc = ListBloc();
    super.initState();
  }

  @override
  void dispose() {
    _myBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => BlocProvider.value(
                value: _myBloc,
                child: const HomePage(),
              ),
          '/listing': (context) => BlocProvider.value(
                value: _myBloc,
                child: const ListingPage(),
              ),
          '/listing/editing': (context) => BlocProvider.value(
                value: _myBloc,
                child: const EditingPage(),
              ),
        },
      ),
    );
  }
}
