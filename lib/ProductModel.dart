import 'dart:convert';

import 'package:http/http.dart' as http;


class Products{
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  double? rate;
  int? count;

  Products({
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.count,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(title: json['title'] ?? 'No title', 
    price: (json['price']?? 0).toDouble(), 
    description: json['description'] ?? 'No Description', 
    category: json['category'] ?? 'Uncategorized', 
    image: json['image'] as String,
    rate: (json['rating']?['rate'] ?? 0.0).toDouble(),
    count: (json['rating']?['count'] ?? 0).toInt());
  }


}
Future<List<Products>> fetchProducts(String category) async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

  if (response.statusCode == 200) {
    final List<dynamic> parsed = jsonDecode(response.body);
    List<Products> allProducts = parsed.map((json) => Products.fromJson(json)).toList();

    if (category.toLowerCase() == "all") {
      return allProducts;
    }

    return allProducts.where((product) => product.category?.toLowerCase() == category.toLowerCase()).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

// Notes: The fetchproducts method takes a category, calls the api and when we decode the data in a list, we check from all products which product matches our category and return that, 'all' is for all products ofcourse


// void main() async {
//   List<Products> products = await fetchProducts("men's clothing");
// try {
//   for(var product in products) {
//     print('Product Title: ${product.title}, Description: ${product.description}, Image: ${product.image}, category: ${product.category}, price: ${product.price}, rate: ${product.rate}/5, count: ${product.count}');
//   } 

// } catch(e) {
//   print('Error: $e');
// }
// }

// Above main block is for testing the api