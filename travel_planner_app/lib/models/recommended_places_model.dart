class RecommendedPlaceModel {
  final String image;
  final double rating;
  final String location;
  final String price;
  final String tourDate;
  final String tourTime;

  RecommendedPlaceModel({
    required this.image,
    required this.rating,
    required this.location,
    required this.price,
    required this.tourDate,
    required this.tourTime,
  });
}

List<RecommendedPlaceModel> recommendedPlaces = [
  RecommendedPlaceModel(
    image: "assets/international/santorini.jpg",
    rating: 4.8,
    location: "Santorini, Greece",
    price: "\$150",
    tourDate: "2025-07-15",
    tourTime: "10:00 AM",
  ),
  RecommendedPlaceModel(
    image: "assets/international/bali.jpg",
    rating: 4.5,
    location: "Bali, Indonesia",
    price: "\$120",
    tourDate: "2025-07-20",
    tourTime: "09:30 AM",
  ),
  RecommendedPlaceModel(
    image: "assets/international/kyoto.jpg",
    rating: 4.7,
    location: "Kyoto, Japan",
    price: "\$140",
    tourDate: "2025-07-25",
    tourTime: "08:45 AM",
  ),
  RecommendedPlaceModel(
    image: "assets/international/banff.jpg",
    rating: 4.6,
    location: "Banff, Canada",
    price: "\$130",
    tourDate: "2025-07-30",
    tourTime: "11:00 AM",
  ),
  RecommendedPlaceModel(
    image: "assets/international/queenstown.jpg",
    rating: 4.9,
    location: "Queenstown, New Zealand",
    price: "\$160",
    tourDate: "2025-08-05",
    tourTime: "10:15 AM",
  ),
];
