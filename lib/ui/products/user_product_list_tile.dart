import 'package:flutter/material.dart';
import 'package:myshop/ui/products/edit_product_screen.dart';
import 'package:myshop/managers/products_manager.dart';

import '../../models/product.dart';
import 'package:provider/provider.dart';

import '../shared/dialog_utils.dart';

class UserProductListTile extends StatelessWidget {
  final Product product;

  const UserProductListTile(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            buildEditButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        final showDelete = await showConfirmDialog(
          context,
          'Bạn có chắc xóa sản phẩm này?',
          '',
        );
        if (showDelete == true) {
          context.read<ProductsManager>().deleteProduct(product.id!);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'Sản phẩm đã được xóa',
                  textAlign: TextAlign.center,
                ),
              ),
            );
        }
      },
      color: Theme.of(context).errorColor,
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
          arguments: product.id,
        );
      },
      color: Colors.teal,
    );
  }
}
