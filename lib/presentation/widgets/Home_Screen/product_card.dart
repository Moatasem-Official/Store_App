import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/data/models/product_model.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 247, 247),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 202, 227, 227).withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/animations/Product Delivered.gif',
              image: widget.product.image ?? '',
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/animations/Product Delivered.gif',
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.product.title ?? 'No Title',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                '\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: !isFavorite
                    ? Icon(FontAwesomeIcons.heart, color: Colors.teal)
                    : Icon(FontAwesomeIcons.solidHeart, color: Colors.red),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
