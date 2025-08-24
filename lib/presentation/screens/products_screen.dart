import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/business_logic/cubits/cubit/products_cubit.dart';
import 'package:store_app/helpers/helpers.dart';
import 'package:store_app/presentation/widgets/Home_Screen/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

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
                  child: MasonryGridView.count(
                    itemCount: state.products.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
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
