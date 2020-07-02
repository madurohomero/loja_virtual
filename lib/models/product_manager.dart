import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadingAllProduct();
  }

  final Firestore firestore = Firestore.instance;
  List<Product> allProducts = [];

  void _loadingAllProduct() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').getDocuments();
    allProducts =
        snapProducts.documents.map((d) => Product.fromdocument(d)).toList();
    notifyListeners();
  }
}
