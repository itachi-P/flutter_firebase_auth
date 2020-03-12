import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  String _result = "初期表示";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("次の画面へ"),
              onPressed: () async {
                String result = await Navigator.of(context).push(
                  MaterialPageRoute<String>(
                    builder: (context) => NextPage(),
                  ),
                );
                setState(() => _result = result);
              },
            ),
            Text(_result)
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop("戻るアイコンからの遷移");
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("NextPage"),
        ),
        body: Center(
          child: RaisedButton(
            child: Text("戻る"),
            onPressed: () => Navigator.of(context).pop("戻るボタンからの遷移"),
          ),
        ),
      ),
    );
  }
}
