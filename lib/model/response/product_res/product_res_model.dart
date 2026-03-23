class ProductResModelDart {
  ProductResModelDart({
    required this.success,
    required this.total,
    required this.page,
    required this.totalPages,
    required this.products,
  });

  final bool? success;
  final int? total;
  final int? page;
  final int? totalPages;
  final List<Product> products;

  factory ProductResModelDart.fromJson(Map<String, dynamic> json) {
    return ProductResModelDart(
      success: json["success"],
      total: json["total"],
      page: json["page"],
      totalPages: json["totalPages"],
      products: json["products"] == null
          ? []
          : List<Product>.from(
              json["products"]!.map((x) => Product.fromJson(x)),
            ),
    );
  }
}

class Product {
  Product({
    required this.frameDetails,
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.discountedPrice,
    required this.images,
    required this.availableColors,
    required this.highlights,
    required this.careInstructions,
    required this.stock,
    required this.isActive,
    required this.averageRating,
    required this.totalReviews,
    required this.tags,
  });

  final FrameDetails? frameDetails;
  final String? id;
  final String? name;
  final String? description;
  final String? category;
  final num? price;
  final num? discountedPrice;
  final List<String> images;
  final List<String> availableColors;
  final List<String> highlights;
  final List<String> careInstructions;
  final int? stock;
  final bool? isActive;
  final num? averageRating;
  final num? totalReviews;
  final List<String> tags;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      frameDetails: json["frameDetails"] == null
          ? null
          : FrameDetails.fromJson(json["frameDetails"]),
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      category: json["category"],
      price: json["price"],
      discountedPrice: json["discountedPrice"] ?? json["price"] ?? 0,
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      availableColors: json["availableColors"] == null
          ? []
          : List<String>.from(json["availableColors"]!.map((x) => x)),
      highlights: json["highlights"] == null
          ? []
          : List<String>.from(json["highlights"]!.map((x) => x)),
      careInstructions: json["careInstructions"] == null
          ? []
          : List<String>.from(json["careInstructions"]!.map((x) => x)),
      stock: json["stock"],
      isActive: json["isActive"],
      averageRating: json["averageRating"],
      totalReviews: json["totalReviews"],
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
    );
  }
}

class FrameDetails {
  FrameDetails({
    required this.frameType,
    required this.frameSize,
    required this.frameShape,
    required this.gender,
    required this.frameMaterial,
  });

  final String? frameType;
  final String? frameSize;
  final String? frameShape;
  final String? gender;
  final String? frameMaterial;

  factory FrameDetails.fromJson(Map<String, dynamic> json) {
    return FrameDetails(
      frameType: json["frameType"],
      frameSize: json["frameSize"],
      frameShape: json["frameShape"],
      gender: json["gender"],
      frameMaterial: json["frameMaterial"],
    );
  }
}
