import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/data/models/product_model.dart';
import 'package:store_app/data/repos/product_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepo productRepo;
  bool _isClosed = false;
  ProductsCubit(this.productRepo) : super(ProductsInitial());

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  void safeEmit(ProductsState state) {
    if (!_isClosed) emit(state);
  }

  Future<void> fetchProducts() async {
    safeEmit(ProductsLoading());
    try {
      final products = await productRepo.getProducts();
      safeEmit(ProductsLoaded(products: products));
    } catch (e) {
      safeEmit(ProductsError(message: e.toString()));
    }
  }

  Future<void> updateProduct(ProductModel product, int productId) async {
    safeEmit(ProductsActionLoading());

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

        safeEmit(ProductsLoaded(products: updatedProducts));
      }

      safeEmit(ProductsActionSuccess());
    } catch (e) {
      safeEmit(ProductsError(message: e.toString()));
    }
  }
}
