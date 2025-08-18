import 'package:flutter/material.dart';
import 'package:side_quest_app/pages/map_screen.dart'; // Asegúrate de que la ruta sea correcta

class LupaPage extends StatelessWidget {
  const LupaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: MapScreen(), // Muestra directamente MapScreen
      ),
    );
  }
}
