import 'package:flutter/material.dart';
import 'package:myshop/managers/cart_manager.dart';
import 'package:myshop/managers/products_manager.dart';

import '../../models/product.dart';

import 'product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductGridTile extends StatefulWidget {
  const ProductGridTile(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  State<ProductGridTile> createState() => _ProductGridTileState();
}

class _ProductGridTileState extends State<ProductGridTile> {
  int _productCount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductDetailScreen.routeName,
                    arguments: widget.product.id,
                  );
                },
                child: Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          buildProductContent(context),
        ],
      ),
    );
  }

  Expanded buildProductContent(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProductContentHeader(context),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                    '${(widget.product.price * _productCount).toStringAsFixed(3)} đồng'),
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 80, 89, 88),
                        width: 1.0,
                      ),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (_productCount > 1) {
                          setState(() {
                            _productCount--;
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 80, 89, 88),
                          width: 1.0,
                        ),
                      ),
                      child: Text(_productCount.toString())),
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 80, 89, 88),
                        width: 1.0,
                      ),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _productCount++;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildProductContentHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: widget.product.isFavoriteListenable,
              builder: (context, isFavorite, child) {
                return IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  // color: Theme.of(context).colorScheme.secondary,
                  color: Colors.red,
                  onPressed: () {
                    context
                        .read<ProductsManager>()
                        .toggleFavoriteStatus(widget.product);
                  },
                );
              },
            ),
            Text(
              widget.product.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // buildGridFooterBar(context)
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.shopping_cart,
          ),
          onPressed: () {
            final cart = context.read<CartManager>();
            for (var i = 0; i < _productCount; i++) {
              cart.addItem(widget.product);
            }
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text(
                    'Mặt hàng đã được thêm vào giỏ hàng',
                  ),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'HOÀN TÁC',
                    onPressed: () {
                      cart.removeSingleItem(widget.product.id!);
                    },
                  ),
                ),
              );
          },
          color: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }
}
