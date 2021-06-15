class Items {
  String imageUrl;
  String name;
  String price;
  String type;

  Items({
    this.imageUrl,
    this.name,
    this.price,
    this.type,
  });

  Items.fromMap(Map<String, dynamic> data) {
    imageUrl = data['imageUrl'];
    name = data['name'];
    price = data['price'];
    type = data['type'];
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'type': type,
    };
  }
}
