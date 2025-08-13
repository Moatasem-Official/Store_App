import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:store_app/constants/app_strings.dart';
import 'package:store_app/data/models/product_model.dart';

part 'web_services.g.dart';

@RestApi(baseUrl: kStoreApiBaseUrl)
abstract class WebServices {
  factory WebServices(Dio dio, {String baseUrl}) = _WebServices;

  @GET(kProductsEndpoint)
  Future<List<ProductModel>> getProducts();

  @GET(kCategoriesEndpoint)
  Future<List<String>> getCategories();

  @GET('$kProductsByCategoryEndpoint{$kProductCategoryPath}')
  Future<List<ProductModel>> getProductsByCategory(
    @Path(kProductCategoryPath) String categoryName,
  );

  @POST(kAddProductEndpoint)
  Future<ProductModel> addProduct(@Body() ProductModel productModel);

  @PUT('$kUpdateProductEndpoint{$kProductIdPath}')
  Future<ProductModel> updateProduct(
    @Path(kProductIdPath) int id,
    @Body() ProductModel productModel,
  );
}
