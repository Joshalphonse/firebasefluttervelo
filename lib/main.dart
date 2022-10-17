import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedemo/firebase_options.dart';
import 'package:firebasedemo/reaad%20data/get_user_name.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Lobbies';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff885566), title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<String> docIDs = [];
//get docIDs

  Future getDoctId() async {
    await FirebaseFirestore.instance.collection('sneakers').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }

  String gameId = "Loading...";
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        backgroundColor: Color(0xff885566));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 30),
          const Text("Current Game"),
          Text(gameId, style: Theme.of(context).textTheme.headline4),
          ElevatedButton(
            style: style,
            onPressed: () {
              _startNewGame();
            },
            child: const Text('Start A New Game'),
          ),
          Expanded(
              child: FutureBuilder(
            future: getDoctId(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    // ignore: prefer_const_constructors
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        title: GetUserName(documentId: docIDs[index]),
                        tileColor: Colors.grey[200],
                      ),
                    );
                  });
            },
          ))
        ],
      ),
    );
  }
}

var db = FirebaseFirestore.instance;
Future<void> _startNewGame() {
  var db = FirebaseFirestore.instance;
  final batch = db.batch();

  var gameId = FirebaseFirestore.instance.collection("Rooms").doc().id;

  batch.set(db.collection('Globals').doc('Bootstrap'), {'currentGame': gameId},
      SetOptions(merge: true));
  batch.set(db.collection('Rooms').doc(gameId), {
    'createdAt': Timestamp.now(),
  });

  return batch.commit();
}
