class CartItem {
  String id;
  String name;
  int price;
  String desc;
  String image;
  int qty;
  String notes;
  String? date;

  CartItem({
    this.id = '',
    required this.name,
    required this.price,
    required this.desc,
    required this.image,
    this.qty = 1,
    this.notes = "",
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'desc': desc,
      'image': image,
      'qty': qty,
      'notes': notes,
      'date': date,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map, String docId) {
    return CartItem(
      id: docId,
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      desc: map['desc'] ?? '',
      image: map['image'] ?? '',
      qty: map['qty'] ?? 1,
      notes: map['notes'] ?? '',
      date: map['date'],
    );
  }
}