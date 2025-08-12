import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/data/models/product_model.dart';
import 'package:store_app/data/repos/product_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepo productRepo;
  ProductsCubit(this.productRepo) : super(ProductsInitial());

  Future<void> fetchProducts() async {
    emit(ProductsLoading());
    try {
      final products = await productRepo.getProducts();
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }

  Future<void> updateProduct(ProductModel product, int productId) async {
    emit(ProductsActionLoading());

    try {
      final updatedProduct = await productRepo.updateProduct(
        productId,
        product,
      );

      final currentState = state;
      if (currentState is ProductsLoaded) {
        final updatedProducts = currentState.products.map((p) {
          return p.id == productId ? updatedProduct : p;
        }).toList();

        emit(ProductsLoaded(products: updatedProducts));
      }

      emit(ProductsActionSuccess());
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }
}
