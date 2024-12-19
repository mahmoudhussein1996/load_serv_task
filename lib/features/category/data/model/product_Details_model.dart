
class ProductDetails {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final bool? isSingle;
  final int? points;
  final int? price;
  final int? priceBeforeDiscount;
  final int? numOfSalad;
  final List<ExtraItem>? extraItems;
  final List<Salad>? salads;
  final List<Weight>? weights;
  int productCount;
  double productTotalPrice;
  bool haveNote;
  int productSaladCount;
  String note;

  ProductDetails({
    this.id,
    this.name,
    this.description,
    this.image,
    this.isSingle,
    this.points,
    this.price,
    this.priceBeforeDiscount,
    this.numOfSalad,
    this.productCount = 1,
    this.productTotalPrice = 0.0,
    this.productSaladCount = 0,
    this.extraItems,
    this.salads,
    this.weights,
    this.haveNote = false,
    this.note = "",
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    isSingle: json["is_single"],
    points: json["points"],
    priceBeforeDiscount: json["price_before_discount"],
    numOfSalad: json["number_of_salad"],
    price: json["price"],
    extraItems: json["extra_items"] == null ? [] : List<ExtraItem>.from(json["extra_items"]!.map((x) => ExtraItem.fromJson(x))),
    salads: json["salads"] == null ? [] : List<Salad>.from(json["salads"]!.map((x) => Salad.fromJson(x))),
    weights: json["weights"] == null ? [] : List<Weight>.from(json["weights"]!.map((x) => Weight.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "is_single": isSingle,
    "points": points,
    "price_before_discount": priceBeforeDiscount,
    "price": price,
    "extra_items": extraItems == null ? [] : List<dynamic>.from(extraItems!.map((x) => x.toJson())),
    "salads": salads == null ? [] : List<dynamic>.from(salads!.map((x) => x.toJson())),
    "weights": weights == null ? [] : List<dynamic>.from(weights!.map((x) => x.toJson())),
  };
}

class Salad {
  final int? id;
  final String? name;
  final int? price;
  final String? image;
  int saladCounter;

  Salad({
    this.id,
    this.name,
    this.price,
    this.image,
    this.saladCounter = 0,
  });

  factory Salad.fromJson(Map<String, dynamic> json) => Salad(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "image": image,
  };

}

class ExtraItem {
  final int? id;
  final String? name;
  final int? price;
  bool isSelected;

  ExtraItem({
    this.id,
    this.name,
    this.price,
    this.isSelected = false
  });

  factory ExtraItem.fromJson(Map<String, dynamic> json) => ExtraItem(
    id: json["id"],
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
  };

}

class Weight {
  final int? id;
  final String? name;
  final int? price;
  final int? points;
  final int? priceBeforeDiscount;
  final int? numberOfSalad;
  bool isSelected;
  double productTotalPrice;

  Weight({
    this.id,
    this.name,
    this.price,
    this.points,
    this.priceBeforeDiscount,
    this.isSelected = false,
    this.productTotalPrice = 0.0,
    this.numberOfSalad,
  });

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    points: json["points"],
    priceBeforeDiscount: json["price_before_discount"],
    numberOfSalad: json["number_of_salad"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "points": points,
    "price_before_discount": priceBeforeDiscount,
    "number_of_salad": numberOfSalad,
  };

}
