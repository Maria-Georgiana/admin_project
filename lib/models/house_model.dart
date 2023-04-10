class House {
  int price;
  int bedrooms;
  String address;
  String description;
  int squareMeters;
  String imagePath;
  bool isFavorite;

  House({
    required this.price,
    required this.bedrooms,
    required this.address,
    required this.description,
    required this.squareMeters,
    required this.imagePath,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['bedrooms'] = bedrooms;
    data['address'] = address;
    data['description'] = description;
    data['squareMeters'] = squareMeters;
    data['imagePath'] = imagePath;
    return data;
  }

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
        price: json['price'] is int ? json['price'] : int.parse(json['price']),
        bedrooms: json['bedrooms'] is int ? json['bedrooms'] : int.parse(json['bedrooms']),
        address: json['address'],
        description: json['description'],
        squareMeters: json['squareMeters'] is int ? json['squareMeters'] : int.parse(json['squareMeters']),
        imagePath: json['imagePath']);
  }

  @override
  String toString() {
    return 'Price: $price \nAddress: $address';
  }
}
