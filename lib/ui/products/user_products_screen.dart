import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myshop/ui/products/edit_product_screen.dart';
import 'user_product_list_tile.dart';
import '../../managers/products_manager.dart';

class ProductsManagement extends StatelessWidget {
  static const routeName = '/user-products';
  const ProductsManagement({super.key});
  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductsManager>().items;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text('Quản lý sản phẩm'),
        actions: [
          Container(
            height: 50,
            padding: const EdgeInsets.only(right: 20),
            alignment: Alignment.center,
            child: Text(
              '${products.length} Sản phẩm',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            EditProductScreen.routeName,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child: buildUserProductListView(),
          );
        },
      ),
    );
  }

  Widget buildUserProductListView() {
    return Consumer<ProductsManager>(
      builder: (ctx, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
