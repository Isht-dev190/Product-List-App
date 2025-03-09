import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CategoryEvent {

}

class SelectedCategory extends CategoryEvent {
  final String category;
  SelectedCategory(this.category);
}

class CategoryState {
  final String selectedCategory;
  CategoryState(this.selectedCategory);
}


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState('All')) { // Default category

    on<SelectedCategory>((event, emit) {
      emit(CategoryState(event.category)); // Update selected category
    });

  }
}