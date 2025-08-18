import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritoPage extends StatefulWidget {
  const FavoritoPage({super.key});

  @override
  State<FavoritoPage> createState() => _FavoritoPageState();
}

class _FavoritoPageState extends State<FavoritoPage> {
  // Lista de favoritos, puede estar vacía
  final List<Map<String, dynamic>> favoritos = [];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    const Color professionalBlue = Color(0xFF1E3A8A);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con avatar Google
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Tus Favoritos',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Revisa tus SideQuests guardadas',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                    child: user?.photoURL == null
                        ? const Icon(Icons.account_circle, color: Colors.grey)
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Filtros rápidos
            if (favoritos.isNotEmpty)
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildFilterChip('Cercanas', professionalBlue),
                    _buildFilterChip('Fáciles', professionalBlue),
                    _buildFilterChip('Difíciles', professionalBlue),
                    _buildFilterChip('Populares', professionalBlue),
                  ],
                ),
              ),
            if (favoritos.isNotEmpty) const SizedBox(height: 16),

            // Contenido principal: lista de favoritos o mensaje vacío
            Expanded(
              child: favoritos.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          'No tienes favoritos aún.\n¡Explora SideQuests y marca tus favoritas!',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: favoritos.length,
                      itemBuilder: (context, index) {
                        final sq = favoritos[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          child: Stack(
                            children: [
                              // Imagen de fondo
                              Ink.image(
                                image: NetworkImage(sq['image']),
                                height: 180,
                                fit: BoxFit.cover,
                                child: InkWell(onTap: () {}),
                              ),
                              // Gradiente y info
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.4),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: const EdgeInsets.all(12),
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sq['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      sq['subtitle'],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: professionalBlue,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            sq['difficulty'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          sq['distance'],
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          sq['badge'],
                                          style: const TextStyle(
                                            color: Colors.amberAccent,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        backgroundColor: color.withOpacity(0.1),
        label: Text(label, style: TextStyle(color: color)),
        onPressed: () {},
      ),
    );
  }
}
