import 'package:flutter/material.dart';
import 'ProductModel.dart';
import 'ProductList.dart';

class ProductDetailScreen extends StatelessWidget {
  final Products product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title ?? "Product Details")),
      body: SingleChildScrollView(    
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.image ?? '', height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(product.title ?? 'No Title',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("\$${product.price}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(product.description ?? 'No Description',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Row(
            children: ProductList.ratingStars(product.rate ?? 0),
          ),
          ],
        ),
      ),
      ),
    );
  }
}
// Notes: pretty straightforward, added a scrollingview to prevent overflow, added all the necessary things we needed for the product screen
// reused the ratingStars method