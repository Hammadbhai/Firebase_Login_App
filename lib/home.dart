import 'package:flutter/material.dart';
import 'package:curd_app/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream collectionStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //CollectionReference<Map<String, dynamic>> collectionStream =
  //  FirebaseFirestore.instance.collection('names');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: collectionStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  // ignore: unused_local_variable
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Column(
                    children: [
                      Post(),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
