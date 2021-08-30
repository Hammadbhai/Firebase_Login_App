import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // instense area
    final TextEditingController name = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    void rregister() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;
      final String sname = name.text;
      final String susername = email.text;
      final String spass = password.text;
      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: susername, password: spass);
        await db.collection("users").doc(user.user!.uid).set({
          "Email": susername,
          "Name": sname,
        });

        print("User is Registered ");

        Navigator.of(context).pushNamed("/login");
      } catch (e) {
        print("ERROR");
      }
    }

    return Scaffold(
      body: Container(
        child: SafeArea(
            child: Column(
          children: [
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Enter your Name'),
            ),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Email'),
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Password'),
            ),
            SizedBox(),
            ElevatedButton(onPressed: rregister, child: Text("Register")),
          ],
        )),
      ),
    );
  }
}
