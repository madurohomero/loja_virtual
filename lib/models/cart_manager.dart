import 'package:loja_virtual/models/cart_product.dart';
import 'package:loja_virtual/models/product.dart';

class CartManager {
  List<CartProduct> items = [];

  void addToCard(Product product) {
    items.add(CartProduct.fromProduct(product));
  }
}
