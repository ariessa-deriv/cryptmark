import 'package:cryptmark/cryptmark_model.dart';
import 'package:cryptmark/cryptmark_service.dart';
import 'package:cryptmark/pages/coin_detail_page.dart';
import 'package:cryptmark/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:cryptmark/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
      home: WatchlistPage(),
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

  Future<void> fetchAPi() async {
    CryptmarkService cryptmarkService = CryptmarkService();
    try {
      CryptmarkModel cryptmarkModel =
          await cryptmarkService.fetchCryptMarkInformation();
      print(cryptmarkModel.runtimeType);
    } catch (error) {
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
        child: Column(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchAPi,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
