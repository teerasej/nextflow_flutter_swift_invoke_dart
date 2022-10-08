import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nextflow - Swift Invoke',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Nextflow - Swift Invoke'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _wordFromSwift = '';
  static const platform = MethodChannel('th.in.nextflow/hello');

  bool isSetMethodCall = false;

  @override
  Widget build(BuildContext context) {
    if (isSetMethodCall == false) {
      platform.setMethodCallHandler(swiftCallHandler);
      isSetMethodCall = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have to push the button...',
            ),
            Text('$_wordFromSwift'),
            ElevatedButton(
              onPressed: () async {
                platform.invokeMethod("sayHi");
              },
              child: const Text('Say Hi to Swift'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> swiftCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'swiftSayHi':
        setState(() {
          _wordFromSwift = methodCall.arguments.toString();
        });
        return;

      default:
        throw PlatformException(code: 'notimpl', message: 'not implemented');
    }
  }
}
