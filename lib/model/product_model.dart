class Product {
  int? id;
  String? name;
  String? description;
  int? quantity;
  double? price;
  Product({
    this.id,
    this.name,
    this.description,
    this.quantity,
    this.price,
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    id = map['id'];

    name = map['name'];
    description = map['description'];
    quantity = map['quantity'];
    price = map['price'];
  }
}
