
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mascota_alerta/models/caseModel.dart';
import 'package:mascota_alerta/provider/caseProvider.dart';
import 'package:mascota_alerta/ui/cases/caseCard.dart';
import 'package:mascota_alerta/ui/widgets/menu.dart';
import 'package:mascota_alerta/ui/widgets/noContentMessage.dart';

class RescuePetsPage extends StatefulWidget {
  @override
  _RescuePetsPageState createState() => _RescuePetsPageState();
}

class _RescuePetsPageState extends State<RescuePetsPage> {
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
              "Rescate de mascotas"
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
              return myCases[index].caseType == 1 ?
              FadeInLeft(
                  delay: Duration(milliseconds: 300*index),
                  child: CaseCard(
                    myCase: myCases[index],
                  )
              ) : Container();
            }
        ): NoContentMessage(message: "No hay registros de rescate",)
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
