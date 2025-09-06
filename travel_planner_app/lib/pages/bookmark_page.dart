import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    print('Current User ID = ${currentUser?.uid}');

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text('You are not logged in!')),
      );
    }

    final userId = currentUser.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Bookmarks'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookmarks')
            .where('userId', isEqualTo: userId)
        //.orderBy('timestamp', descending: true) // optional — comment out to avoid errors
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('Firestore Error: ${snapshot.error}');
            return const Center(child: Text('Something went wrong!'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No bookmarks yet!'));
          }

          final bookmarks = snapshot.data!.docs;

          if (bookmarks.isEmpty) {
            return const Center(child: Text('No bookmarks yet!'));
          }

          print('Loaded ${bookmarks.length} bookmarks');

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final data = bookmarks[index].data() as Map<String, dynamic>;

              final placeImage = data['placeImage'] ?? '';
              final placeName = data['placeName'] ?? 'Unknown Place';
              final tourDate = data['tourDate'] ?? '';
              final tourTime = data['tourTime'] ?? '';
              final price = data['price'] ?? '';

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: placeImage.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      placeImage,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 60);
                      },
                    ),
                  )
                      : const Icon(Icons.image_not_supported, size: 60),
                  title: Text(
                    placeName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text('Date: $tourDate'),
                      Text('Time: $tourTime'),
                      Text('Price: $price'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
