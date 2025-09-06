// pages/tickets_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/ticket_place_model.dart';
import '../widgets/ticket_place_widget.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tickets"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tickets')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No tickets found."));
          }

          List<TicketPlaceModel> tickets = snapshot.data!.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;

            return TicketPlaceModel(
              placeName: data['placeName'] ?? '',
              placeImage: data['placeImage'] ?? '',
              passengerName: data['passengerName'] ?? '',
              tourDate: data['tourDate'] ?? '',
              tourTime: data['tourTime'] ?? '',
              seatNo: data['seatNo'] ?? '',
              price: data['price'] ?? '',
              guiderName: data['guiderName'] ?? '',
              guiderPhone: data['guiderPhone'] ?? '',
              guiderImage: 'assets/guider.png', // fallback
            );
          }).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              return TicketPlaceWidget(ticket: tickets[index]);
            },
          );
        },
      ),
    );
  }
}
