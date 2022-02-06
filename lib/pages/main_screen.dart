import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('To Do'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //const Text(
          //  'Main Screen',
          //  style: TextStyle(color: Colors.white),
          //),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/todo',
                );
              },
              child: const Text('ToDo page'))
        ],
      ),
    );
  }
}
