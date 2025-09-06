import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ticket_place_model.dart';
import '../widgets/distance.dart';
import 'ticket_detail_page.dart';

class TouristDetailsPage extends StatelessWidget {
  final String image;
  final String placeName;
  final String price;
  final String tourDate;
  final String tourTime;

  const TouristDetailsPage({
    super.key,
    required this.image,
    required this.placeName,
    required this.price,
    required this.tourDate,
    required this.tourTime,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            // Big Image
            SizedBox(
              height: size.height * 0.38,
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 20,
                            icon: const Icon(Ionicons.chevron_back),
                          ),
                          IconButton(
                            iconSize: 20,
                            onPressed: () async {
                              await FirebaseFirestore.instance.collection('bookmarks').add({
                                'userId': FirebaseAuth.instance.currentUser?.uid,
                                'placeImage': image, // ✅ Correct field name!
                                'placeName': placeName,
                                'price': price,
                                'tourDate': tourDate,
                                'tourTime': tourTime,
                                'timestamp': FieldValue.serverTimestamp(),
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Added to Bookmarks!")),
                              );
                            },
                            icon: const Icon(Ionicons.heart_outline),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Title Row
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      placeName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Portic Team 8km",
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    onPressed: () {},
                    iconSize: 20,
                    icon: const Icon(Ionicons.chatbubble_ellipses_outline),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "4.6",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Icon(
                      Ionicons.star,
                      color: Colors.yellow[800],
                      size: 15,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 15),
            // Timer Row
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "01d:32h:56m",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Started in",
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Map
            Container(
              height: 180,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                image: const DecorationImage(
                  image: AssetImage('assets/map.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Distance Widget
            const Distance(),
            const SizedBox(height: 20),
            // Join Button
            ElevatedButton(
              onPressed: () {
                User? user = FirebaseAuth.instance.currentUser;
                String passengerName = user?.displayName ?? "Unknown Passenger";

                TicketPlaceModel ticket = TicketPlaceModel(
                  placeName: placeName,
                  placeImage: image,
                  passengerName: passengerName,
                  tourDate: tourDate,
                  tourTime: tourTime,
                  seatNo: "14-A",
                  price: price,
                  guiderName: "M-S-Y Team",
                  guiderPhone: "03107000114",
                  guiderImage: "assets/guider.png",
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TicketDetailPage(ticket: ticket),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 8.0,
                ),
              ),
              child: const Text("Join this tour"),
            ),
          ],
        ),
      ),
    );
  }
}
