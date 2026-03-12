class CartItem {
  String name;
  int price;
  String desc; // Tetap buat isi menu (Ayam Teriyaki, dll)
  String image;
  String? date; 
  int qty;
  String notes; // Variabel baru buat Alamat & Jadwal

  CartItem({
    required this.name, 
    required this.price, 
    required this.desc, 
    required this.image, 
    this.date, 
    this.qty = 1,
    this.notes = "", // Default kosong biar menu lain gak merah
  });
}

List<CartItem> globalCart = [];
List<CartItem> globalHistory = [];