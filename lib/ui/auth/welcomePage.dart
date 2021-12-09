import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'loginPage.dart';
import 'registerPage.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            FadeInUp(
              delay: Duration(milliseconds: 250),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width*0.1
                ),
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(
                      "assets/cat-dog.png"
                  ),
                ),
              ),
            ),
            FadeInDown(
              delay: Duration(milliseconds: 500),
              child: Container(
                width: MediaQuery.of(context).size.width * .8,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pets, size: MediaQuery.of(context).size.width * .15),
                    SizedBox(width: 20,),
                    Text(
                        "MascotAlerta",
                        style: new TextStyle(
                            color: Colors.green,
                            fontSize: MediaQuery.of(context).size.width * .07,
                            fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 70),
            FadeInLeft(
                delay: Duration(milliseconds: 100),
                child: optionButton(context, "Iniciar Sesión", 1)
            ),
            SizedBox(height: 30),
            FadeInRight(
                delay: Duration(milliseconds: 200),
                child: optionButton(context, "Registrarse", 2)
            ),
          ],
        ),
      ),
    );
  }
  Widget optionButton(BuildContext context, String text, int option) {
    return Container(
      width: MediaQuery.of(context).size.width * .84,
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: new FlatButton(
        child: new Text(
          text,
          style: new TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * .05,
              fontWeight: FontWeight.bold),
        ),
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        onPressed: () {
          if(option == 1){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }else if (option == 2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
          }
        },
      ),
    );
  }

}
