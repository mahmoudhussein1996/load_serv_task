class Category {
  final int? id;
  final String? name;
  final String? backgroundImage;
  final String? image;
  final List<Product>? products;

  Category({
    this.id,
    this.name,
    this.backgroundImage,
    this.image,
    this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    backgroundImage: json["background_image"],
    image: json["image"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "background_image": backgroundImage,
    "image": image,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  final int id;
  final String? name;
  final String? description;
  final String? image;
  final bool? isSingle;
  final bool? isFavorite;
  final int? price;
  final int? priceBeforeDiscount;
  final int? points;

  Product({
    required this.id,
    this.name,
    this.description,
    this.image,
    this.isSingle,
    this.isFavorite = false,
    this.price,
    this.priceBeforeDiscount,
    this.points,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    isSingle: json["is_single"],
    price: json["price"],
    priceBeforeDiscount: json["price_before_discount"],
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "is_single": isSingle,
    "price": price,
    "price_before_discount": priceBeforeDiscount,
    "points": points,
  };
}
