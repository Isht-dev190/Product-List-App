abstract class ProductEvent {}

class FetchProducts extends ProductEvent {
  final String category;
  FetchProducts(this.category);
}

// Notes: productevent is basically the trigger so it just has a constructor with the category passed in