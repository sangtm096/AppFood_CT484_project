import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.network(
              fit: BoxFit.cover,
              product.imageUrl,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '${product.price.toStringAsFixed(3)} đồng',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              product.description,
              textAlign: TextAlign.start,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
