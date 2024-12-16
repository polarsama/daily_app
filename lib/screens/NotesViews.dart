import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Modelo de entrada de diario
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

  // Constructor desde mapa (útil para mapear desde base de datos)
  factory DiaryEntry.fromMap(Map<String, dynamic> map) {
    return DiaryEntry(
      id: map['id'],
      date: DateTime.parse(map['date']),
      title: map['title'],
      content: map['content']
    );
  }
}

// Servicio de Base de Datos (interfaz abstracta)
abstract class DiaryEntryService {
  Future<List<DiaryEntry>> getEntriesByDate(DateTime date);
}

// Provider de Entradas de Diario
class DiaryEntryProvider extends ChangeNotifier {
  final DiaryEntryService _service;
  List<DiaryEntry> _entries = [];
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  DiaryEntryProvider(this._service);

  List<DiaryEntry> get entries => _entries;
  DateTime get selectedDate => _selectedDate;
  bool get isLoading => _isLoading;

  Future<void> fetchEntriesForDate(DateTime date) async {
    _isLoading = true;
    _selectedDate = date;
    notifyListeners();

    try {
      _entries = await _service.getEntriesByDate(date);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _entries = [];
      notifyListeners();
      // Manejar el error como prefieras (log, mostrar mensaje, etc)
      print('Error al cargar entradas: $e');
    }
  }
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  void initState() {
    super.initState();
    // Cargar entradas para la fecha actual al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DiaryEntryProvider>(context, listen: false)
          .fetchEntriesForDate(DateTime.now());
    });
  }

  // Obtener días de la semana
  List<DateTime> _getWeekDays(DateTime selectedDate) {
    final weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    return List.generate(7, (index) => weekStart.add(Duration(days: index)));
  }

  // Mostrar detalles de la entrada
  void _showEntryDetails(DiaryEntry entry) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      entry.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat('dd MMMM yyyy', 'es').format(entry.date),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 16),
              Text(entry.content),
            ],
          ),
        );
      },
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Calendario Semanal
            Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  // Header del calendario
                  Consumer<DiaryEntryProvider>(
                    builder: (context, provider, child) {
                      final selectedDate = provider.selectedDate;
                      final weekDays = _getWeekDays(selectedDate);

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('MMMM yyyy', 'es').format(selectedDate),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Icon(Icons.calendar_today),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: weekDays.map((day) {
                                final isSelected = day.year == selectedDate.year &&
                                    day.month == selectedDate.month &&
                                    day.day == selectedDate.day;
                                
                                return GestureDetector(
                                  onTap: () {
                                    provider.fetchEntriesForDate(day);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.blue[100] : null,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          DateFormat('EEE', 'es').format(day),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          day.day.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.blue : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // Lista de Entradas
            Expanded(
              child: Consumer<DiaryEntryProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final dayEntries = provider.entries;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Entradas del ${DateFormat('d MMMM', 'es').format(provider.selectedDate)}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: dayEntries.isEmpty
                              ? Center(
                                  child: Text(
                                    'No hay entradas para este día',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: dayEntries.length,
                                  itemBuilder: (context, index) {
                                    final entry = dayEntries[index];
                                    return Card(
                                      margin: const EdgeInsets.symmetric(vertical: 4),
                                      child: ListTile(
                                        title: Text(entry.title),
                                        trailing: Icon(Icons.file_present),
                                        onTap: () => _showEntryDetails(entry),
                                      ),
                                    );
                                  },
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
}

// Ejemplo de implementación de servicio (debes adaptarlo a tu base de datos)
class FirebaseDiaryEntryService implements DiaryEntryService {
  @override
  Future<List<DiaryEntry>> getEntriesByDate(DateTime date) async {
    // Implementa la lógica para obtener entradas de tu base de datos
    // Este es solo un ejemplo, debes reemplazarlo con tu implementación real
    // Por ejemplo, con Firestore, SQLite, etc.
    try {
      // Ejemplo con una consulta ficticia
      // final querySnapshot = await FirebaseFirestore.instance
      //     .collection('diary_entries')
      //     .where('date', isEqualTo: date.toIso8601String().split('T')[0])
      //     .get();
      
      // return querySnapshot.docs
      //     .map((doc) => DiaryEntry.fromMap(doc.data()))
      //     .toList();

      // Retorno temporal para compilación
      return [];
    } catch (e) {
      print('Error obteniendo entradas: $e');
      return [];
    }
  }
}