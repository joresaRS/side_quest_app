import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final List<Map<String, dynamic>> recommendedGroups = [
    {'name': 'Cazadores de Fent', 'members': 12},
    {'name': 'Floyd Masters', 'members': 20},
    {'name': 'Nicotine and George', 'members': 8},
  ];

  final List<Map<String, dynamic>> myGroups = [
    {'name': 'Cazadores de SideQuests', 'members': 15, 'badge': '🔥'},
    {'name': 'Picnic Lovers', 'members': 7, 'badge': '⭐'},
    {'name': 'Rutas Fotográficas', 'members': 10, 'badge': '🎯'},
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    const Color professionalBlue = Color(0xFF1E3A8A);

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
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
                  const Text(
                    'Grupos',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
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

            // Barra de búsqueda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar grupos...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Grupos recomendados (scroll horizontal)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Grupos recomendados',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: recommendedGroups.length,
                itemBuilder: (context, index) {
                  final group = recommendedGroups[index];
                  return Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: professionalBlue.withOpacity(0.7),
                          child: const Icon(Icons.group, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          group['name'],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${group['members']} miembros',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Mis grupos (scroll vertical)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Mis grupos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: myGroups.length,
                itemBuilder: (context, index) {
                  final group = myGroups[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: professionalBlue.withOpacity(0.7),
                        child: const Icon(Icons.group, color: Colors.white),
                      ),
                      title: Text(group['name']),
                      subtitle: Text('${group['members']} miembros'),
                      trailing: Text(
                        group['badge'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        // Acción: abrir grupo, chat o sidequests del grupo
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // FAB para crear nuevo grupo
      floatingActionButton: FloatingActionButton(
        backgroundColor: professionalBlue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Acción para crear un grupo nuevo
        },
      ),
    );
  }
}
