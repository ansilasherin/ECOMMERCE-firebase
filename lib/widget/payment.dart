import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropflutter/widget/dashbord.dart';

//import 'package:firestore1/shop/screens/home.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:toast/toast.dart';
import 'dart:developer';
import '../../models/cartmodel.dart';
import '../list/cartlist.dart';

class pymntt extends StatefulWidget {
  @override
  State<pymntt> createState() => _paymentState();
  late String Name, phone, Address;
  pymntt({required this.Name, required this.phone, required this.Address});

  CollectionReference _orders = FirebaseFirestore.instance.collection('orders');
}

String? paymenttype = 'offline';
double orderprice = 0;

CollectionReference _orders =
    FirebaseFirestore.instance.collection('orderdetails');

class _paymentState extends State<pymntt> {
  @override
  late Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void flutterpayment(String orderId, int t) {
    var options = {
      "key": "rzp_test_kMTf58GCPpztv1",
      "amount": t * 100,
      'name': widget.Name,
      'currency': 'INR',
      'description': 'ecommerce',
      'external': {
        'wallets': ['paytm']
      },
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      "prefill": {"contact": widget.phone, "email": "ansia1037@gmail.com"},
    };
    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    response.orderId;

    log("successss" + response.orderId.toString());

    CollectionReference orderRef =
        FirebaseFirestore.instance.collection('orders');
    CollectionReference orderdetailsRef =
        FirebaseFirestore.instance.collection('orderdetails');

    final docId = orderRef.doc().id;
  
    print("docId =" + docId);

    orderRef.doc(docId).set({
      'name': widget.Name,
      'address': widget.Address,
      'phone': widget.phone,
      'orderid': docId,
      'deliverystatus': 'preparing',
      'orderdate': DateTime.now().toString(),
      'paymentstatus': 'online',
      'orderprice': "12000",
      // 'orderreview': false,
    });

    for (var item in context.read<Cart>().getItems) {
      await orderdetailsRef.doc().set({
        'orderid': docId,
        'itemname': item.name,
        'itemimage': item.imagesUrl,
        'orderqty': item.qty,
        'orderprice': item.qty * item.price,
        'deliverystatus': 'preparing',
        'paymentstatus': 'cash on delivery',
        'orderreview': false,
      }).whenComplete(() async {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(milliseconds: 200),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(255, 174, 166, 166),
            content: Text(
              'ORDER SUCCESSFULL',
              textAlign: TextAlign.center,
            )));
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => dropdown()));
    }

    // Toast.show("siuccesss==="+response.paymentId.toString());

    log("message outtt");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Toast.show("success===" + response.message.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Toast.show("success===" + response.walletName.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("payment"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: ListView(
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Consumer<Cart>(
                    builder: (context, cart, child) {
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromARGB(255, 238, 230, 230),
                        ),
                        padding: EdgeInsets.all(30),
                        child: Row(
                          children: [
                            RichText(
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16.0),
                                  children: [
                                    TextSpan(
                                        text: '${'Total Order:'}',
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(
                            //     vertical: 1,
                            //   ),
                            // ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
                                child: RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0),
                                      children: [
                                        TextSpan(
                                            text: (cart.totalPrice.toString()),
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                )),
                            SizedBox(height: 15),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(255, 238, 230, 230)),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              "PAYMENT TYPE?",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Divider(),
                            RadioListTile(
                              title: Text(
                                "Cash On Delivery",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Pay Cash At Home"),
                              value: "offline",
                              groupValue: paymenttype,
                              onChanged: (value) {
                                setState(() {
                                  paymenttype = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text("Pay Now"),
                              value: "online",
                              groupValue: paymenttype,
                              onChanged: (value) {
                                setState(() {
                                  paymenttype = value.toString();
                                });
                                //  print("object"+paymenttype.toString());
                              },
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  height: 75,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        // child: Icon(
                                        //   Icons.credit_card,
                                        //   color: Colors.indigoAccent,
                                        // ),
                                      ),
//                                       ImageIcon(
//      AssetImage('assets/icon/123.png'),
//      size: 5,

// ),
                                      // Icon(
                                      //   Icons.payment,
                                      //   color: Colors.indigoAccent,
                                      // ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      )),
                ])),
        bottomSheet: Consumer<Cart>(builder: (context, cart, child) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 238, 235, 235),
              ),
              height: 90,
              width: 400,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(children: [
                  Padding(padding: EdgeInsets.all(1)),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    // color: Colors.red,
                    height: 50,
                    width: 350,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      //color: product.color,
                      onPressed: () async {
                        if (cart.count.toString() == "0") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(milliseconds: 30),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor:
                                  Color.fromARGB(255, 174, 166, 166),
                              content: Text(
                                'ADD ITEM IN CART',
                                textAlign: TextAlign.center,
                              )));
                        } else if (paymenttype != "online") {
                          CollectionReference orderRef =
                              FirebaseFirestore.instance.collection('orders');
                          CollectionReference orderdetailsRef =
                              FirebaseFirestore.instance
                                  .collection('orderdetails');

                          final docId = orderRef.doc().id;

                          print("docId =" + docId);
                          var date = DateTime.now();
                          var formattedDate =
                              "${date.day}-${date.month}-${date.year}";

                          orderRef.doc(docId).set({
                            'name': widget.Name,
                            'address': widget.Address,
                            'phone': widget.phone,
                            'orderid': docId,  
                            'deliverystatus': 'preparing',
                            'orderdate': formattedDate,
                            'paymentstatus': 'cash on delivery',
                            'orderprice': cart.totalPrice,
                            // 'orderreview': false,
                          });

                          for (var item in context.read<Cart>().getItems) {
                            await orderdetailsRef.doc().set({
                              'orderid': docId,
                              'itemname': item.name,
                              'itemimage': item.imagesUrl,
                              'orderqty': item.qty,
                              'orderprice': item.qty * item.price,
                              'deliverystatus': 'preparing',
                              'paymentstatus': 'cash on delivery',
                              'orderreview': false,
                            }).whenComplete(() async {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(milliseconds: 200),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor:
                                          Color.fromARGB(255, 174, 166, 166),
                                      content: Text(
                                        'ORDER SUCCESSFULL',
                                        textAlign: TextAlign.center,
                                      )));
                            });
                            context.read<Cart>().clearCart();
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => dropdown()));
                            });
                          }
                        } else {
                          log("using online payment........");
                          orderprice = cart.totalPrice;
                          flutterpayment("aaa", cart.totalPrice.toInt());
                        }
                      },

                      child: Text(
                        'CONFIRM ${cart.totalPrice}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                )
              ]));
        }));
  }
}
