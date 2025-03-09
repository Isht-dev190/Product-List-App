import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'ProductAppBar.dart';
import 'CategoryBar.dart';
import 'ProductBloc.dart';
import 'ProductList.dart';
import 'ProductScreen.dart'; 
import 'ProductDetailScreen.dart'; 
import 'CategoryBloc.dart';
import 'ProductModel.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoryBloc()),
        BlocProvider(create: (_) => Productbloc()),
      ],
      // Used Multibloc providers for code readibility 
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  MyApp({super.key}); 


  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(),
      ),
      GoRoute(
        path: '/category/:category',
        builder: (context, state) {
          final category = state.pathParameters['category']!;
          return ProductScreen(category: category);
        },
      ),
      GoRoute(
        path: '/productDetails',
        builder: (context, state) {
          final product = state.extra as Products; 
          return ProductDetailScreen(product: product);
        },
      ),
    ],
  );


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProductAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategoryBar(),
          Expanded(child: ProductList()),
        ],
      ),
    );
  }
}

//Notes: Calling my ProductAppBar as the scaffolds appbar becuase that stays at the top, couldve used Material but was getting messy.
//below in the body added a column widget where categoryBar is called and for the products to take the rest of the space added a Expanded Widget

