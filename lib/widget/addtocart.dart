import 'dart:developer';
//import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropflutter/list/cartlist.dart';
//import 'package:droppp_flutter/placeorder.dart';
//import 'package:droppp_flutter/img.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'payment.dart';

class addtocart extends StatefulWidget {
  const addtocart({Key? key}) : super(key: key);

  @override
  State<addtocart> createState() => _addtocartState();
}

class _addtocartState extends State<addtocart> {
  // int _counter = 0;
//  Cart? cart;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  final formKey = GlobalKey<FormState>(); //key for form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 249, 246, 246),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Cart ",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                onPressed: () {
                  // context.read<Cart>().clearCart();
                  final shouldDelete = showDeleteDialog(context);
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Consumer<Cart>(
            builder: (context, cart, child) {
              return ListView.builder(
                itemCount: cart.count,
                itemBuilder: (BuildContext context, int index) {
                  // final cart = Cart.Addtocart[index];
                  final product = cart.getItems[index];

                  log("pr===" + product.name);
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F9),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    image: DecorationImage(
                                        image: NetworkImage(product.imagesUrl),
                                        fit: BoxFit.cover)),
                                height: 80,
                                width: 80,
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 12, left: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            log("message===" + product.catid);

                                            context
                                                .read<Cart>()
                                                .removeItem(product);

                                            // showcancelDialog(
                                            //     context, product.catid);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 80,
                                    ),
                                    child: Text(product.price.toString()
                                        // cart.price.toString()
                                        ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, right: 50, bottom: 30),
                                    child: Container(
                                      // ignore: unnecessary_new
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              //minus();
                                              setState(() {
                                                if (product.qty != 1) {
                                                  cart.reduceByOne(product);
                                                }
                                                // data[index].qty --;
                                                //   data[index].qty ++;

                                                //  if (product.qty != 1)
                                                //   {
                                                //   // cart.reduceByOne(product);
                                                //   }

                                                // product.qty;
                                              });
                                              // product.qty == product.qntty
                                              //     ? null
                                              //     : cart.reduceByOne(product);
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                  color: Colors.grey.shade300),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  FontAwesomeIcons.minus,
                                                  size: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // new FloatingActionButton(
                                          //   onPressed: add,
                                          //   child: new Icon(
                                          //     Icons.add,
                                          //     color: Colors.black,
                                          //   ),
                                          //   backgroundColor: Colors.white,
                                          // ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(product.qty.toString(),
                                              style: new TextStyle(
                                                  fontSize: 20.0)),
                                          SizedBox(
                                            width: 8,
                                          ),

                                          InkWell(
                                            onTap: () {
                                              //add();
                                              log('vgfytegftygf======+');
                                              cart.increment(product);
                                            },
                                            child: Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                    color:
                                                        // Color.fromARGB(255, 30, 114, 106)
                                                        Colors.grey.shade300),
                                                child: new Icon(Icons.add)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        bottomSheet: Consumer<Cart>(builder: (context, cart, child) {
          return Container(
            color: Colors.grey.shade200,
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          cart.totalPrice.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            side: BorderSide(width: 3, color: Colors.brown),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.only(
                            //       topLeft: Radius.circular(30.0),
                            //       topRight: Radius.circular(30.0)),
                            // ),
                            builder: (BuildContext context) {
                              return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                      child: Wrap(
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Enter Name'),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !RegExp(r'^[a-z A-Z]+$')
                                                  .hasMatch(value)) {
                                            //allow upper and lower case alphabets and space
                                            return "Enter Correct Name";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 80,
                                      ),
                                      TextFormField(
                                        controller: addressController,
                                        decoration: InputDecoration(
                                            labelText: 'Enter address'),
                                      ),
                                      TextFormField(
                                        controller: mobileController,
                                        decoration: const InputDecoration(
                                          //  icon: const Icon(Icons.phone),
                                          hintText: 'Enter a phone number',
                                          labelText: 'Phone',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !RegExp("^[7-9][0-9]{9}")
                                                  .hasMatch(value)) {
                                            return "Enter Correct phone No";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 80,
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            if (addressController.text !=
                                                null) {
                                              CollectionReference order =
                                                  FirebaseFirestore.instance
                                                      .collection('orders');

                                              final docId = order.doc().id;

                                              print("docId =" + docId);

                                              order.doc(docId).set({
                                                'name': nameController.text,
                                                'address':
                                                    addressController.text,
                                                'orderid': docId,
                                                'deliverystatus': 'delivered',
                                                'orderdate': DateTime.now(),
                                                'paymentstatus':
                                                    'cash on delivery',
                                                'orderprice': cart.totalPrice,
                                              });
                                              CollectionReference orderdetails =
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'orderdetails');
                                              for (var item in context
                                                  .read<Cart>()
                                                  .getItems) {
                                                int a = 0;

                                                final dc = order.doc().id +
                                                    a.toString();
                                                log("message sent items====" +
                                                    dc);
                                                await orderdetails.doc(dc).set({
                                                  'orderid': docId,
                                                  'itemname': item.name,
                                                  'itemimage': item.imagesUrl,
                                                  'orderqty': item.qty,
                                                  'orderprice':
                                                      item.qty * item.price,
                                                  'deliverystatus': 'preparing',
                                                  'paymentstatus':
                                                      'cash on delivery',
                                                  'orderreview': false,
                                                }).whenComplete(() async {
                                                  a++;

                                                  log("sending completed");
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  200),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  174,
                                                                  166,
                                                                  166),
                                                          content: Text(
                                                            'ORDER SUCCESSFULL',
                                                            textAlign: TextAlign
                                                                .center,
                                                          )));
                                                });
                                              }
                                            } else {
                                              //// snack bar
                                            }
                                          },
                                          child: ElevatedButton(
                                              child: const Text('Ok'),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          pymntt(
                                                            Address:
                                                                addressController
                                                                    .text,
                                                            Name: nameController
                                                                .text,
                                                            phone: "4567",
                                                          )),
                                                );
                                              })),
                                    ],
                                  )));
                            },
                          );
                        },
                        child: Text(
                          "checkout",
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        )),
                  ),

                  //Padding(padding: EdgeInsets.all(8))
                ],
              ),
            ),
          );
        }));
  }

  Future<bool> showDeleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('ARE U SURE? '),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  // context.read<Cart>().clearCart();
                },
                child: const Text("CANCEL"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  context.read<Cart>().clearCart();
                },
                child: const Text("DELETE"),
              ),
            ],
          );
        }).then((value) {
      if (value is bool) {
        return value;
      } else {
        return false;
      }
    });
  }

  Future<bool> showcancelDialog(BuildContext context, String catid) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('ARE U SURE? '),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  // context.read<Cart>().clearCart();
                },
                child: const Text("CANCEL"),
              ),
              TextButton(
                onPressed: () {
                  log(catid);

                  Navigator.of(context).pop(true);
                  context.read<Cart>().removeIte22m(catid);
                },
                child: const Text("DELETE"),
              ),
            ],
          );
        }).then((value) {
      if (value is bool) {
        return value;
      } else {
        return false;
      }
    });
  }
}
