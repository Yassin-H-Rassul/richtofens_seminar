import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:richtofens_seminar/model/general_user.dart';
import 'package:richtofens_seminar/services/auth_service.dart';

class TokensScreen extends StatefulWidget {
  const TokensScreen({Key? key}) : super(key: key);

  @override
  _TokensScreenState createState() => _TokensScreenState();
}

class _TokensScreenState extends State<TokensScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final String? usersToken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseCloudMessaging_Listeners();
    // getUsers();
  }

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((token) {
      String? userUid =
          Provider.of<AuthService>(context, listen: false).user!.uid;
      GeneralUser theGeneralUser = GeneralUser(uid: userUid, tokens: [token!]);
      _firestore.collection('users').add(theGeneralUser.toMap());
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Notification Screen.',
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 35,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
