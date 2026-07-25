class Product {
  final String imageUrl;
  final String name;
  final String? subtitle;
  final double price;
  final String height;
  final String temperature;
  final String potType;

  Product(
    this.height,
    this.temperature,
    this.potType, {
    required this.imageUrl,
    required this.name,
    this.subtitle,
    required this.price,
  });
}

final List<Product> products = [
  Product(
    '30 cm',
    '20°C - 30°C',
    'Ceramic Pot',
    imageUrl: 'assets/plant/plant (1).png',
    name: 'Snake Plant',
    subtitle:
        'A beautiful indoor plant that purifies the air and requires very little maintenance.',
    price: 499,
  ),

  Product(
    '25 cm',
    '18°C - 28°C',
    'Plastic Pot',
    imageUrl: 'assets/plant/plant (2).png',
    name: 'Aloe Vera',
    subtitle:
        'A medicinal plant known for its healing properties and easy care.',
    price: 399,
  ),

  Product(
    '35 cm',
    '18°C - 26°C',
    'Clay Pot',
    imageUrl: 'assets/plant/plant (3).png',
    name: 'Peace Lily',
    subtitle:
        'An elegant flowering plant that improves indoor air quality and adds beauty.',
    price: 699,
  ),

  Product(
    '40 cm',
    '20°C - 30°C',
    'Ceramic Pot',
    imageUrl: 'assets/plant/plant (4).png',
    name: 'Money Plant',
    subtitle:
        'A popular decorative plant believed to bring prosperity and positive energy.',
    price: 599,
  ),

  Product(
    '50 cm',
    '22°C - 30°C',
    'Fiber Pot',
    imageUrl: 'assets/plant/plant (5).png',
    name: 'Monstera',
    subtitle:
        'A tropical plant with unique split leaves, perfect for modern home décor.',
    price: 899,
  ),

  Product(
    '60 cm',
    '18°C - 27°C',
    'Wooden Pot',
    imageUrl: 'assets/plant/plant (7).png',
    name: 'Fiddle Leaf Fig',
    subtitle:
        'A stylish indoor plant with large glossy leaves that enhances any living space.',
    price: 999,
  ),

  Product(
    '20 cm',
    '15°C - 35°C',
    'Terracotta Pot',
    imageUrl: 'assets/plant/plant2.png',
    name: 'Cactus',
    subtitle:
        'A drought-resistant desert plant that thrives with minimal watering and care.',
    price: 349,
  ),
];
