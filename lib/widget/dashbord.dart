import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropflutter/widget/orderhistry.dart';
import 'package:dropflutter/widget/productvw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class dropdown extends StatefulWidget {
  const dropdown({Key? key}) : super(key: key);

  @override
  State<dropdown> createState() => _dropdownState();
}

class _dropdownState extends State<dropdown> {
  var selectedMainCategory;
  var selectedSubCategory;
  var products;

  var catid;
  var subcatid1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Image.asset('images/flutter.jpg',
                  // width: 80,
                  // height: 80,),
                  SizedBox(
                    height: 15,
                  ),
                  // Text("name",
                  // style: TextStyle(color: Colors.grey),)
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 64, 48, 48),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('order history'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => cvncnvn()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text('')),
      body: Center(
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                // child: const Text(
                //   ' Select main category',
                //   style: TextStyle(
                //       color: Colors.red, fontFamily: 'muli', fontSize: 16),
                // ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('category')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem<String>> maincategoryitems = [];

                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];

                        maincategoryitems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.get("name"),
                              // "sample",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: snap.get("name"),

                            // catid = field.docs[index].id;
                            //  "Valuesssss"
                            // snap.data().toString()
                            // "${snap.data()}",
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 50,
                          // width: MediaQuery.of(context).size.width,

                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButton<String>(
                              underline: Container(
                                  color: Color.fromARGB(0, 16, 163, 216)),
                              isExpanded: true,
                              items: maincategoryitems,
                              onChanged: (categoryValue) {
                                print(
                                    "current======" + categoryValue.toString());
                                // final snackBar = SnackBar(
                                //   content: Text(
                                //     'Selected main category is $categoryValue',
                                //     style: TextStyle(color: Colors.white),
                                //   ),
                                // );
                                // Scaffold.of(context)
                                // .showSnackBar(snackBar);

                                setState(() {
                                  selectedMainCategory = null;
                                  selectedSubCategory = null;
                                  selectedMainCategory = categoryValue;
                                  print(
                                      "selected main data=================================" +
                                          selectedMainCategory);
                                });

                                var query = FirebaseFirestore.instance
                                    .collection('category')
                                    .where('name', isEqualTo: categoryValue)
                                    .limit(1);

                                Stream<QuerySnapshot> snapshot =
                                    query.snapshots();

                                snapshot.forEach((field) {
                                  field.docs
                                      .asMap()
                                      .forEach((index, data) async {
                                    setState(() {
                                      catid = field.docs[index].id;
                                      print("catid====" + catid);
                                    });
                                    print("catid 2===" + catid);
                                  });
                                  print("cat id 3===" + catid);
                                });

                                // setState(() {

                                // });

                                print("outside forEach catid ===" +
                                    catid.toString());
                              },
                              value: selectedMainCategory,
                              // isExpanded: false,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  "Category",
                                  // mainCategValue,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return Text("");
                  }),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                // child: Text(
                //   ' Select sub category',
                //   // documentid,
                //   style: TextStyle(
                //       color: Colors.red, fontFamily: 'muli', fontSize: 16),
                // ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("subcategory")
                      .where("catid", isEqualTo: catid)
                      .snapshots(),

                  // .snapshots(),

                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem<String>> subcategoryItems = [];

                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        subcategoryItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.get("name"),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 11, 1)),
                            ),
                            value: snap.get("name"),
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Icon(FontAwesomeIcons.cableCar,
                          //     size: 25.0, color: Color(0xff11b719)),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: subcategoryItems,
                            onChanged: (subcategoryValue) {
                              log("subcategoryValue====" +
                                  subcategoryValue.toString());
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected category value is $subcategoryValue',
                                  style: TextStyle(color: Color(0xff11b719)),
                                ),
                              );
                              // Scaffold.of(context).showsnackBar(snackBar);
                              setState(() {
                                // selectedMainCategory = null;
                                selectedSubCategory = null;
                                selectedSubCategory = subcategoryValue;
                              });

                              var query = FirebaseFirestore.instance
                                  .collection('subcategory')
                                  .where('name', isEqualTo: subcategoryValue)
                                  .limit(1);

                              Stream<QuerySnapshot> snapshot =
                                  query.snapshots();

                              snapshot.forEach((field) {
                                field.docs.asMap().forEach((index, data) async {
                                  setState(() {
                                    subcatid1 = field.docs[index].id;
                                    print("catid1====" + subcatid1);
                                  });
                                });
                              });
                            },
                            value: selectedSubCategory,
                            isExpanded: false,
                            hint: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                " subcategory",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return Text("");
                  }),
            ],
          ),
          Padding(padding: EdgeInsets.all(15)),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("products")
                .where("catid", isEqualTo: catid)
                .where("subcategory", isEqualTo: subcatid1)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              // if (streamSnapshot.hasData) {
              switch (streamSnapshot.connectionState) {
                case ConnectionState.waiting:
                // return getShimmerLoading();
                default:
                  return Container(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 25.0,
                        mainAxisSpacing: 6.0,
                        mainAxisExtent: 310,
                      ),
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        //  var price =;
                        double price =
                            double.parse(documentSnapshot['price'].toString());
                        return InkWell(
                          onTap: (() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => prdctitems(
                                        name: documentSnapshot['name'],
                                        price: price,
                                        image: documentSnapshot['image'],
                                        description:
                                            documentSnapshot['description'],
                                        catid: documentSnapshot['catid'],
                                      )),
                            );
                          }),
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              //color: Colors.black,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: <Widget>[
                                Image.network(
                                  '${documentSnapshot['image']}',
                                  height: 160,
                                  width: 120,
                                ),
                                Text(documentSnapshot['name']),
                                Text(documentSnapshot['price'].toString()),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ]),
      ),
    );
  }
}
