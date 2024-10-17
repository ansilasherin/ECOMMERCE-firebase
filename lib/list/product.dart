class products {
  String name;
  double price;
  int qty = 1;
  
  String imagesUrl;
  String catid;
 
 
  products({
    required this.name,
    required this.price,
    required this.qty,                                 
    required this.imagesUrl,
    required this.catid,
  });

  void increase() {
    qty++;
  }

  void decrease() {
    qty--;
  }
 
  where(bool Function(dynamic item) param0) {}
}

