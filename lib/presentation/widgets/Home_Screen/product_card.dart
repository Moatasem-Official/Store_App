import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/animations/Product Delivered.gif',
                  height: 140,
                  width: 140,
                  fit: BoxFit.cover,
                );
              },
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
          Row(
            children: [
              Text(
                '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(FontAwesomeIcons.heart, color: Colors.teal),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
