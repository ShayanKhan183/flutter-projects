import 'package:flutter/material.dart';
import '../models/ticket_place_model.dart';
import '../pages/ticket_detail_page.dart';

class TicketPlaceWidget extends StatelessWidget {
  final TicketPlaceModel ticket;

  const TicketPlaceWidget({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open Ticket Detail Page and pass ticket
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TicketDetailPage(ticket: ticket),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Place Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                ticket.placeImage,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tour Place Name
                  Text(
                    ticket.placeName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  // Passenger Name
                  Text("Passenger: ${ticket.passengerName}"),
                  const SizedBox(height: 4),
                  // Date
                  Text("Date: ${ticket.tourDate}"),
                  const SizedBox(height: 4),
                  // Seat No
                  Text("Seat: ${ticket.seatNo}"),
                  const SizedBox(height: 4),
                  // Price (NEW)
                  Text("Price: ${ticket.price}", style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
