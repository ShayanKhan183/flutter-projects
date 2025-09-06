import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_planner_app/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();

  String gender = "Male";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  void refreshProfile() {
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    setState(() => isLoading = true);

    try {
      emailController.text = currentUser?.email ?? "";

      final doc = await _firestore.collection('users').doc(currentUser!.uid).get();
      final data = doc.data();

      if (data != null) {
        firstNameController.text = data['firstName'] ?? "";
        lastNameController.text = data['lastName'] ?? "";
        addressController.text = data['address'] ?? "";
        phoneController.text = data['phone'] ?? "";
        birthdayController.text = data['birthday'] ?? "";
        gender = data['gender'] ?? "Male";
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading profile: $e")),
      );
    }

    setState(() => isLoading = false);
  }

  Future<void> updateUserProfile() async {
    setState(() => isLoading = true);

    try {
      final fullName = '${firstNameController.text} ${lastNameController.text}';
      await currentUser?.updateDisplayName(fullName);

      await _firestore.collection('users').doc(currentUser?.uid).set({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': currentUser?.email ?? "",
        'address': addressController.text,
        'phone': phoneController.text,
        'birthday': birthdayController.text,
        'gender': gender,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Custom Profile DP
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: emailController,
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: birthdayController,
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Birthday'),
              onTap: () async {
                FocusScope.of(context).unfocus();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.tryParse(birthdayController.text) ?? DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  birthdayController.text = picked.toIso8601String().split('T').first;
                }
              },
            ),
            DropdownButtonFormField<String>(
              value: gender,
              decoration: const InputDecoration(labelText: 'Gender'),
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (val) => setState(() => gender = val!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateUserProfile,
              child: const Text("Save"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
