import 'package:flutter/material.dart';

class NoContentMessage extends StatefulWidget {
  final String message;

  const NoContentMessage({Key key, this.message}) : super(key: key);

  @override
  _NoContentMessageState createState() =>
      _NoContentMessageState();
}

class _NoContentMessageState extends State<NoContentMessage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error, size: 65, color: Color(0xFFAFAFAF)),
            SizedBox(height: 10,),
            Text( widget.message, style: TextStyle(color: Color(0xFFAFAFAF), fontSize: 17, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}