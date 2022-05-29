import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'custom_form.dart';


class HomeScreen extends StatelessWidget {
  final Stream <QuerySnapshot> users=FirebaseFirestore.instance.collection('users').snapshots();
 HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Firestore Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Read Data from Cloud Firestore",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            Container(
              height: 250,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: StreamBuilder<QuerySnapshot>(
                stream: users,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot,){
                  if(snapshot.hasError ){
                    return Text("Something Went Wrong");
                  }
                  else if (snapshot.connectionState==ConnectionState.waiting){
                    return Text ("Loading");
                  }
                  final data= snapshot.requireData;
                  return ListView.builder(
                    itemCount: data.size,
                      itemBuilder: (context,index){
                      return Text('My name is ${data.docs[index]['name']} and I am ${data.docs[index]['age']}');
                      },
                      );
              },
              )
            ),
            Text("Write Data to cloud Firestore",
            style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),
            ),
              MyCustomForm(),
          ],
        ),
      ),
    );
  }
}

