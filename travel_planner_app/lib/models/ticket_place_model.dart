// models/ticket_place_model.dart

class TicketPlaceModel {
  final String placeName;
  final String placeImage;
  final String passengerName;
  final String tourDate;
  final String tourTime;
  final String seatNo;
  final String price;
  final String guiderName;
  final String guiderPhone;
  final String guiderImage;

  TicketPlaceModel({
    required this.placeName,
    required this.placeImage,
    required this.passengerName,
    required this.tourDate,
    required this.tourTime,
    required this.seatNo,
    required this.price,
    required this.guiderName,
    required this.guiderPhone,
    required this.guiderImage,
  });
}
