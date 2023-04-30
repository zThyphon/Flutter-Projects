import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import '../style/app_style.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "computers_page.dart";
import "smart_phones.dart";
import "io_devices.dart";
import "login_page.dart";
import "../service/auth.dart";
import "basket.dart";

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static int _currentIndex = 0;
  static final firebase = FirebaseAuth.instance;
  static final String? userMail = firebase.currentUser!.email;
  static final firebaseBasket = FirebaseFirestore.instance.collection("Basket");
  static final _authService = AuthService();

  static final carouselImages = [
    "images/model_photos/laptop4.jpg",
    "images/model_photos/laptop3.png",
    "images/model_photos/phone2.jpg",
    "images/model_photos/phone3.jpg",
    "images/model_photos/keyboard2.jpg",
    "images/model_photos/mouse2.jpg",
    "images/model_photos/webcam2.jpg",
    "images/model_photos/microphone1.jpg",
  ];

  var tabs = [
    Column(
      children: [
        Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text("Most Popular Items", style: AppStyle.dateStyle),
              const SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount: carouselImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = carouselImages[index];
                  return buildImage(urlImage, index);
                },
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: StreamBuilder<QuerySnapshot?>(
            stream: FirebaseFirestore.instance
                .collection('Popular Products')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}',
                    style: AppStyle.productNameStyle);
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...',
                    style: AppStyle.productNameStyle);
              }

              if (snapshot.data == null) {
                return const Text('No data available',
                    style: AppStyle.productNameStyle);
              }

              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            document['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        ListTile(
                          title: Center(
                            child: Text(document['name'],
                                style: AppStyle.productNameStyle),
                          ),
                          subtitle: Center(
                            child: Text(
                              '${document['price']}\$',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            firebaseBasket.add({
                              "product_name": document["name"],
                              "price": document["price"],
                            });

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Row(
                                    children: [
                                      Icon(Icons.library_add_check),
                                      Text(
                                        " Success",
                                      ),
                                    ],
                                  ),
                                  content: const Text(
                                      "You Successfully Added Item to Basket"),
                                  actions: <Widget>[
                                    MaterialButton(
                                      child: const Text("Continue to shopping"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text("Add Basket",
                              style: AppStyle.addBasketButtonStyle),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    ),
    //------------------------------------------------------------------
    Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: StreamBuilder<QuerySnapshot?>(
            stream:
                FirebaseFirestore.instance.collection('Products').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}',
                    style: AppStyle.productNameStyle);
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...',
                    style: AppStyle.productNameStyle);
              }

              if (snapshot.data == null) {
                return const Text('No data available',
                    style: AppStyle.productNameStyle);
              }

              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            document['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        ListTile(
                          title: Center(
                            child: Text(document['name'],
                                style: AppStyle.productNameStyle),
                          ),
                          subtitle: Center(
                            child: Text(
                              '${document['price']}\$',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            firebaseBasket.add({
                              "product_name": document["name"],
                              "price": document["price"],
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Row(
                                    children: [
                                      Icon(Icons.library_add_check),
                                      Text(
                                        " Success",
                                      ),
                                    ],
                                  ),
                                  content: const Text(
                                      "You Successfully Added Item to Basket"),
                                  actions: <Widget>[
                                    MaterialButton(
                                      child: const Text("Continue to shopping"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text("Add Basket",
                              style: AppStyle.addBasketButtonStyle),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    ),
    //------------------------------------------------------------------
    Center(
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
                ),
              ),
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
        ],
      ),
    ),
    //------------------------------------------------------------------
  ];
  final appBarNames = [
    const Text("Home", style: AppStyle.headerStyle),
    const Text("Products", style: AppStyle.headerStyle),
    const Text("Profile", style: AppStyle.headerStyle),
  ];

  static Widget buildImage(String imageUrl, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.asset(imageUrl, fit: BoxFit.cover),
      );

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
      drawer: Drawer(
        backgroundColor: Colors.blue,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Center(child: Text('Menu', style: AppStyle.titleStyle)),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: Text("Products", style: AppStyle.contentStyle),
            ),
            ListTile(
              leading: const Icon(Icons.computer, color: Colors.white),
              title: const Text(
                'Computers',
                style: AppStyle.contentStyle,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ComputersPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.phone_android,
                color: Colors.white,
              ),
              title: const Text(
                'Smart Phones',
                style: AppStyle.contentStyle,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SmartphonesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              title: const Text(
                'Input-Output Devices',
                style: AppStyle.contentStyle,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IoDevices()),
                );
              },
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: Text("Profile", style: AppStyle.contentStyle),
            ),
            ListTile(
              leading: const Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ),
              title: const Text(
                'Basket',
                style: AppStyle.contentStyle,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Basket()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'Logout',
                style: AppStyle.contentStyle,
              ),
              onTap: () {
                _authService.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              },
            ),
          ],
        ),
      ),
      body: tabs[_currentIndex],
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
