import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List todoList = [];
  String _userToDO = '';

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
    todoList.addAll(['First task', 'Second task', 'Third task']);
  }

  void _menuOpen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('menu'),
        ),
        body: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: const Text('Main menu'),
            ),
          ],
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('To Do'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _menuOpen,
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('NoData');
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(snapshot.data!.docs[index].id),
                child: Card(
                  child: ListTile(
                    title: Text(snapshot.data!.docs[index].get('item')),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_sweep),
                      color: Colors.deepOrangeAccent,
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('items')
                            .doc(snapshot.data!.docs[index].id)
                            .delete();
                      },
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  FirebaseFirestore.instance
                      .collection('items')
                      .doc(snapshot.data!.docs[index].id)
                      .delete();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add task'),
                  content: TextField(
                    onChanged: (String value) {
                      _userToDO = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('items')
                              .add({'item': _userToDO});
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
