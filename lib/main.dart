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
                      child: Text('Next'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
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
                      child: Text('Next'),
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return SecondPage();
                            },
                          ),
                        );
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
                      child: Text('Next'),
                      onPressed: () async {
                        final result = await Navigator.of(context).push(
                          MaterialPageRoute(
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
    final content = contentText ?? 'I\'m back!';
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
