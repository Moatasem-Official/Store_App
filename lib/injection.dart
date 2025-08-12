import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:store_app/business_logic/cubits/cubit/products_cubit.dart';
import 'package:store_app/data/repos/product_repo.dart';
import 'package:store_app/data/services/web_services.dart';

final get_it = GetIt.instance;

void initGetIt() {
  get_it.registerLazySingleton<ProductsCubit>(() => ProductsCubit(get_it()));
  get_it.registerLazySingleton<ProductRepo>(() => ProductRepo(get_it()));
  get_it.registerFactory<WebServices>(() => WebServices(createAndSetupDio()));
}

Dio createAndSetupDio() {
  final dio = Dio();

  dio
    ..options.connectTimeout = const Duration(seconds: 1)
    ..options.receiveTimeout = const Duration(seconds: 10);

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
