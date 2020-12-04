import 'dart:convert';
import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mascota_alerta/models/userModel.dart';
import 'package:mascota_alerta/ui/auth/welcomePage.dart';
import 'package:mascota_alerta/ui/cases/casesMap.dart';
import 'package:mascota_alerta/ui/cases/lostPetsPage.dart';
import 'package:mascota_alerta/ui/cases/registerCase.dart';
import 'package:mascota_alerta/ui/cases/rescuePetsPage.dart';
import 'package:mascota_alerta/ui/cases/seenPetsPage.dart';
import 'package:mascota_alerta/ui/profile/profilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  GlobalKey servicesKey = GlobalKey();
  GlobalKey historyKey = GlobalKey();
  GlobalKey myCreditCardsKey = GlobalKey();
  GlobalKey myCarsKey = GlobalKey();
  GlobalKey helpKey = GlobalKey();
  GlobalKey configKey = GlobalKey();
  BuildContext loadingContext;
  String name;
  String letters;
  Uint8List photo;
  SharedPreferences prefs;
  UserModel user;
  @override
  void initState() {
    initSharedPreferences();

    super.initState();
  }
  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      user = UserModel.fromJson(jsonDecode(prefs.getString("user")));
      try{
        photo = base64Decode(user.photo);
      }catch(e){}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: prefs ==null ?
            Container() :
        Column(
          children: <Widget>[
            Container(
              color: Colors.green,
              height: MediaQuery.of(context).size.height * .24,
              child: FadeInLeft(
                delay: Duration(milliseconds: 250),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .33,
                      child: Center(
                        child: Container(
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            border: new Border.all(
                              color: Colors.black,
                              width: 0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 3.0,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.black,
                              child: ClipOval(
                                  child: Image.memory(
                                    photo ,
                                    width: 170,
                                    height: 170,
                                    fit: BoxFit.cover,
                                  ))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .01,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .3,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                user.name,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                user.email,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
            FadeInLeft(
              delay: Duration(milliseconds: 500),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  options(
                      Icon(Icons.location_on),
                      'Mapas de Casos',
                      (){
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) => CasesMap()),
                                (route) => false
                        );
                      }
                  ),
                  options(
                      Icon(Icons.assignment),
                      'Reportar Caso',
                      (){
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) => RegisterCase()),
                                (route) => false
                        );
                      }
                  ),
                  options(
                      Icon(Icons.pets),
                      'Rescate de Mascotas',
                          (){
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) => RescuePetsPage()),
                                (route) => false
                        );
                      }
                  ),
                  options(
                      Icon(Icons.warning_outlined),
                      'Mascotas perdidas',
                      (){
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) => LostPetsPage()),
                                (route) => false
                        );
                      }
                  ),
                  options(
                      Icon(Icons.remove_red_eye),
                      'Lista de vistos',
                      (){
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) => SeenPetsPage()),
                                (route) => false
                        );
                      }
                  ),
                  options(
                      Icon(Icons.person),
                      'Mi perfil',
                      (){
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) => ProfilePage()),
                                (route) => false
                        );
                      }
                  ),
                  SizedBox(height: 50,),
                  Divider(),
                  options(
                      Icon(Icons.backspace),
                      'Cerrar Sesión',
                          (){}
                  ),
                ],
              ),
            )
          ],
        ),

      ),
    );
  }

  confirmation() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            elevation: 3,
            title: Text(
                "Atención",
            ),
            content: Text(
                "¿Está seguro que desea cerrar sesión?",
            ),
            actions: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                color: Colors.green,
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                color: Colors.green,
                child: Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  prefs.remove("user");
                  prefs.clear();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) => WelcomePage()
                  ), (route) => false);
                },
              ),
            ],
          );
        });
  }


  Widget options(Icon icon, String title, Function navigationRoute) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: ListTile(
        onTap: title != 'Cerrar Sesión'
            ? navigationRoute
            : () {
          confirmation();
        },
        dense: true,
        leading: icon,
        title: Text(
            title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width*0.035
          ),
        ),
      ),
    );
  }
}