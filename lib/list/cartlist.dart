import 'dart:developer';

import 'package:dropflutter/list/product.dart';
import 'package:flutter/foundation.dart';

class Cart extends ChangeNotifier {
  final List<products> _list = [];
  List<products> get getItems {
    return _list;
  }

  Map<int, products> _items = {};
  Map<int, products> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;

    for (var item in _list) {
      total += item.price * item.qty;
    }
    return total;
  }

  int? get count {
    return _list.length;
  }

  bool isItemExist(var catid) {
    for (int i = 0; i < _list.length; i++) {
      if (_list[i].catid == catid) {
        return true;
      }
    }
    return false;
  }
  void addItem(
    String name,
    double price,
    int qty,
    String image,
    var catid,
  ) {
    log("adsds item");
    _list.add(
      products(
        name: name.toString(),
        price: price,
        qty: qty,
        imagesUrl: image,
        catid: catid.toString(),
        // proId: '',
      ),
    );
    notifyListeners();

    log("assasasasa====" + _list.length.toString());
  }



  void increment(products product) {
    product.increase();
    notifyListeners();
  }

  void reduceByOne(products product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(products product) {
    _list.remove(product);
    notifyListeners();
  }

  void removeIte22m(String productid) {
    log("insideee removeeeeeeee =+" + productid);
    _list.removeWhere((item) => item.catid == productid);
    //_list.removeAt(int.parse(productid));
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }
}
