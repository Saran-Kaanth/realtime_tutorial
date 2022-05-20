import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realtime_tutorial/pages/home_page.dart';
import 'package:realtime_tutorial/pages/medical_edit.dart';
import 'package:realtime_tutorial/pages/medical_id.dart';
import 'package:realtime_tutorial/services/social_auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late DatabaseReference _ref;
  FirebaseAuth _instance = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = new GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
      Container(
          color: Colors.grey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
                height: 60,
              ),
              Text(
                "Profile Page",
                style: TextStyle(fontSize: 40),
              ),
            ],
          )),
      Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
        child: Center(
            child: Column(
          children: [
            Card(
              color: Colors.grey[400],
              elevation: 40,
              shadowColor: Colors.green,
              child: SizedBox(
                width: 800,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.greenAccent[400],
                          radius: 43,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(FirebaseAuth
                                .instance.currentUser!.photoURL
                                .toString()),
                            // backgroundColor: Colors.grey,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _instance.currentUser!.displayName.toString(),
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              _instance.currentUser!.email.toString(),
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        )
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
              child: Container(
                  width: 800,
                  height: 70,
                  child: Card(
                    elevation: 20,
                    shadowColor: Colors.red[400],
                    child: ListTile(
                      tileColor: Colors.grey[400],
                      leading: Icon(
                        Icons.medical_services,
                        // color: Color.fromARGB(255, 125, 197, 129),
                      ),
                      title: Text(
                        'Medical ID',
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        print("button");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicalIDCard()));
                      },
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
              child: Container(
                  width: 800,
                  height: 70,
                  child: Card(
                    elevation: 20,
                    shadowColor: Colors.red[400],
                    child: ListTile(
                      tileColor: Colors.grey[400],
                      leading: Icon(Icons.logout
                          // color: Color.fromARGB(255, 125, 197, 129),
                          ),
                      title: Text(
                        'Logout',
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () async {
                        print("button");
                        // await googleSignIn.signOut();
                        // await FirebaseAuth.instance.signOut();
                        AuthService().signOut();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MedicalEdit()));
                      },
                    ),
                  )),
            )
          ],
        )),
      )
    ]))));
  }
}
