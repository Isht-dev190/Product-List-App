import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CategoryBloc.dart';
import 'ProductBloc.dart';
import 'ProductEvent.dart';


class CategoryBar extends StatelessWidget {
  const CategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = ['All', 'electronics', 'men\'s clothing', 'jewelery', 'women\'s clothing'];
    return SingleChildScrollView(
      
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 0, 10),

              child: BlocBuilder<CategoryBloc, CategoryState> (builder: (context, state) {
                bool isSelected = state.selectedCategory == category;
                return ElevatedButton.icon(onPressed: () {
                  context.read<CategoryBloc>().add(SelectedCategory(category));
                  context.read<Productbloc>().add(FetchProducts(category));
                }, 
                
                icon: isSelected ? Image.asset('assets/icons/tick.png', width: 15, height: 15,) : SizedBox.shrink(),
                label: Text(category),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? Colors.purple.shade100: Colors.white,
                  foregroundColor: isSelected ? Colors.purple : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: isSelected ? Colors.purple : Colors.grey.shade300,)
                  ),
                ),
                
                );
              }),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Notes: It is basically a horizontal list of categories with a blocbuilder. Used blocbuilder because needed state management on the tick mark i needed to put when clicked, here isSelected is a boolean variable which determines what states the icon is in, when we do not have anything selected it defaults to all and categorybloc checks the selected category and productbloc adds the products of that category then if it is selected it also displays a tick mark.