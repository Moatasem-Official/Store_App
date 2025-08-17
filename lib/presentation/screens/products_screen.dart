import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/business_logic/cubits/cubit/products_cubit.dart';
import 'package:store_app/helpers/helpers.dart';
import 'package:store_app/presentation/widgets/Home_Screen/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsCubit>(context).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          'New Trend',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(FontAwesomeIcons.cartShopping, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoaded) {
              if (state.products.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: const Center(child: Text('No products available')),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Helpers.showProductInfo(
                            context,
                            product: state.products[index],
                          );
                        },
                        child: ProductCard(product: state.products[index]),
                      );
                    },
                  ),
                );
              }
            } else if (state is ProductsError) {
              return Center(child: Text(state.message));
            } else if (state is ProductsLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
