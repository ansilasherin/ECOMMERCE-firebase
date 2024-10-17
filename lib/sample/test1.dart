import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class exmpll extends StatefulWidget {
  const exmpll({super.key});

  @override
  State<exmpll> createState() => _exmpllState();
}

class _exmpllState extends State<exmpll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("geeksforgeeks"),
      ),
      body:Center(
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('data') 
                .add({'text': 'data added '});
          },
        ),
      ),
    );
  }
}


   