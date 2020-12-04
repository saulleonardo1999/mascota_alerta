import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:mascota_alerta/models/userModel.dart';
import 'package:mascota_alerta/provider/userProvider.dart';
import 'package:mascota_alerta/ui/cases/casesMap.dart';
import 'package:mascota_alerta/ui/widgets/loadingAlertDismissible.dart';
import 'package:mascota_alerta/ui/widgets/menu.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailFieldController;
  TextEditingController passwordFieldController;
  bool showPassword;
  UserModel user;
  BuildContext loadingContext;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  void initState() {
    emailFieldController = new TextEditingController();
    emailFieldController.clear();
    passwordFieldController = new TextEditingController();
    passwordFieldController.clear();
    showPassword = true;
    super.initState();
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
          "Inicio de Sesión"
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _form,
            child: Column(
              children: [
                SizedBox(height: 30,),
                FadeInLeft(
                  delay: Duration(milliseconds: 150),
                    child: emailInput()
                ),
                SizedBox(height: 30,),
                FadeInRight(
                  delay: Duration(milliseconds: 300),
                    child: passwordInput()
                )
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
                  return "Introduce tu correo";
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
              validator: (text){
                if(passwordFieldController.text.isEmpty){
                  return "Introduce la contraseña";
                }else{
                  return null;
                }
              },
              cursorColor: Colors.green,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.7)
              ),
              controller: passwordFieldController,
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
    if(_form.currentState.validate()){
      UserProvider().loginRequest(emailFieldController.text, passwordFieldController.text).then((value){
        if(value){
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
                  title: Text("Atención"),
                  content: Text("No se hallaron registros de estas credenciales."),
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
              content: Text("Introduzca correo y contraseña."),
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

}
