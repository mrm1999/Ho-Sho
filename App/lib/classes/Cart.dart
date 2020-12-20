import 'Product.dart';

class Cart {
  List<Product> products;
  static Cart _cart;

  factory Cart() {
    if (_cart == null) {
      _cart = Cart();
      _cart.products = [];
    }
    return _cart;
  }

  void insertCart(Product product) {
    _cart.products.add(product);
  }

  List<Product> getCart() {
    return _cart.products;
  }
}
