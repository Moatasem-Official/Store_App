import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/business_logic/cubits/cubit/products_cubit.dart';
import 'package:store_app/injection.dart';
import 'package:store_app/presentation/screens/products_screen.dart';

void main() {
  initGetIt();
  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>(
      create: (context) => get_it<ProductsCubit>()..fetchProducts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const ProductsScreen(),
      ),
    );
  }
}
