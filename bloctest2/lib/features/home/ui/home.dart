import 'package:bloctest2/features/cart/ui/cart.dart';
import 'package:bloctest2/features/home/bloc/home_bloc.dart';
import 'package:bloctest2/features/home/ui/widgets/product_tile_widget.dart';
import 'package:bloctest2/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// Our home bloc instance to use here
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// listenwhen tells bloc to listen for actions
    /// buildwhen tells bloc to build the entire screen
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,

      /// Listener is listens to state changes and changes the ui according to it
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
        } else if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadedLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:

            /// So we can access our state variables
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Grocery App"),
                actions: [
                  IconButton(
                    onPressed: () {
                      /// This code literally puts event to bloc
                      homeBloc.add(HomeNavigateToWishlistClickedEvent());
                    },
                    icon: const Icon(Icons.favorite_outline),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeNavigateToCartClickedEvent());
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                      productDataModel: successState.products[index]);
                },
              ),
            );

          case HomeLoadedErrorState:
            return const Scaffold(
              body: Center(
                child: Text("An Error Occured"),
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
