import "package:flutter/material.dart";
import '../style/app_style.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class IoDevices extends StatefulWidget {
  const IoDevices({super.key});

  @override
  State<IoDevices> createState() => _IoDevicesState();
}

class _IoDevicesState extends State<IoDevices> {
  @override
  Widget build(BuildContext context) {
    final firebase = FirebaseFirestore.instance.collection('Basket');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: const Text(
          "Category",
          style: AppStyle.titleStyle,
        ),
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: Column(
        children: [
          const Center(
            child: Column(
              children: [
                SizedBox(height: 40),
                Text("I/O Devices", style: AppStyle.dateStyle),
                SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot?>(
              stream: FirebaseFirestore.instance
                  .collection('IO-Devices')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot?> snapshot) {
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
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
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
                              firebase.add({
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
                                        child:
                                            const Text("Continue to shopping"),
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
    );
  }
}
