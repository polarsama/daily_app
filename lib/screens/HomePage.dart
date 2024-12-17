import 'package:daily_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'notesviews.dart';
//import 'configpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _contenidoController = TextEditingController();

  void _navigateTo(Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBlue1,
      appBar: AppBar(
        backgroundColor: AppTheme.lightBlue2,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Hola!, ¿Cómo te encuentras en este momento?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contenidoController,
              decoration: InputDecoration(
                labelText: 'Contenido',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 10,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para guardar
                  },
                  child: const Text('Guardar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para eliminar
                    _tituloController.clear();
                    _contenidoController.clear();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          switch (index) {
            case 0:
              // Estamos en HomePage, no hacemos nada
              break;
            case 1:
              _navigateTo(const NotesView());
              break;
            case 2:
              //_navigateTo(const ConfigPage());
              break;
          }
        },
      ),
    );
  }
}