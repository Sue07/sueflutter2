
import 'package:flutter/material.dart';

void main(){
    runApp(
      MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: Text("radioButton"),
              ),
            body: _myapp(),
          ),
      )
    );
}

class _myapp extends StatefulWidget {
  @override
  _myappState createState() => _myappState();
}

class _myappState extends State<_myapp> {
  List sampleData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(false, 'A', ));
    sampleData.add(new RadioModel(false, 'B', ));
    sampleData.add(new RadioModel(false, 'C', ));
    sampleData.add(new RadioModel(false, 'D', ));
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children:List<Widget>.generate(sampleData.length, (index){
          return InkWell(
              child: _buttonstyle(sampleData[index]),
              onTap: (){
                setState(() {
                  sampleData.forEach((element) => element.isSelected = false);
                  print(sampleData[index].buttonText);
                  sampleData[index].isSelected = true;
                });
              },
          );
      }
          ),
    );
  }
  Widget _buttonstyle(sampleData) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Stack(
        children: [
          Container(
            height: 20,
            width: 30,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(width: 1,color: sampleData.isSelected? Colors.blue:Colors.grey),
            ),
          ),
          Container(
            height: 20,
            width: 30,
            child: Center(child: Text("${sampleData.buttonText}")),
          ),
        ],
      ),
    );
  }
}

// 按钮样式


class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText,);
}
