import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class cvncnvn extends StatefulWidget {
  const cvncnvn({super.key});

  @override
  State<cvncnvn> createState() => _orderhistoryState();
}

class _orderhistoryState extends State<cvncnvn> {
  final CollectionReference _order =
      FirebaseFirestore.instance.collection('orders');
  final CollectionReference _orderhistory =
      FirebaseFirestore.instance.collection('orderdetails');

  var orderidd = "";

  @override
  Widget build(BuildContext context) {
    log("msasess===" + _order.snapshots().toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("order history "),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: StreamBuilder(
        stream: _order

            //  .where(orderidd, isEqualTo: "orderid")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                log("size====" + streamSnapshot.data!.docs.length.toString());
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromARGB(255, 238, 230, 230),
                    ),
                    child: ExpansionTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ORDERID  : ${documentSnapshot['orderid']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      subtitle: Column(children: [
                        Text(
                          'ORDERDATE : ${documentSnapshot['orderdate']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          'ORDERPrice : ${documentSnapshot['orderprice']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ]),
                      children: <Widget>[
                        StreamBuilder(
                            stream: _orderhistory
                                .where("orderid",
                                    isEqualTo: documentSnapshot['orderid'])

                                // .where("orderid")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot1) {
                              log("message2222");
                              if (streamSnapshot1.hasData) {
                                log("message==" +
                                    streamSnapshot1.data!.docs.length
                                        .toString());
                                return Container(
                                  // color: Colors.white,
                                  height: 200,
                                  child: ListView.builder(
                                      itemCount:
                                          streamSnapshot1.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        log("lissss");
                                        final DocumentSnapshot
                                            documentSnapshot1 =
                                            streamSnapshot1.data!.docs[index];
                                        log("imagesss===" +
                                            documentSnapshot1['itemimage']);
                                        return Card(
                                          // color: Colors.blueGrey.shade100,
                                          elevation: 5.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Image(
                                                  height: 80,
                                                  width: 80,
                                                  image: NetworkImage(
                                                      documentSnapshot1[
                                                          'itemimage']),
                                                ),
                                                SizedBox(
                                                  width: 130,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      RichText(
                                                        overflow:
                                                            TextOverflow.clip,
                                                        maxLines: 1,
                                                        text: TextSpan(
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade800,
                                                                fontSize: 16.0),
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      '${documentSnapshot1['itemname']}',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ]),
                                                      ),
                                                      RichText(
                                                        maxLines: 1,
                                                        text: TextSpan(
                                                            // text: '' r"$",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        49,
                                                                        71,
                                                                        82),
                                                                fontSize: 16.0),
                                                            children: [
                                                              TextSpan(
                                                                  text: (documentSnapshot1[
                                                                          'orderprice']
                                                                      .toString()),
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                RichText(
                                                  maxLines: 1,
                                                  text: TextSpan(
                                                      text: '' r"x ",
                                                      style: TextStyle(
                                                          color: Colors.blueGrey
                                                              .shade800,
                                                          fontSize: 16.0),
                                                      children: [
                                                        TextSpan(
                                                            text: (documentSnapshot1[
                                                                    'orderqty']
                                                                .toString()),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                );
                                // ListTile(
                                //     title: Text(
                                //         'address :${documentSnapshot['address']}')),
                                // ListTile(
                                //     title: Text('phone :${documentSnapshot['phone']}')),
                              }
                              return Text("");
                            })
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return Center(
              // child: CircularProgressIndicator(),
              );
        },
      ),
    );
  }
}
