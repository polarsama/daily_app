import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
}

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

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
  }

  // Obtener días de la semana
  List<DateTime> _getWeekDays(DateTime selectedDate) {
    final weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    return List.generate(7, (index) => weekStart.add(Duration(days: index)));
  }

  // Filtrar entradas por día
  List<DiaryEntry> _getEntriesForSelectedDate() {
    return _mockEntries.where((entry) => 
      entry.date.year == _selectedDate.year &&
      entry.date.month == _selectedDate.month &&
      entry.date.day == _selectedDate.day
    ).toList();
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
    final weekDays = _getWeekDays(_selectedDate);
    final dayEntries = _getEntriesForSelectedDate();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Calendario Semanal
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
                          DateFormat('MMMM yyyy', 'es').format(_selectedDate),
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
                        final isSelected = day.year == _selectedDate.year &&
                            day.month == _selectedDate.month &&
                            day.day == _selectedDate.day;
                        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDate = day;
                            });
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
              ),
            ),

            // Lista de Entradas
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Entradas del ${DateFormat('d MMMM', 'es').format(_selectedDate)}',
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
              ),
            ),
          ],
        ),
      ),
      // Agregar el bottomNavigationBar según tu diseño
      // bottomNavigationBar: TuNavBar(),
    );
  }
}