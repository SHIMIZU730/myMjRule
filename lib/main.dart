import 'package:flutter/material.dart';
import 'package:flutter_app_mj/views/choiceRuleView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My麻雀ルール',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 5, 166, 18), // プライマリカラー
          onPrimary: Colors.white, // プライマリカラーの上にあるテキストやアイコンの色
          secondary: Color(0xFF76FF03), // セカンダリカラー
          onSecondary: Colors.black, // セカンダリカラーの上にあるテキストやアイコンの色
          error: Colors.red, // エラーカラー
          onError: Colors.white, // エラーカラーの上にあるテキストやアイコンの色
          background: Colors.white, // 背景色
          onBackground: Colors.black, // 背景色の上にあるテキストやアイコンの色
          surface: Colors.white, // カードやダイアログなどの表面色
          onSurface: Colors.black, // 表面色の上にあるテキストやアイコンの色
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'My麻雀ルール'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'My麻雀ルール',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 100),
            TextButton(
              child: const Text('Get Started'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ChoiceRule()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
