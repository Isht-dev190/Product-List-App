import 'package:flutter_bloc/flutter_bloc.dart';
import 'ProductState.dart';
import 'ProductEvent.dart';
import 'ProductModel.dart';


class Productbloc extends Bloc<ProductEvent, Productstate>{
  final Map<String, List<Products>> _cachedProducts = {};

  Productbloc() : super(ProductLoading()) {
      on<FetchProducts>((event, emit) async {
        print("In product bloc before loading");
        
        if (_cachedProducts.containsKey(event.category)) {
        print(" Using cached data");
        emit(ProductLoaded(_cachedProducts[event.category]!));
        return;
      }


        emit(ProductLoading());

          try {
            List<Products> products = await fetchProducts(event.category);
            _cachedProducts[event.category] = products;
            print(products[0]);
            emit(ProductLoaded(products));
          } catch (e) {
            emit(ProductError("Failed to load products"));
          }
      });
  }

}

// Notes: ProductBloc uses productevent and product state then when we call fetchproducts we first display productloading which basically throws a simple progress indicator, then we call the fetchproducts method extracting category from event then emit a productloaded call with products list, if it fails to do that we throw an error,
// the cached products is a map that stores the products for each category so that we don't have to call the api again and again for the same category
