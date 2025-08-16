import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              "${FirebaseAuth.instance.currentUser!.photoURL ?? Icon(Icons.account_circle_sharp)}",
            ),
          ),
          Text(
            "Name: ${FirebaseAuth.instance.currentUser!.displayName ?? 'No Name'}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "Email: ${FirebaseAuth.instance.currentUser!.email ?? 'No Email'}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
