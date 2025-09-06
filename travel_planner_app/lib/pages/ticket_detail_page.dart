// pages/ticket_detail_page.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // 🔥 Import Firestore
import '../models/ticket_place_model.dart';

class TicketDetailPage extends StatelessWidget {
  final TicketPlaceModel ticket;

  const TicketDetailPage({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Place Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(ticket.placeImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tour Place Name
          Text(
            "Tour Place: ${ticket.placeName}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          // Ticket info
          infoRow("Passenger Name", ticket.passengerName),
          infoRow("Tour Date", ticket.tourDate),
          infoRow("Tour Time", ticket.tourTime),
          infoRow("Seat No", ticket.seatNo),
          infoRow("Price", ticket.price),

          const SizedBox(height: 16),

          // Barcode Image
          Image.asset(
            'assets/barcode.png',
            height: 100,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 16),

          // Guider
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(ticket.guiderImage),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ticket.guiderName),
                    Text(ticket.guiderPhone),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.call),
                onPressed: () => _launchCall(ticket.guiderPhone),
              ),
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () => _launchMessage(ticket.guiderPhone),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () async {
              // 🔥 Upload ticket to Firestore
              await FirebaseFirestore.instance.collection('tickets').add({
                'placeName': ticket.placeName,
                'placeImage': ticket.placeImage,
                'passengerName': ticket.passengerName,
                'tourDate': ticket.tourDate,
                'tourTime': ticket.tourTime,
                'seatNo': ticket.seatNo,
                'price': ticket.price,
                'guiderName': ticket.guiderName,
                'guiderPhone': ticket.guiderPhone,
                'timestamp': FieldValue.serverTimestamp(), // save time
              });

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Ticket Confirmed & Uploaded!")),
              );
            },
            child: const Text("Confirm Ticket"),
          ),
        ],
      ),
    );
  }

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _launchCall(String phone) async {
    final Uri url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _launchMessage(String phone) async {
    final Uri url = Uri.parse("sms:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
