import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myshop/ui/shared/dialog_utils.dart';
import 'package:provider/provider.dart';

import '../../managers/order_manager.dart';
import '../../models/order_item.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem order;

  const OrderItemCard(this.order, {super.key});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          buildOrderSummary(widget.order),
          if (_expanded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Chi tiết',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                buildOrderDetails(),
              ],
            )
        ],
      ),
    );
  }

  Widget buildOrderSummary(OrderItem order) {
    final orderManager = context.read<OrdersManager>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hóa Đơn',
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: () async {
                  final isAccepted = await showConfirmDialog(
                        context,
                        'Xác nhận xóa đơn hàng?',
                        '',
                      ) ??
                      false;
                  if (isAccepted) {
                    orderManager.deleteOrderById(order.id!);
                  }
                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        ),
        ListTile(
          subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
          ),
          title:
              Text('Tổng cộng: ${widget.order.amount.toStringAsFixed(3)} đồng'),
          trailing: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildOrderDetails() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      height: widget.order.productCount * 35.0 + 20,
      child: ListView(
        children: widget.order.products
            .map(
              (prod) => Column(
                children: [
                  const Divider(
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${prod.quantity} x ${prod.title}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${(prod.quantity * prod.price).toStringAsFixed(3)} đồng',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  //
}
