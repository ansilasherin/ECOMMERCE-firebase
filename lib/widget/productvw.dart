import 'dart:developer';
//import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:dropflutter/widget/addtocart.dart';
import 'package:dropflutter/list/cartlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

class prdctitems extends StatefulWidget {
  late String image;
  late String description;
  late String name;
  late double price;
  late String catid;
  prdctitems(
      {required this.name,
      required this.price,
      required this.image,
      required this.description,
      required this.catid});

  @override
  State<prdctitems> createState() => _prdctitemsState();
}

class _prdctitemsState extends State<prdctitems> {
  //late final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text('nextpage')),
        body: Stack(
          children: [
      Container(
        height: 250,
        color: Color.fromARGB(255, 147, 22, 68),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(190, 30, 1, 2),
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: IconButton(
                      icon: Icon(Icons.shopping_cart,
                          color: Color.fromARGB(255, 2, 2, 22), size: 34.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const addtocart()),
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: IconButton(
                      icon: Icon(Icons.search,
                          color: Color.fromARGB(255, 2, 2, 22), size: 34.0),
                      onPressed: () {}),
                ),
              ],
            )
          ],
        ),

        //  child:  Text("dataesrdtfygjuk",style:TextStyle(color: Colors.black,fontSize: 20) ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 220),
        child: Container(
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(top: 70, left: 30),
          child: Text(
            //'shoes'

            widget.name,

            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          )),
      Padding(
          padding: EdgeInsets.only(left: 30, top: 120),
          child: Text(
            '₹${widget.price}',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          )),
      Padding(
          padding: EdgeInsets.only(left: 10, top: 340),
          child: Text(
            //'shoeaaa'
            widget.name,
            style: TextStyle(
              fontSize: 30,
              // fontWeight: FontWeight.bold,
              fontWeight: FontWeight.bold,
            ),
          )),
      Padding(
          padding: EdgeInsets.only(top: 390, left: 10),
          child: Text(
            // 'available',
            widget.description,
            style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          )),
      SizedBox(
        height: 150,
      ),
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 130),
          child: Container(
            height: 200,
            child: Image.network(
              widget.image,
              height: 220,
              width: 200,
            ),
          ),
        ),
      ),
      Consumer<Cart>(builder: (context, cart, child) {
        return Padding(
          padding: EdgeInsets.only(top: 550, left: 200),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 15.0,
                minimumSize: Size(145, 55),
                textStyle: TextStyle(fontSize: 17)),
            child: Text('ADD TO CART'),
            onPressed: () {
              if (cart.isItemExist(widget.catid)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 60),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Color.fromARGB(255, 174, 166, 166),
                    content: Text(
                      'ITEM ALREADY IN CART',
                      textAlign: TextAlign.center,
                    )));

                log("item already in cart");
              } else {
                context.read<Cart>().addItem(
                    widget.name, widget.price, 1, widget.image, widget.catid);
              }

              log("message02");
            },
          ),
        );
//
      })
    ]));
  }
}