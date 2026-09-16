class ProductModel {
  final String id;
  final String name;
  final String shortDescription;
  final String description;
  final String imageUrl;
  final double price;

  final String categoryId;

  final String height;
  final String temperature;
  final String potType;

  final double stock;
  final bool isAvailable;

  const ProductModel({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.categoryId,
    required this.height,
    required this.temperature,
    required this.potType,
    required this.stock,
    required this.isAvailable,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? shortDescription,
    String? description,
    String? imageUrl,
    double? price,
    String? categoryId,
    String? height,
    String? temperature,
    String? potType,
    double? stock,
    bool? isAvailable,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      height: height ?? this.height,
      temperature: temperature ?? this.temperature,
      potType: potType ?? this.potType,
      stock: stock ?? this.stock,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      categoryId: json['categoryId'] ?? '',
      height: json['height'] ?? '',
      temperature: json['temperature'] ?? '',
      potType: json['potType'] ?? '',
      stock: json['stock'] ?? 0,
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortDescription': shortDescription,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'categoryId': categoryId,
      'height': height,
      'temperature': temperature,
      'potType': potType,
      'stock': stock,
      'isAvailable': isAvailable,
    };
  }
}
