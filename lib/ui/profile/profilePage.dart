import 'dart:convert';
import 'dart:typed_data';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascota_alerta/models/userModel.dart';
import 'package:mascota_alerta/provider/userProvider.dart';
import 'package:mascota_alerta/ui/widgets/loadingAlertDismissible.dart';
import 'package:mascota_alerta/ui/widgets/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController emailController;
  bool enableInput = false;
  BuildContext loadingContext;
  DateTime selectedDate = DateTime.now();
  Uint8List photo;
  SharedPreferences prefs;
  UserModel user;
  String _image;
  @override
  void initState() {
    initSharedPreferences();
    _formKey = new GlobalKey<FormState>();
    enableInput = false;
    nameController = new TextEditingController();
    emailController = new TextEditingController();

    super.initState();
  }
  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      user = UserModel.fromJson(jsonDecode(prefs.getString("user")));
      nameController.text = user.name;
      emailController.text = user.email;
      _image = user.photo;
      try{
        photo = base64Decode(user.photo);
      }catch(e){}
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget inputName = createInput(
        nameController,
        TextInputType.text,
            (value) =>
        nameController.text.length == 0 ? "Ingresa el nombre" : null,
        TextCapitalization.words,
        Icon(Icons.account_circle),
        null,
        enableInput,
        false);
    Widget inputEmail = createInput(
        emailController,
        TextInputType.emailAddress,
            (value) => emailController.text.length == 0
            ? "Ingresa el correo electrónico"
            : null,
        TextCapitalization.none,
        Icon(Icons.email),
        null,
        enableInput,
        false);
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        title: Text(
          "Perfil",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        elevation: 4.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),

        backgroundColor: Colors.green,
        actions: <Widget>[
          enableInput
              ?
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              enableInput = false;
              setState(() {});
            },
          )
              :
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              enableInput = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: prefs == null
              ? Container()
              :
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              FadeInLeft(
                delay: Duration(milliseconds: 250),
                child: Container(
                  width: MediaQuery.of(context).size.width * .84,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * .37,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            Center(
                              child: InkWell(
                                onTap: () {
                                  if(enableInput){
                                    _optionsPicture();
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.37,
                                  height: MediaQuery.of(context).size.width*0.37,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.green,
                                    //  shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    child: user.photo == null
                                        ?
                                    Icon(
                                      Icons.pets_outlined,
                                      color: Colors.black,
                                      size: MediaQuery.of(context).size.width*0.27,
                                    )
                                        : ClipOval(
                                      child: Image.memory(
                                        photo,
                                        fit: BoxFit.fill,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            enableInput
                                ? Center(
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 100,
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
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.black12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {
                                        _optionsPicture();
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .03,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .37,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                               user.name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                              user.email,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black38),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadeInLeft(
                delay: Duration(milliseconds: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                   children: [
                     SizedBox(height: 20.0),
                     createTextLabel('Nombre'),
                     SizedBox(height: 15.0),
                     inputName,
                     SizedBox(height: 20.0),
                     createTextLabel('Correo electrónico'),
                     SizedBox(height: 15.0),
                     inputEmail,
                     SizedBox(height: 50.0),
                   ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: enableInput ? FadeInDown(
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
                'Actualizar mis datos',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width*0.06,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ) : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


  Widget createTextLabel(String text) {
    return Container(
      width: MediaQuery.of(context).size.width * .84,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.w700,
            color: Colors.black.withOpacity(0.35)),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget createInput(
      TextEditingController controller,
      TextInputType keyboard,
      Function _validator,
      TextCapitalization capitalization,
      Icon icon,
      int maxLength,
      bool enableField,
      bool obscureText) {
    return Container(
        width: MediaQuery.of(context).size.width * .84,
        child: TextFormField(
            enabled: enableField,
            textCapitalization: capitalization,
            keyboardType: keyboard,
            controller: controller,
            maxLength: maxLength,
            validator: _validator,
            obscureText: obscureText,
            cursorColor: Colors.green,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.7)),
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.red, height: 0),
              prefixIcon: icon,
              filled: false,
              fillColor: Colors.transparent, //Color(0xffe3e3e3),
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black.withOpacity(0.4), width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black.withOpacity(0.4), width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
            )
        )
    );
  }

  Future _optionsPicture() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  child: Container(
                      width: MediaQuery.of(context).size.width * .65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * .1,
                              child: Icon(Icons.camera_alt)),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Text(
                              'Tomar una fotografía',
                              style: TextStyle(
                                  fontSize:
                                  MediaQuery.of(context).size.width * .04),
                            ),
                          ),
                        ],
                      )),
                  onTap: () {
                    getImage(true);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  child: Container(
                      width: MediaQuery.of(context).size.width * .65,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width * .1,
                                child: Icon(Icons.photo)),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .5,
                              child: Text(
                                'Seleccionar de la galería',
                                style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.width *
                                        .04),
                              ),
                            ),
                          ],
                        ),
                      )),
                  onTap: () {
                    getImage(false);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
  void _submit() async {
    _formKey.currentState.validate();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          loadingContext = context;
          return LoadingAlertDismissible(
            text: "Cargando...",
          );
        });
    if(_formKey.currentState.validate() && _image!=null){
      user.name = nameController.text;
      user.email = emailController.text;
      user.photo = _image;
      UserProvider().updateUserData(user).then((value){
        if(value){
          prefs.setString("user", userModelToJson(user));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProfilePage()), (route) => false);
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
              content: Text("Todos los campos son obligatorios"),
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
        setState(() {
          _image = base64Encode(image.readAsBytesSync());
          photo = base64Decode(_image);
        });
      } catch (e) {}
    });
  }

}