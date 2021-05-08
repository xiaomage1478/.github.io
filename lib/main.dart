import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '组合生成器'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController _targetController = TextEditingController();
  TextEditingController _numController = TextEditingController(text: '6');

  void _incrementCounter() {
    setState(() {
      var tartgets =
          _targetController.text.split(',').map((e) => int.parse(e)).toList();
      arr.clear();
      xrt.clear();
      arr = tartgets;
      combine_increase(tartgets, 0, rt, int.parse(_numController.text),
          int.parse(_numController.text), arr.length);
      print(xrt);
      _counter++;
    });
  }

  List<List<int>> xrt = [];
  combine_increase(List<int> iArr, int start, List<int> rt, int count, int NUM,
      int arr_len) {
    // 从有arr_len个元素的数组中抽取NUM个元素的组合所有可能
    var i = 0;
    for (var i = start; i < arr_len + 1 - count; i++) {
      rt[count - 1] = i;
      if (count - 1 == 0) {
        List<int> tmp = [];
        for (var j = NUM - 1; j >= 0; j--) {
          tmp.add(arr[rt[j]]);
        }
        xrt.add(tmp);
      } else {
        combine_increase(iArr, i + 1, rt, count - 1, NUM, arr_len);
      }
    }
  }

  var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var rt = List<int>(10);

  String getString() {
    String show = '';
    xrt.forEach((element) {
      String elementString = '';
      element.forEach((e) {
        elementString += e.toString();
        elementString += ',';
      });
      show += elementString;
      show += '\n';
    });
    return show;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('一共有组合数：' + xrt.length.toString()),
            TextField(
                decoration: InputDecoration(labelText: '请输入目标序号，多个序号间用，分割'),
                controller: _targetController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9\,]'))
                ]),
            TextField(
              decoration: InputDecoration(labelText: '请输入组合的数量'),
              controller: _numController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              ],
            ),
            Expanded(
              child: ListView(
                children: xrt.map((e) {
                  String show = '';
                  e.forEach((element) {
                    show += element.toString();
                    show += ',';
                  });
                  return Center(child: Text(show));
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Text('生成'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
