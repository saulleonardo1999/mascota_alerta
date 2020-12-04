
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mascota_alerta/models/caseModel.dart';
import 'package:mascota_alerta/provider/caseProvider.dart';
import 'package:mascota_alerta/ui/cases/caseCard.dart';
import 'package:mascota_alerta/ui/widgets/menu.dart';
import 'package:mascota_alerta/ui/widgets/noContentMessage.dart';

class LostPetsPage extends StatefulWidget {
  @override
  _LostPetsPageState createState() => _LostPetsPageState();
}

class _LostPetsPageState extends State<LostPetsPage> {
  List<CaseModel> myCases;
  bool loading;
  @override
  void initState() {
    myCases = new List();
    loading = true;
    CaseProvider().getCases().then((value){
      myCases = value;
      loading = false;
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              "Mascotas Perdidas"
          ),
        ),
        drawer: MenuWidget(),
        body: loading ?
        Center(
          child: CircularProgressIndicator(
            valueColor:
            new AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ):
        myCases.isNotEmpty ?
        ListView.builder(
            itemCount: myCases.length,
            itemBuilder: (context, index){
              return myCases[index].caseType == 2 ?
              CaseCard(
                myCase: myCases[index],
              ) : Container();
            }
        ): NoContentMessage(message: "No hay registros de perdidos",)
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
