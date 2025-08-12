import 'package:store_app/data/models/product_model.dart';
import 'package:store_app/data/services/web_services.dart';

class ProductRepo {
  final WebServices webServices;
  ProductRepo(this.webServices);
  Future<List<ProductModel>> getProducts() async {
    return await webServices.getProducts();
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryName) async {
    return await webServices.getProductsByCategory(categoryName);
  }

  Future<List<String>> getCategories() async {
    return await webServices.getCategories();
  }
}
