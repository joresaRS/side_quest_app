import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco

      body: Padding(
        padding: const EdgeInsets.only(top: 110, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parte superior: foto + nombre + email
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (user?.photoURL != null)
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user!.photoURL!),
                  )
                else
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person, size: 40),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? 'Nombre no disponible',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? 'Email no disponible',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Miembro desde
            if (user?.metadata.creationTime != null)
              Text(
                'Miembro desde: ${user!.metadata.creationTime!.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),

            const SizedBox(height: 24),

            // Insignias / Logros
            const Text(
              "Insignias / Logros",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                children: [
                  _buildBadgeCard(
                    icon: Icons.check_circle_outline,
                    title: "Realiza tu primera SideQuest",
                    progress: "0/1",
                  ),
                  _buildBadgeCard(
                    icon: Icons.group,
                    title: "Únete a tu primer grupo",
                    progress: "0/1",
                  ),
                  _buildBadgeCard(
                    icon: Icons.star_border,
                    title: "Marca tu primera SideQuest como favorita",
                    progress: "0/1",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeCard({
    required IconData icon,
    required String title,
    required String progress,
  }) {
    return Card(
      color: Colors.blue.shade50, // azul clarito
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade700, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(progress),
      ),
    );
  }
}
