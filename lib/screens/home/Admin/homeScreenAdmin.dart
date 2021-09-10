import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/helpers/constants/constantConstant.dart';
import 'package:stage_10000_codeurs/models/roleModel.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';
import 'package:stage_10000_codeurs/widget/loading.dart';
import 'package:stage_10000_codeurs/widget/myAppBar.dart';

enum ListRole { Jeune, Expert, Mentor, Direction }

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({Key? key}) : super(key: key);

  @override
  _HomeScreenAdminState createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {

  /* late int selectedRadio;
  @override
  void initState(){
    super.initState();
    selectedRadio = 0;
  }
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadio = val;
    });
  }*/

  //CollectionReference _users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: StreamBuilder(
        stream: userService.userCollection.orderBy('role').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final AppUserData appUserData = AppUserData(
                    uid: snapshot.data.docs[index].id,
                    name: snapshot.data.docs[index]['name'],
                    lastname: snapshot.data.docs[index]['lastname'],
                    email: snapshot.data.docs[index]['email'],
                    role: snapshot.data.docs[index]['role']);
                return Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(appUserData.email,
                            style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(appUserData.role,
                            style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18),),
                          trailing: Wrap(
                            spacing: 1,
                            children: [
                              TextButton.icon(
                                icon: Icon(Icons.change_circle_outlined,color: Colors.white,),
                                onPressed: () {
                                  //TODO: récuperer id d'user sélectionné
                                  userService.userCollection.where('email', isEqualTo: appUserData.email).get()
                                      .then((value) {
                                    _changerole(context, value.docs[0].id);
                                  });
                                  print(" " + appUserData.email+ " " + appUserData.role);
                                },
                                label: Text("Changer Rôle",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(backgroundColor: greenCodeurs),
                              ),
                              /*TextButton.icon(
                                        icon: Icon(Icons.change_circle_outlined, color: Colors.white,),
                                        onPressed: (){},
                                        label: Text("Mentor",style: TextStyle(color: Colors.white),),
                                        style: TextButton.styleFrom(backgroundColor: blueCodeurs),
                              ),*/
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey),
                          ),
                          tileColor: Colors.grey[300],
                        ),
                    ),

                    /*Divider(
                      color: Colors.black,
                    ),*/
                  ],
                );
              }
          );
        },
      ),
    );
  }

  /*late List<Role> roles;

  @override
  void initState() {
    super.initState();
    roles = Role.getUsers();
  }

  setSelectedRole(Role role) {
    setState(() {
      selectedRole = role;
    });
  }*/


  /*List<String> roleList = ["Jeune","Expert","Mentor","Direction"];
  late int _currentIndex = 0;*/
  ListRole? _value = ListRole.Jeune;

  _changerole(BuildContext context, String docId) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Changement de Rôle'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text('CANCEL'),
                  ),
                  TextButton(
                    onPressed: () async {
                      userService.updateUser(_value, docId);
                      Navigator.of(context).pop();
                      print("////////\n");
                      print(_value);
                    },
                    child: Text('OK'),
                  ),
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                ),
                content: Container(
                    width: double.minPositive,
                    height: 225,
                    child: Column(
                      children: [
                        RadioListTile(
                          value: ListRole.Jeune,
                          groupValue: _value,
                          onChanged: (ListRole? value) {
                            setState(() {
                              _value = value;
                            });
                          },
                          title: Text("Jeune"),
                        ),
                        RadioListTile(
                          value: ListRole.Expert,
                          groupValue: _value,
                          onChanged: (ListRole? value) {
                            setState(() {
                              _value = value;
                            });
                          },
                          title: Text("Expert"),
                        ),
                        RadioListTile(
                          value: ListRole.Mentor,
                          groupValue: _value,
                          onChanged: (ListRole? value) {
                            setState(() {
                              _value = value;
                            });
                          },
                          title: Text("Mentor"),
                        ),
                        RadioListTile(
                          value: ListRole.Direction,
                          groupValue: _value,
                          onChanged: (ListRole? value) {
                            setState(() {
                              _value = value;
                            });
                          },
                          title: Text("Direction"),
                        ),
                      ],
                    )
                ),
              );
            },
          );
        });
  }
}