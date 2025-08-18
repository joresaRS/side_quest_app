import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:side_quest_app/pages/favorito_page.dart';
import 'package:side_quest_app/pages/groups_page.dart';
import 'package:side_quest_app/pages/inicio_page.dart';
import 'package:side_quest_app/pages/lupa_page.dart';
import 'package:side_quest_app/pages/perfil_page.dart';

// HomePage principal con barra de navegación y FAB central
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // empezamos en Home (izquierda)
  final user = FirebaseAuth.instance.currentUser;

  final List<Widget> _pages = const [
    InicioPage(), // 🏠 Home
    FavoritoPage(), // ⭐ Favoritos
    LupaPage(), // 🔍 Lupa central
    GroupsPage(), // 👥 Grupos
    PerfilPage(), // 👤 Perfil
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static const Color professionalBlue = Color.fromARGB(
    255,
    0,
    92,
    198,
  ); // azul serio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 2,
        child: SizedBox(
          height: 80, // barra más alta para que el FAB encaje
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                color: professionalBlue,
                onPressed: () => _onTabTapped(0),
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                color: professionalBlue,
                onPressed: () => _onTabTapped(1),
              ),
              const SizedBox(width: 40), // espacio para el FAB
              IconButton(
                icon: const Icon(Icons.group),
                color: professionalBlue,
                onPressed: () => _onTabTapped(3),
              ),
              IconButton(
                icon: const Icon(Icons.person),
                color: professionalBlue,
                onPressed: () => _onTabTapped(4),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 30), // baja mucho el FAB
        child: SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            backgroundColor: professionalBlue,
            shape: const CircleBorder(),
            onPressed: () => _onTabTapped(2),
            child: const Icon(Icons.search, size: 40, color: Colors.white),
            elevation: 8, // sombra ligera
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
