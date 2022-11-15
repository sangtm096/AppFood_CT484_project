import 'package:flutter/material.dart';
import 'package:myshop/managers/order_manager.dart';

import '../../managers/cart_manager.dart';
import 'cart_item_card.dart';

import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng'),
      ),
      body: Column(
        children: <Widget>[
          buildCartSummary(cart, context),
          const SizedBox(height: 10),
          cart.productCount == 0
              ? const Text('Chưa có sản phẩm trong giỏ hàng')
              : Expanded(
                  child: buildCartDetails(cart),
                )
        ],
      ),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cardItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Tổng:',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Text(
              '${cart.totalAmount.toStringAsFixed(3)} đồng',
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.headline6?.color,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: cart.totalAmount <= 0
                  ? null
                  : () {
                      context.read<OrdersManager>().addOrder(
                            cart.products,
                            cart.totalAmount,
                          );
                      cart.clear();
                    },
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
                backgroundColor: Colors.teal,
              ),
              child: const Text(
                'ĐẶT HÀNG',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
