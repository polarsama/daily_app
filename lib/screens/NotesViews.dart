import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Intenta inicializar el locale español
    print('Intentando inicializar locale ES');
    await initializeDateFormatting('es', null);
    print('Inicialización de locale ES exitosa');
  } catch (e) {
    print('Error al inicializar locale: $e');
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es'), // Español
        const Locale('en'), // Inglés
      ],
      locale: const Locale('es'),
      home: HomePage(),
    );
  }
}

class GlobalCupertinoLocalizations {
  static var delegate;
}

class GlobalWidgetsLocalizations {
  static var delegate;
}

class GlobalMaterialLocalizations {
  static var delegate;
}

// Resto del código anterior
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeContent(),
    NotesView(),
    SettingsPage(),
  ];

   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Aplicación'),
      ),
      body: _pages[_selectedIndex],
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      body: Center(child: Text('Contenido de Inicio')),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuraciones')),
      body: Center(child: Text('Configuraciones')),
    );
  }
}

class DiaryEntry {
  final int id;
  final DateTime date;
  final String title;
  final String content;

  DiaryEntry({
    required this.id, 
    required this.date, 
    required this.title, 
    required this.content
  });
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  // Datos mock de entradas de diario
  final List<DiaryEntry> _mockEntries = [
    DiaryEntry(
      id: 1,
      date: DateTime(2024, 2, 15),
      title: 'Un día increíble',
      content: 'Hoy fue un día maravilloso...'
    ),
    DiaryEntry(
      id: 2,
      date: DateTime(2024, 2, 15),
      title: 'Reflexiones',
      content: 'Pensando en mis metas futuras...'
    ),
    DiaryEntry(
      id: 3,
      date: DateTime(2024, 2, 16),
      title: 'Aventura en la ciudad',
      content: 'Salí a explorar nuevos lugares...'
    ),
  ];

  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    
    // Intentar inicializar el locale dentro del widget
    _initLocale();
  }

  Future<void> _initLocale() async {
    try {
      await initializeDateFormatting('es', null);
      print('Locale inicializado en initState');
    } catch (e) {
      print('Error al inicializar locale en initState: $e');
    }
  }

  // Resto de los métodos anteriores...

  @override
  Widget build(BuildContext context) {
    // Intentar usar un formato de fecha con manejo de errores
    String formattedMonth;
    try {
      formattedMonth = DateFormat('MMMM yyyy', 'es').format(_selectedDate);
    } catch (e) {
      print('Error al formatear fecha: $e');
      formattedMonth = 'Mes'; // Fallback
    }

    final weekDays = _getWeekDays(_selectedDate);
    final dayEntries = _getEntriesForSelectedDate();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formattedMonth,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                  // Resto del código anterior...
                ],
              ),
            ),
            // Resto del método build...
          ],
        ),
      ),
    );
  }

  // Métodos anteriores: _getWeekDays, _getEntriesForSelectedDate, etc.
}

class _getEntriesForSelectedDate {
}

class _getWeekDays {
  _getWeekDays(DateTime selectedDate);
}