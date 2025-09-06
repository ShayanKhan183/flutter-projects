class NearbyPlaceModel {
  final String image;
  final String placeName;
  final String price;
  final String tourDate;
  final String tourTime;

  NearbyPlaceModel({
    required this.image,
    required this.placeName,
    required this.price,
    required this.tourDate,
    required this.tourTime,
  });
}

List<NearbyPlaceModel> nearbyPlaces = [
  NearbyPlaceModel(
    image: "assets/pakistan/skardu.png",
    placeName: "Skardu",
    price: "\$22",
    tourDate: "2025-07-01",
    tourTime: "09:00 AM",
  ),
  NearbyPlaceModel(
    image: "assets/pakistan/murree.png",
    placeName: "Murree",
    price: "\$18",
    tourDate: "2025-07-03",
    tourTime: "10:00 AM",
  ),
  NearbyPlaceModel(
    image: "assets/pakistan/hunza.png",
    placeName: "Hunza Valley",
    price: "\$25",
    tourDate: "2025-07-05",
    tourTime: "08:30 AM",
  ),
  NearbyPlaceModel(
    image: "assets/pakistan/naran.png",
    placeName: "Naran Kaghan",
    price: "\$20",
    tourDate: "2025-07-07",
    tourTime: "11:00 AM",
  ),
  NearbyPlaceModel(
    image: "assets/pakistan/saifulmalook.png",
    placeName: "Lake Saif ul Malook",
    price: "\$19",
    tourDate: "2025-10-10",
    tourTime: "12:30 AM",
  ),
];
