import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:store_app/business_logic/cubits/cubit/products_cubit.dart';
import 'package:store_app/constants/app_strings.dart';
import 'package:store_app/data/repos/product_repo.dart';
import 'package:store_app/data/services/web_services.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingleton(
    WebServices(createAndSetupDio(), baseUrl: kStoreApiBaseUrl),
  );
  getIt.registerLazySingleton(() => ProductRepo(getIt<WebServices>()));
  getIt.registerFactory(() => ProductsCubit(getIt<ProductRepo>()));
}

Dio createAndSetupDio() {
  final dio = Dio();

  dio.interceptors.add(
    LogInterceptor(
      error: true,
      request: true,
      responseHeader: false,
      requestHeader: false,
      responseBody: true,
      requestBody: true,
    ),
  );
  return dio;
}
