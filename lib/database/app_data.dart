class CartItem {
  String name;
  int price;
  String desc;
  CartItem({required this.name, required this.price, required this.desc});
}

List<CartItem> globalCart = [];