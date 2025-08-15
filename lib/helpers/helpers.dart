import 'package:flutter/material.dart';
import 'package:store_app/app_router.dart';
import 'package:store_app/data/models/product_model.dart';

class Helpers {
  static Future<dynamic> showProductInfo(
    BuildContext context, {
    required ProductModel product,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            product.title ?? 'No Title',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/animations/Product Delivered.gif',
                    image: product.image ?? '',
                    fit: BoxFit.cover,
                    height: 180,
                    width: MediaQuery.of(context).size.width * 0.8,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/animations/Product Delivered.gif',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // السعر
                Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.green),
                    Text(
                      product.price != null
                          ? product.price!.toStringAsFixed(2)
                          : '0.00',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                if (product.category != null)
                  Row(
                    children: [
                      const Icon(Icons.category, color: Colors.blueGrey),
                      const SizedBox(width: 6),
                      Text(
                        product.category!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),

                if (product.description != null)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.description, color: Colors.orange),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          product.description!,
                          style: const TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          color: Color.fromARGB(255, 132, 132, 132),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRouter.editProductScreen,
                          arguments: product,
                        );
                      },
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          color: Color.fromARGB(255, 132, 132, 132),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
