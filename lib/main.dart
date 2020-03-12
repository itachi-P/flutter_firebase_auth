import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(title: 'Navigator / async & await Demo'),
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
