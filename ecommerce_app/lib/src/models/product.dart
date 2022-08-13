/// * The product identifier is an important concept and can have its own type.
typedef ProductID = String;

/// Class representing a product.
class Product {
  const Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.availableQuantity,
    this.avgRating = 0,
    this.numRatings = 0,
  });

  final int availableQuantity;
  final double avgRating;
  final String description;

  /// Unique product id
  final ProductID id;

  final String imageUrl;
  final int numRatings;
  final double price;
  final String title;
}
