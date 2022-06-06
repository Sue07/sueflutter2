import 'package:flutter/material.dart';

// void main() => runApp(new MyApp() ; new hougong());

void main() {
  return runApp (new MyApp() ) ;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '欢迎来到我的空间',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Sue',
          style: TextStyle(
    color: Color.fromARGB(255, 96, 103, 109),
    fontSize: 18.0,
    height: 1.2,  
    fontFamily: "Courier",
    background: Paint()..color=Color.fromARGB(255, 251, 251, 248),
    decoration:TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dashed
  ),),
        ),
        body: new Center(
          child: new Text("Hello！ "*6,  //字符串重复六次
  textAlign: TextAlign.center,style: TextStyle(
    color: Color.fromARGB(255, 4, 52, 94),
    fontSize: 30.0,
    height: 2,  
    fontFamily: "Courier",
    background: Paint()..color=Color.fromARGB(255, 126, 200, 246),
    decoration:TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dashed
  )),
        ),
      ),
    );
  }
}



