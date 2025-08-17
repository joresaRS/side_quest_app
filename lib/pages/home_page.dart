import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Páginas de ejemplo
class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Grupos Page"));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Perfil Page"));
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Favoritos Page"));
  }
}

// HomePage principal con barra de navegación
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // empezamos en Home (izquierda)
  final user = FirebaseAuth.instance.currentUser;

  final List<Widget> _pages = const [
    HomeContent(), // 🏠 Home
    FavoritesPage(), // ⭐ Favoritos
    HomeContent(), // 🔍 Home central (duplicamos, pero controlado por FAB)
    GroupsPage(), // 👥 Grupos
    ProfilePage(), // 👤 Perfil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => setState(() => _currentIndex = 0),
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () => setState(() => _currentIndex = 1),
            ),
            const SizedBox(width: 40), // espacio para el FAB central
            IconButton(
              icon: const Icon(Icons.group),
              onPressed: () => setState(() => _currentIndex = 3),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => setState(() => _currentIndex = 4),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => setState(() => _currentIndex = 2),
        child: const Icon(Icons.search, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Contenido de la pestaña Home
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: user?.photoURL != null
                ? NetworkImage(user!.photoURL!)
                : null,
            child: user?.photoURL == null
                ? const Icon(Icons.account_circle, size: 80, color: Colors.grey)
                : null,
          ),
          const SizedBox(height: 20),
          Text(
            "Name: ${user?.displayName ?? 'No Name'}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "Email: ${user?.email ?? 'No Email'}",
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
            label: const Text("Cerrar sesión"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
