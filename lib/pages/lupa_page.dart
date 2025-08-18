import 'package:flutter/material.dart';

class LupaPage extends StatefulWidget {
  const LupaPage({super.key});

  @override
  State<LupaPage> createState() => _LupaPageState();
}

class _LupaPageState extends State<LupaPage> {
  bool showMessage = false; // controla si mostrar el mensaje de pereza

  void _showTemporaryMessage() {
    setState(() => showMessage = true);
    // Ocultar mensaje después de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => showMessage = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.construction,
                        size: 80,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Zona en obras',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        'Demasiados errores para un simple droide como yo, hay que hacer un mapa tipo pokemon go o más plano que te salgan sidequests cercanas. Ese era mi plan, técnicamente se puede, aunque se complica.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey.shade700,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _showTemporaryMessage,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Volver'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (showMessage)
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Me ha dado pereza programar el volver Pablo Ruiz Prestamo Rebollo Magdaleno',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
