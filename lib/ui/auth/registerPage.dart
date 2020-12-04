import 'dart:convert';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascota_alerta/models/userModel.dart';
import 'package:mascota_alerta/provider/userProvider.dart';
import 'package:mascota_alerta/ui/cases/casesMap.dart';
import 'package:mascota_alerta/ui/widgets/loadingAlertDismissible.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  BuildContext loadingContext;
  TextEditingController emailFieldController;
  TextEditingController passwordFieldController;
  TextEditingController confirmPasswordFieldController;
  TextEditingController nameFieldController;
  SharedPreferences prefs;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  String _image;
  bool showPassword;
  UserModel user;
  @override
  void initState() {
    initSharedPreferences();
    emailFieldController = new TextEditingController();
    emailFieldController.clear();
    passwordFieldController = new TextEditingController();
    passwordFieldController.clear();
    confirmPasswordFieldController = new TextEditingController();
    confirmPasswordFieldController.clear();
    nameFieldController = new TextEditingController();
    nameFieldController.clear();
    showPassword = true;
    super.initState();
  }
  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
  Widget createTextLabel(String text) {
    return Container(
      width: MediaQuery.of(context).size.width * .84,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.w700,
            color: Colors.black.withOpacity(0.4)),
        textAlign: TextAlign.left,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "Registro de Caso"
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _form,
            child: Column(
              children: [
                SizedBox(height: 30,),
                FadeInDown(
                  delay: Duration(milliseconds: 200),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Center(
                        child: InkWell(
                          onTap: () {
                            _optionsPicture();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.475,
                            height: MediaQuery.of(context).size.width*0.475,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.green,
                              //  shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              child: _image == null
                                  ?
                              Icon(
                                  Icons.pets_outlined,
                                color: Colors.black,
                                size: MediaQuery.of(context).size.width*0.35,
                              )
                                  : ClipOval(
                                child: Image.memory(
                                  Base64Decoder().convert(_image),
                                  fit: BoxFit.contain,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 150,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  ),
                                ],
                                border:
                                Border.all(width: 1, color: Colors.black12),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  _optionsPicture();
                                },
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FadeInLeft(
                    delay: Duration(milliseconds: 150),
                    child: nameInput()
                ),
                SizedBox(height: 30,),
                FadeInRight(
                    delay: Duration(milliseconds: 300),
                    child: emailInput()
                ),
                SizedBox(height: 30,),
                FadeInLeft(
                    delay: Duration(milliseconds: 150),
                    child: passwordInput()
                ),
                SizedBox(height: 30,),
                FadeInRight(
                    delay: Duration(milliseconds: 300),
                    child: confirmPasswordInput()
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .2,),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FadeInDown(
        delay: Duration(milliseconds: 400),
        child: InkWell(
          onTap: (){
            _submit();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset:
                    Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.green),
            child: Center(
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width*0.06,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  Widget emailInput() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          createTextLabel('Correo Electrónico'),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .84,
            color: Colors.transparent,
            child: new TextFormField(
              validator: (text){
                if(emailFieldController.text.isEmpty){
                  return "Llenar Campo";
                }else{
                  return null;
                }
              },
              enabled: true,
              cursorColor: Colors.green,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.7)),
              controller: emailFieldController,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.4), width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: new Icon(
                  Icons.mail,
                  color: Colors.green,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget passwordInput() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          createTextLabel('Contraseña'),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .84,
            child: new TextFormField(
              cursorColor: Colors.green,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.7)
              ),
              controller: passwordFieldController,
              validator: (text){
                if(passwordFieldController.text.isEmpty){
                  return "Llenar Campo";
                }else{
                  return null;
                }
              },
              decoration: new InputDecoration(
                errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.4),
                      width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: TextStyle(
                    color: Colors.black
                ),
                prefixIcon: new Icon(
                  Icons.lock,
                  color: Colors.green,
                ),
                suffixIcon: InkWell(
                  child: new Icon(
                    showPassword ? Icons.remove_red_eye : Icons.visibility_off,
                    color: Colors.black.withOpacity(0.4),
                    size: 25,
                  ),
                  onTap: () {
                    setState(() {
                      if (showPassword) {
                        showPassword = false;
                      } else {
                        showPassword = true;
                      }
                    });
                  },
                ),
              ),
              obscureText: showPassword,
            ),
          )
        ],
      ),
    );
  }
  Widget nameInput() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            createTextLabel("Nombre"),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .84,
              color: Colors.transparent,
              child: new TextFormField(
                enabled: true,
                cursorColor: Colors.green,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.7)),
                controller: nameFieldController,
                validator: (text){
                  if(nameFieldController.text.isEmpty){
                    return "Llenar Campo";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: new InputDecoration(
                  errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.4), width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: new Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget confirmPasswordInput() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            createTextLabel('Confirmar Contraseña'),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .84,
              child: new TextFormField(
                cursorColor: Colors.green,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.7)
                ),
                controller: confirmPasswordFieldController,
                validator: (text){
                  if(confirmPasswordFieldController.text.isEmpty){
                    return "Llenar Campo";
                  }else if (confirmPasswordFieldController.text != passwordFieldController.text) {
                    return "Las contraseñas no coinciden";
                  }else{
                    return null;
                  }
                },
                decoration: new InputDecoration(
                  errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.4),
                        width: 1.0
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintStyle: TextStyle(
                      color: Colors.black
                  ),
                  prefixIcon: new Icon(
                    Icons.lock,
                    color: Colors.green,
                  ),
                  suffixIcon: InkWell(
                    child: new Icon(
                      showPassword ? Icons.remove_red_eye : Icons.visibility_off,
                      color: Colors.black.withOpacity(0.4),
                      size: 25,
                    ),
                    onTap: () {
                      setState(() {
                        if (showPassword) {
                          showPassword = false;
                        } else {
                          showPassword = true;
                        }
                      });
                    },
                  ),
                ),
                obscureText: showPassword,
              ),
            )
          ],
        ),
      );
    }
  Future _optionsPicture() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.camera_alt),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                            ),
                            Text('Tomar una foto'),
                          ],
                        )),
                    onTap: () {
                      getImage(true);
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  InkWell(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.photo),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                            ),
                            Text('Seleccionar de la galería'),
                          ],
                        )),
                    onTap: () {
                      getImage(false);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  void _submit() async {
    _form.currentState.validate();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          loadingContext = context;
          return LoadingAlertDismissible(
            text: "Cargando...",
          );
        });
    if(_form.currentState.validate() && _image!=null){
      user = new UserModel(
        email: emailFieldController.text,
        name: nameFieldController.text,
        password: passwordFieldController.text,
        photo: _image
      );
      UserProvider().registerUser(user).then((value){
        if(value != null){
          user.id = value;
          prefs.setString("user", userModelToJson(user));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CasesMap()), (route) => false);
        }else{
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  title: Text("Error"),
                  content: Text("Servicio en mantenimiento. Intente más tarde"),
                  actions: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Aceptar",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pop(loadingContext);
                      },
                    )
                  ],
                );
              });
        }
      });
    }else{
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              title: Text("Error"),
              content: Text("Todos los campos y la foto son obligatorios."),
              actions: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Aceptar",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pop(loadingContext);
                  },
                )
              ],
            );
          });
    }
  }
  Future getImage(bool isCamera) async {
    var image = await ImagePicker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      try {
        _image = base64Encode(image.readAsBytesSync());
      } catch (e) {
        print(e);
      }
    });
  }

}
