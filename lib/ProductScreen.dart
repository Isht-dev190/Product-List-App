import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ProductBloc.dart';
import 'ProductEvent.dart';
import 'ProductList.dart';

class ProductScreen extends StatefulWidget {
  final String category; 

  const ProductScreen({super.key, required this.category});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}


class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<Productbloc>().add(FetchProducts(widget.category)); 
  }


  @override
  void didUpdateWidget(ProductScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category) {
      context.read<Productbloc>().add(FetchProducts(widget.category));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.toUpperCase())),
      body: ProductList(), 
    );
  }
}

// Basic AppBar with the widgetcategory at top, right now i dont think i am displaying the widget that way, added it due to gorouter causing some errors



