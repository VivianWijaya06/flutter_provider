import 'package:flutter/material.dart';

void main() => runApp(MyEphemeralApp());

class MyEphemeralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Ephemeral State Example')),
        body: CounterWidget(),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter Value: $_counter'),
          SizedBox(height: 10),
          ElevatedButton(onPressed: _increment, child: Text('Increment')),
          ElevatedButton(onPressed: _decrement, child: Text('Decrement')),
        ],
      ),
    );
  }
}
