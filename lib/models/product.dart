class Product {
  String name;
  int? price;
  String image;

  Product.fromJson(Map<String, dynamic> map)
      : name = map['product_name'] ?? "",
  image = map['product_image'],
        price = int.tryParse(map['product_price']??"");
}
