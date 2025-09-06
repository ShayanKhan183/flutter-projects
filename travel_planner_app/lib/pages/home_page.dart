import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_planner_app/pages/profile_page.dart';
import 'package:travel_planner_app/pages/tickets_page.dart';
import 'package:travel_planner_app/pages/bookmark_page.dart'; // <--- Add this import
import 'package:travel_planner_app/widgets/custom_icon_button.dart';
import 'package:travel_planner_app/widgets/location_card.dart';
import 'package:travel_planner_app/widgets/nearby_places.dart';
import 'package:travel_planner_app/widgets/recommended_places.dart';
import 'package:travel_planner_app/widgets/tourist_places.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final GlobalKey<ProfilePageState> profilePageKey = GlobalKey<ProfilePageState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeTab(),
      const BookmarkPage(), // <--- real BookmarkPage here
      const TicketsPage(),
      ProfilePage(key: profilePageKey),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 3) {
        profilePageKey.currentState?.refreshProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Good Morning"),
            Text(
              widget.username,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: const [
          CustomIconButton(icon: Icon(Ionicons.search_outline)),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 12),
            child: CustomIconButton(icon: Icon(Ionicons.notifications_outline)),
          ),
        ],
      )
          : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Ionicons.home_outline), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Ionicons.bookmark_outline), label: "Bookmark"),
          BottomNavigationBarItem(icon: Icon(Ionicons.ticket_outline), label: "Ticket"),
          BottomNavigationBarItem(icon: Icon(Ionicons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(14),
      children: [
        const LocationCard(),
        const SizedBox(height: 15),
        const TouristPlaces(),
        const SizedBox(height: 10),

        // 🌍 International Tour
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("International Tour", style: Theme.of(context).textTheme.titleLarge),
            TextButton(onPressed: () {}, child: const Text("View All")),
          ],
        ),
        const SizedBox(height: 10),
        const RecommendedPlaces(),
        const SizedBox(height: 10),

        // 🇵🇰 Inside Pakistan Tour
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Inside Pakistan Tour", style: Theme.of(context).textTheme.titleLarge),
            TextButton(onPressed: () {}, child: const Text("View All")),
          ],
        ),
        const SizedBox(height: 10),
        const NearbyPlaces(),
      ],
    );
  }
}