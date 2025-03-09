import 'package:assignment_2/ProductModel.dart';

abstract class Productstate {}


class ProductLoading extends Productstate {}


class ProductLoaded extends Productstate {
  final List<Products> products;

  ProductLoaded(this.products);
}

class ProductError extends Productstate {
  final String message;
  ProductError(this.message);
}

// Notes: productstate basically just gives three things, productloading, productloaded and producterror