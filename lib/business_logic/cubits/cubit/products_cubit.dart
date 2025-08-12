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
}
