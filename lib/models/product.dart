class Product {
  final String id;
  final String title;
  final int price;
  final String image;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: map['id'] as String,
      title: map['title'] as String,
      price: map['price'] as int,
      image: map['image'] as String,
    );
  }

  // For debugging
  @override
  String toString() {
    return 'Product(id: $id, title: $title, price: $price, image: $image)';
  }
}