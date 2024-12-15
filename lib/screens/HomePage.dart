import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> notes = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getNotes();
  }

  void getNotes() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Hola'),
      ),
      
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notes[index].title),
            subtitle: Text(notes[index].content),
          );
        }
      ),
      //  bottomNavigationBar: ClipRRect(
      //   borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      //   child: BottomNavigationBar(
      //     items: const <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //         icon: Icon(OctIcons.home_16),
      //         label: 'Home'
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(OctIcons.ai_model_16),
      //         label: 'Home'
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(OctIcons.person_16),
      //         label: 'Home'
      //       )
      //     ],
      //     currentIndex: 0,
      //     selectedItemColor: Colors.black,
      //     backgroundColor: const Color(0XFFE2F4FF),
      //   )
      // ), 
    );
  }
}

