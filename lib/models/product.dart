import 'package:song_tea_app/models/category.dart';

class Product {
  late int _id;
  late String _productName;
  late Category _category;
  late String _description;
  late double _price;
  late String _image;
  late String _cartImage;
  late int _discount;

  Product(
      {int id = 0,
      String productName = '',
      required Category category,
      String description = '',
      String image = '',
      String cartImage = '',
      double price = 0.0,
      int discount = 0}) {
    _id = id;
    _productName = productName;
    _category = category;
    _description = description;
    _price = price;
    _image = image;
    _cartImage = cartImage;
    _discount = discount;
  }

  ////////
  ///getter
  int get id => _id;
  String get productName => _productName;
  Category get category => _category;
  String get description => _description;
  double get price => _price;
  String get image => _image;
  String get cartImage => _cartImage;
  int get discount => _discount;

  ////////
  ///setter
  set id(int value) => _id = id;
  set productName(String value) => _productName = productName;
  set category(Category value) => _category = category;
  set description(String value) => _description = description;
  set price(double value) => _price = price;
  set image(String value) => _image = image;
  set cartImage(String value) => _cartImage = cartImage;
  set discount(int value) => _discount = discount;

  Product.map(dynamic obj) {
    _id = (obj['id'] == null ? 0 : int.parse(obj['id'].toString()));
    _productName =
        (obj['product_name'] == null ? '' : obj['product_name'].toString());
    _category = obj['category'] ?? '';
    _description =
        obj['description'] == null ? '' : obj['description'].toString();
    _price = obj['price'] == null ? 0.0 : double.parse(obj['price']);
    _image = obj['image'] == null ? '' : obj['image'].toString();
    _cartImage = obj['cart_image'] == null ? '' : obj['cart_image'].toString();
    _discount =
        obj['discount'] == null ? 0 : int.parse(obj['discount'].toString());
  }
}
