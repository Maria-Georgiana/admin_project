class House {
  int price;
  int bedrooms;
  String address;
  String description;
  double squareMeters;
  List<String> imagePath;

  House(
      {required this.price,
      required this.bedrooms,
      required this.address,
      required this.description,
      required this.squareMeters,
      required this.imagePath});
}
