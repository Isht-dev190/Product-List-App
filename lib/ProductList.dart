import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart'; // 🚀 Import for navigation
import 'ProductBloc.dart';
import 'ProductState.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Productbloc, Productstate>(
      builder: (context, state) {
        print("In bloc builder");

        if (state is ProductLoading) {
          print("In bloc productloading");
          return Center(child: CircularProgressIndicator());



        } else if (state is ProductLoaded) {
          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 10, 
              mainAxisSpacing: 10, 
              childAspectRatio: 0.7
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {


              print(state.products[index]);

              final product = state.products[index];

              return InkWell(
                onTap: () {
                  GoRouter.of(context).push(
                    '/productDetails', 
                    extra: product,  
                  );
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          product.image ?? 'No image', 
                          fit: BoxFit.cover, 
                          width: double.infinity,
                          errorBuilder: (context, error, StackTrace) => Icon(Icons.broken_image, size: 50, color: Colors.grey),
                        ), 
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.title ?? 'No title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${product.price}", 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
                            ),
                            Row(
                              children: ratingStars(product.rate ?? 0),
                            ),
                          ],
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: Text(
                          "(${product.count ?? 0} reviews)",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          );


        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text("No Products"));
        }
      }
    );
  }

  static List<Widget> ratingStars(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        stars.add(Icon(Icons.star, color: Colors.yellow, size: 18)); // Full star
      } else if (i - rating < 1) {
        stars.add(Icon(Icons.star_half, color: Colors.yellow, size: 18)); // Half a star
      } else {
        stars.add(Icon(Icons.star_border, color: Colors.grey, size: 18)); 
      }
    }
    return stars;
  }
}

// Notes: this method has a stars array, to display stars. runs a loop out of 5
// if my rating is less than the actual rating in whole numbers, it displays the whole star, for e.g 4/5 would result in 4 stars 
// and if rating is i-rating i.e. 3.5 lets say, then if i = 4, then 3 - 3.5 would be 0.5 i.e. not a whole number and less than 1
// so it would print half a star, and nothing for empty star, so this loops rating times, so if rating is
// 5 then it would run 5 times, if 3 it runs 3 times