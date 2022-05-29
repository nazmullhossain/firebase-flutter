import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();dff
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _fromkey=GlobalKey<FormState>();
  var name='';
  var age=0;

  @override
  Widget build(BuildContext context) {
    CollectionReference users= FirebaseFirestore.instance.collection("users");
    return Form(
        key: _fromkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: "What your name",
              labelText: "name",

            ),
            onChanged: (value){
               name= value;
            },
            validator: (value){
              if(value==null || value.isEmpty){
                return "please enter some text";
              } return null;
            },

          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: "What your age",
              labelText: "age",

            ),
            onChanged: (value){
              age= int.parse(value);
            },
            validator: (value){
              if(value==null || value.isEmpty){
                return "please enter some text";
              } return null;
            },

          ),

          SizedBox(height: 10,),
          Center(
            child: ElevatedButton(
                onPressed: (){
                  if (_fromkey.currentState!.validate()){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Sending Data to cloud Firestore"),
                        ),
                    );

                    users.add({'name': name, 'age': age }).then((value) =>
                        print("user added")).catchError((error)=>print('Failed to add user: $error'));

                  }
                },
                child: Text("Submit")),
          )
        ],
      ),
    );
  }
}
