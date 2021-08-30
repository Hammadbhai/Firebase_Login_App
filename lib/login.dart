import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // instense area
    final TextEditingController name = TextEditingController(text: "hadiqa");
    final TextEditingController email =
        TextEditingController(text: "hadiqa@gmail.com");
    final TextEditingController password =
        TextEditingController(text: "123456");

    void login() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String susername = email.text;
      final String sname = name.text;
      final String spass = password.text;
      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: susername, password: spass);
        final DocumentSnapshot snapshot =
            await db.collection("users").doc(user.user!.uid).get();
        final data = snapshot.data();
        print("User is Logged in ");
        Navigator.of(context).pushNamed("/home");
      } catch (e) {
        print("ERROR");

        showDialog(
            context: context,
            builder: (BuildContext context) {
              // ignore: unused_local_variable
              final message;
              return AlertDialog(content: Text("User Not Valid"));
            });
      }
    }

    return Scaffold(
      body: Container(
        child: SafeArea(
            child: Column(
          children: [
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Email'),
            ),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Enter your Name'),
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your password'),
            ),
            SizedBox(),
            ElevatedButton(onPressed: login, child: Text("Login"))
          ],
        )),
      ),
    );
  }
}
