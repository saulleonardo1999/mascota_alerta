import 'package:flutter/material.dart';

class LoadingAlertDismissible extends StatefulWidget {
  final String text;
  LoadingAlertDismissible({Key key, this.text}) : super(key: key);
  @override
  _LoadingAlertDismissibleState createState() =>
      _LoadingAlertDismissibleState();
}

class _LoadingAlertDismissibleState extends State<LoadingAlertDismissible> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          SizedBox(
            width: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: new Text(
              widget.text,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .05),
            ),
          ),
        ],
      ),
    );
  }
}