import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  NextPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String inputMessage;

  @override
  void initState() {
    inputMessage = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 元のページでpushに渡された値を取り出す
    final args = ModalRoute.of(context).settings.arguments;
    print(args);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 50.0,
                ),
                child: TextField(
                  onChanged: (value) {
                    inputMessage = value;
                  },
                  onEditingComplete: () {
                    Navigator.of(context).pop(inputMessage);
                  },
                  autofocus: true,
                  autocorrect: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
