import 'package:go_router/go_router.dart';
import 'ProductScreen.dart'; 

final GoRouter router = GoRouter(
  initialLocation: '/all', 
  routes: [
    GoRoute(
      path: '/:category',
      builder: (context, state) {
        final category = state.pathParameters['category'] ?? 'all'; 
        return ProductScreen(category: category); 
      },
    ),
  ],
);


//Notes: added an initial location is router, then defined a base route incase category is empty, so it always routes to all incase the category doesnt work
// then it just passes the category to Product Screen. 
