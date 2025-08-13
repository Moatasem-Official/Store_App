import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/business_logic/cubits/cubit/products_cubit.dart';
import 'package:store_app/data/models/product_model.dart';
import 'package:store_app/injection.dart';
import 'package:store_app/presentation/screens/edit_product_screen.dart';
import 'package:store_app/presentation/screens/products_screen.dart';

class AppRouter {
  static const String initialRoute = '/';
  static const String editProductScreen = '/editProductScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ProductsCubit>(
            create: (context) => getIt<ProductsCubit>()..fetchProducts(),
            child: const ProductsScreen(),
          ),
        );
      case editProductScreen:
        var product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ProductsCubit>(
            create: (context) => getIt<ProductsCubit>(),
            child: EditProductScreen(product: product),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
