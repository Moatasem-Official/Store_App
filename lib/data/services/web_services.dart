import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:store_app/data/models/product_model.dart';

part 'web_services.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com/')
abstract class WebServices {
  factory WebServices(Dio dio, {String baseUrl}) = _WebServices;

  @GET('products')
  Future<List<ProductModel>> getProducts();

  @GET('categories')
  Future<List<String>> getCategories();

  @GET('products/category/{category_name}')
  Future<List<ProductModel>> getProductsByCategory(
    @Path('category_name') String categoryName,
  );
}
