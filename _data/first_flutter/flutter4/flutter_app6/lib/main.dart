import 'dart:convert';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '导航演示1',
      home: new MyAppHome(),
    );
  }
}

class MyAppHome extends StatefulWidget {
  @override
  MyAppHomeState createState() => MyAppHomeState();
}

class MyAppHomeState extends State<MyAppHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Go"),
          onPressed: () {
            loadData();
          },
        ),
      ),
    );
  }

  late List messages;
  loadData() async {
    // 当前线程的信息的接收者
    ReceivePort receivePort = new ReceivePort();
    /**
     * 创建并生成与当前隔离共享相同代码的隔离。
     * Isolate.spawn 接受的方法必须是静态的或是一个顶层函数
     * 传递当前接收者receivePort.sendPort给其他线程，那么其他线程就可以通过它，与当前线程通信
     *
     */
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    SendPort sendPort = await receivePort.first;
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    /// 向其他线程发送消息
    List msg = await sendReceive(sendPort,dataURL);
    setState(() {
      /// 更新UI，setState会触发build的执行
      messages = msg;
      print(messages[0]["title"]);
    });
  }

  static dataLoader(SendPort sendPort) async{
    /// 其他线程的消息接收者
    ReceivePort receivePort = new ReceivePort();
    /// 通知其他isolate,当前isolate监听的端口
    sendPort.send(receivePort.sendPort);
    await for(var msg in receivePort){
      String data = msg[0]; // 获取URL
      SendPort replyTo = msg[1]; // 回传消息用的
      String dataURL = data;
      /// 进行网络请求
      Response response = await Dio().get(dataURL);
      /// 将结果回传回去
      replyTo.send(jsonDecode(response.toString()));
    }
  }

  /// 向其他线程发送消息
  Future sendReceive(SendPort port,msg){
    /// 当前线程的接收者
    ReceivePort receivePort =  new ReceivePort();
    /// 向其他线程发送消息
    port.send([msg,receivePort.sendPort]);
    return receivePort.first;
  }

}

