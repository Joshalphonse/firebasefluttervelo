import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedemo/firebase_options.dart';
import 'package:firebasedemo/reaad%20data/get_user_name.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

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
      routes: {
        '/add': ((context) => const SignInForm())
      },
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff885566), title: const Text(_title)),
        body: const SignInForm(),
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
                      padding: const EdgeInsets.all(8.0),
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

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();
  ProfileAvatars? _character = ProfileAvatars.avatar1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'First Name'),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name.';
                }
              },
              onSaved: (val) => setState(() => _user.firstName = val!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Last Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name.';
                }
              },
              onSaved: (val) => setState(() => _user.lastName = val!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email.';
                }
              },
              onSaved: (val) => setState(() => _user.email = val!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'Phone'),
              onSaved: (val) => setState(() => _user.phone = val!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Favorite Programming Language'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter at least 1 programming language';
                }
              },
              onSaved: (val) => setState(() => _user.programmingLangs = val!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText:
                      'Interests, can be general like "Hiking", or "Art"'),
             
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter some interests';
                }
              },
              onSaved: (val) => setState(() => _user.interests = val!),
            ),
          ),
          
          ListTile(
            title: const Text('Suzie'),
            
            trailing: Image.network(
                'https://static.wixstatic.com/media/7bdcd4_0d1e566d72e74985b799ccc17431ac3b~mv2.png'),
            leading: Radio<ProfileAvatars>(
            
              value: ProfileAvatars.avatar1,
              groupValue: _character,
              onChanged: (ProfileAvatars? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
           ListTile(
            title: const Text('Jason'),
            trailing: Image.network(
                'https://static.wixstatic.com/media/7bdcd4_8ff1899c57f9423dac4da464c275b29f~mv2.png'),
            leading: Radio<ProfileAvatars>(
              value: ProfileAvatars.avatar2,
              groupValue: _character,
              onChanged: (ProfileAvatars? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
           ListTile(
            title: const Text('Kitty'),
            trailing: Image.network(
                'https://static.wixstatic.com/media/7bdcd4_1a68ac8c267b4f4db1554b67b8c780b0~mv2.png'),
            leading: Radio<ProfileAvatars>(
              value: ProfileAvatars.avatar3,
              groupValue: _character,
              onChanged: (ProfileAvatars? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
           ListTile(
            title: const Text('Ghost Skull'),
            trailing: Image.network(
                'https://static.wixstatic.com/media/7bdcd4_4ac7dc7e305147f6aed9641c4713a2f8~mv2.png'),
            leading: Radio<ProfileAvatars>(
              value: ProfileAvatars.avatar4,
              groupValue: _character,
              onChanged: (ProfileAvatars? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
           ListTile(
            title: const Text('Skull'),
            trailing: Image.network(
                'https://static.wixstatic.com/media/7bdcd4_4b3388196a6648bcbbfc32baee4ef5f0~mv2.png'),
            leading: Radio<ProfileAvatars>(
              value: ProfileAvatars.avatar5,
              groupValue: _character,
              onChanged: (ProfileAvatars? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
              final FirebaseFirestore _db = FirebaseFirestore.instance;

                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // DatabaseService service = DatabaseService();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    ),
    );
  }


final inputDecoration = InputDecoration(
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(8.0),
borderSide: const BorderSide(
    color: Colors.redAccent,
    width: 2,
)));
}
  const textStyle = TextStyle(
  color: Colors.white,
  fontSize: 22.0,
  letterSpacing: 1,
  fontWeight: FontWeight.bold,
);

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


  addEmployee(User userData) async {
    // await _db.collection("Employees").add(userData.toMap());
  }