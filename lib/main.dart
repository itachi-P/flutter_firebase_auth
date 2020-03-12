import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'second_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildContents(
                  [
                    Text('Pattern 1'),
                    RaisedButton(
                      child: Text('ただ次画面に行って戻るだけ'),
                      onPressed: () {
                        Navigator.of(context).push(
                          // MaterialDesignではなくiOS風のアニメーションで遷移
                          CupertinoPageRoute(
                            builder: (context) {
                              return SecondPage();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                _buildContents(
                  [
                    Text('Pattern 2'),
                    RaisedButton(
                      child: Text('行って戻った直後にダイアログを表示する'),
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return SecondPage();
                            },
                          ),
                        );
                        // ここは async-await で次画面遷移した先から戻る遷移の直後に実行される
                        showDialog(
                          context: context,
                          builder: (context) => SampleDialog(),
                        );
                      },
                    ),
                  ],
                ),
                _buildContents(
                  [
                    Text('Pattern 3'),
                    RaisedButton(
                      child: Text('遷移後入力した内容を戻った直後ダイアログ表示'),
                      onPressed: () async {
                        // 遷移後の画面でpopの引数に持たせた値を受け取る
                        final String result = await Navigator.of(context).push(
                          MaterialPageRoute<String>(
                            builder: (context) {
                              return SecondTextInputPage();
                            },
                          ),
                        );
                        if (result != null) {
                          final contentText = 'I received ' + result + ' !';
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SampleDialog(
                                contentText: contentText,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildContents(List<Widget> children) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 40.0),
    child: Column(
      children: children,
    ),
  );
}

class SampleDialog extends StatelessWidget {
  const SampleDialog({Key key, this.contentText}) : super(key: key);

  final String contentText;

  @override
  Widget build(BuildContext context) {
    final content = contentText ?? 'I\'m back!'; // ?? - null判定（if null then...)
    // 上記はあくまでもfinalであるcontentの初期化にcontentTextか、それがnullの場合リテラル代入
    // ??=を使うと左辺がnullの場合に同じくfinalであるcontentTextへの代入になるのでエラー

    return AlertDialog(
      title: Text(
        'Alert',
        style: Theme.of(context).textTheme.title,
      ),
      content: Text(
        content,
        maxLines: 2,
        style: Theme.of(context).textTheme.body2,
      ),
    );
  }
}
