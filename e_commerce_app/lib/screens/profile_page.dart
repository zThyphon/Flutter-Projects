import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "../style/app_style.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 2;
  final appBarNames = [
    const Text("Home", style: AppStyle.headerStyle),
    const Text("Products", style: AppStyle.headerStyle),
    const Text("Profile", style: AppStyle.headerStyle),
  ];
  String? userMail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: appBarNames[_currentIndex],
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 180),
            SizedBox(
              width: 120,
              height: 120,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                )),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset("images/user.png"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Signed in", style: AppStyle.profileHeaderStyle),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Email:", style: AppStyle.profileHeaderStyle),
                Text("$userMail", style: AppStyle.profileMailStyle),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Let's Start Shopping",
                  style: AppStyle.profileButtonStyle),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.blue,
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            backgroundColor: Colors.blue,
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            backgroundColor: Colors.blue,
            label: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
