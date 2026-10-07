class CartModel {
  final int id;
  final int userId;
  final String date;

  final List<CartProductModel> products;

  final int v;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? 0,

      userId: json['userId'] ?? 0,

      date: json['date'] ?? '',

      products: (json['products'] as List)
          .map((e) => CartProductModel.fromJson(e))
          .toList(),

      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'userId': userId,

      'date': date,

      'products': products.map((e) => e.toJson()).toList(),

      '__v': v,
    };
  }
}

class CartProductModel {
  final int productId;
  final int quantity;

  CartProductModel({required this.productId, required this.quantity});

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      productId: json['productId'] ?? 0,

      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'quantity': quantity};
  }
}
