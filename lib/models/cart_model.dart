class CartItem {
  String name;
  int price;
  String desc;
  String image;
  int qty;      // <--- Tambahin ini
  String notes; // <--- Tambahin ini (buat simpan alamat/catatan)
  String? date;

  CartItem({
    required this.name,
    required this.price,
    required this.desc,
    required this.image,
    this.qty = 1,      // Kasih default 1
    this.notes = "",   // Kasih default kosong
    this.date,
  });
}

// List global lo
List<CartItem> globalCart = [];
List<CartItem> globalHistory = [];