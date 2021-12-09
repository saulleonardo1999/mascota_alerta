import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mascota_alerta/models/caseModel.dart';

class CaseProvider{
  final String _url = "https://mascotas-8060d.firebaseio.com";
  Future<bool> registerCase(CaseModel myCase) async {
    final url = "$_url/cases.json";
    try{
      final resp = await http.post(url, body: caseModelToJson(myCase));
      if(resp.statusCode == 200){
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }

  }
  Future <List<CaseModel>> getCases() async {
    final url = "$_url/cases.json";
    List<CaseModel> casesList = [];
    try{
      final resp = await http.get(url);
      final Map <String, dynamic> decodedData = json.decode(resp.body);
      if(resp.statusCode == 200 && decodedData != null){
        decodedData.forEach((caseID, tempCase) {
          final myCase = CaseModel.fromJson(tempCase);
          myCase.id = caseID;
          casesList.add(myCase);
        });
        return casesList;
      }else {
        return [];
      }
    }catch(e){
      return [];
    }
  }
}