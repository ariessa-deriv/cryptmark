import 'package:cryptmark/cryptmark_model.dart';
import 'package:cryptmark/cryptmark_service.dart';
import 'package:flutter/material.dart';
import 'cryptmark_model.dart';
import 'package:cryptmark/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cryptmark',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const MyHomePage(title: 'Cryptmark'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future <void> fetchAPi () async {
    CryptmarkService cryptmarkService = CryptmarkService();
    try {
      CryptmarkModel cryptmarkModel =
          await cryptmarkService.fetchCryptMarkInformation();
      print(cryptmarkModel.runtimeType);
    }

    catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchAPi,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
