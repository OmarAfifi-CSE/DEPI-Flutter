// screens/profile_screen.dart

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'Omar Afifi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'omarafifi.cse@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                elevation: 0,
              ),
              child: const Text('Log Out', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
