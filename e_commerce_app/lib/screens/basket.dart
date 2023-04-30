import "package:flutter/material.dart";
import '../style/app_style.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class Basket extends StatefulWidget {
  const Basket({super.key});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  int totalPrice = 0;

  Future<void> deleteCollection(String collectionPath) async {
    final collectionRef = FirebaseFirestore.instance.collection(collectionPath);
    final batch = FirebaseFirestore.instance.batch();

    await collectionRef.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        batch.delete(ds.reference);
      }
      return batch.commit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: const Text(
          "Basket",
          style: AppStyle.titleStyle,
        ),
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Basket').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          totalPrice = snapshot.data!.docs
              .fold(0, (acc, document) => acc + (document['price'] as int));

          return Column(
            children: [
              Expanded(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return ListTile(
                      title: Text(
                        "${document['product_name']}",
                        style: AppStyle.headerStyle,
                      ),
                      subtitle: Text(
                        "${document['price']}\$",
                        style: AppStyle.threedotitemsStyle,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () async {
                          setState(() {
                            totalPrice -= (document['price'] as int);
                            FirebaseFirestore.instance
                                .collection('Basket')
                                .doc(document.id)
                                .delete();
                          });
                        },
                      ),
                      onTap: () async {
                        setState(() {
                          totalPrice -= (document['price'] as int);
                          FirebaseFirestore.instance
                              .collection('Basket')
                              .doc(document.id)
                              .delete();
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text('Total price: $totalPrice\$',
                        style: AppStyle.headerStyle),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      deleteCollection("Basket");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Row(
                              children: [
                                Icon(Icons.check_box_rounded),
                                Text(
                                  " Success",
                                ),
                              ],
                            ),
                            content: const Text(
                                "You Successfully Bought Items.",
                                style: AppStyle.threedotitemsStyle),
                            actions: <Widget>[
                              MaterialButton(
                                  child: const Text("Continue"),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          );
                        },
                      );
                    },
                    child:
                        const Text("Buy", style: AppStyle.addBasketButtonStyle),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
