import 'package:flutter/material.dart';
import 'package:store_app/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8), // عشان مايلزقش المحتوى في الحواف
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // مهم عشان الكولمن ماياخدش مساحة زيادة
        crossAxisAlignment: CrossAxisAlignment.start, // يخلي النصوص شمال
        children: [
          Align(
            alignment: Alignment.center,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/animations/Product Delivered.gif',
              image: product.image ?? '',
              fit: BoxFit.cover,
              height: 140,
              width: 140,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.title ?? 'No Title',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            product.description ?? 'No Description',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.category ?? 'No Category',
                style: const TextStyle(fontSize: 12, color: Colors.blue),
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID: ${product.id ?? 'N/A'}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                'Count: ${product.rating?.count ?? 0}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${product.price ?? 0.00}',
                style: const TextStyle(fontSize: 14, color: Colors.green),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${product.rating?.rate ?? 0.0}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
