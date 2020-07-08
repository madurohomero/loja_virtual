import 'package:flutter/material.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({this.size});

  final ItemSize size;
  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: !size.hasStock ? Colors.red.withAlpha(50) : Colors.grey,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: !size.hasStock ? Colors.red.withAlpha(50) : Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              size.name,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'R\$ ${size.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: !size.hasStock ? Colors.red.withAlpha(50) : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}