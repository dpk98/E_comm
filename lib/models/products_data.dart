class ProductList {
  ProductList({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  late final List<ProductData> products;
  late final int total;
  late final int skip;
  late final int limit;

  ProductList.fromJson(Map<String, dynamic> json) {
    products = List.from(json['products']).map((e) => ProductData.fromJson(e)).toList();
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products.map((e) => e.toJson()).toList();
    _data['total'] = total;
    _data['skip'] = skip;
    _data['limit'] = limit;
    return _data;
  }
}


class ProductData {
  ProductData({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });
  late final int id;
  late final String title;
  late final String description;
  late final int price;
  late final double discountPercentage;
  late final double? rating;
  late final int stock;
  late final String brand;
  late final String category;
  late final String thumbnail;
  late final List<String> images;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'].toDouble();
    rating = json['rating'] != null ? (json['rating'] as num).toDouble() : null;
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = List<String>.from(json['images']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['price'] = price;
    _data['discountPercentage'] = discountPercentage;
    _data['rating'] = rating;
    _data['stock'] = stock;
    _data['brand'] = brand;
    _data['category'] = category;
    _data['thumbnail'] = thumbnail;
    _data['images'] = images;
    return _data;
  }
}
