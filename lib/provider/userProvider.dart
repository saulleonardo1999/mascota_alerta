import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mascota_alerta/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider{
  final String _url = "https://mascotas-8060d.firebaseio.com";
  Future registerUser(UserModel user) async {
    final url = "$_url/users.json";
    try{
      final resp = await http.post(url, body: userModelToJson(user));

      final decodedData = json.decode(resp.body);
      print(decodedData['name']);
      print(resp.statusCode);
      if(resp.statusCode == 200){
        return decodedData['name'];
      }else{
        return null;
      }
    }catch(e){
      return null;
    }

  }
  Future <bool> loginRequest(String email, String password) async {
    bool auth = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = "$_url/users.json";
    try{
      final resp = await http.get(url);
      final Map <String, dynamic> decodedData = json.decode(resp.body);
      if(resp.statusCode == 200 && decodedData != null){
        decodedData.forEach((idUser, tempUser) {
          final myUser = UserModel.fromJson(tempUser);
          myUser.id = idUser;
          if(myUser.email == email && myUser.password == password){
            prefs.setString("user", userModelToJson(myUser));
            auth = true;
          }
        });
        return auth;
      }else {
        return false;
      }
    }catch(e){
      return false;
    }
  }

  Future<bool> updateUserData(UserModel user) async {
    final url = "$_url/users/${user.id}.json";
    try{
      final resp = await http.put(url, body: userModelToJson(user));
      if(resp.statusCode == 200){
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }

  }
}