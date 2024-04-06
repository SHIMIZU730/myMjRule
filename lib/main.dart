import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_mj/common/constants.dart';
import 'package:flutter_app_mj/views/choiceRuleView.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:floating_bubbles/floating_bubbles.dart';
import 'theme.dart';

void main() {
  // Initialize admob
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: lightMode,
      darkTheme: darkMode,
      home: const MyHomePage(title: appName),
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
      body: Stack(children: [
        Positioned.fill(
            child: Container(
          color: Colors.white,
        )),
        Positioned.fill(
            child: FloatingBubbles.alwaysRepeating(
          noOfBubbles: 50,
          colorsOfBubbles: const [
            Color.fromARGB(255, 5, 166, 18),
            Color.fromARGB(255, 102, 222, 176),
          ],
          sizeFactor: 0.2,
          opacity: 70,
          speed: BubbleSpeed.slow,
          paintingStyle: PaintingStyle.fill,
          shape: BubbleShape.circle,
        )),
        Positioned(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  appName,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor, // ボタンの背景色
                    foregroundColor: Colors.white, // ボタンの前景色
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // ボタンの角の丸みを設定
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20), // パディングを調整
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      whiteOut(ChoiceRule()),
                    );
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  // PageRouteBuilder<Object?> flipTransition(Widget screen) {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => screen,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       return AnimatedBuilder(
  //         animation: animation,
  //         builder: (context, child) {
  //           final flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
  //             CurvedAnimation(parent: animation, curve: Curves.linear),
  //           );
  //           return Transform(
  //             transform: Matrix4.identity()
  //               ..setEntry(3, 2, 0.001)
  //               ..rotateY(2 * 3.14 * flipAnimation.value),
  //             alignment: Alignment.center,
  //             child: child,
  //           );
  //         },
  //         child: child,
  //       );
  //     },
  //   );
  // }

  PageRouteBuilder<Object?> whiteOut(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: const Duration(seconds: 1),
      reverseTransitionDuration: const Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final color = ColorTween(
          begin: Colors.transparent,
          end: Colors.white,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0, 0.5, curve: Curves.easeInOut),
          ),
        );
        final opacity = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.5, 1, curve: Curves.easeInOut),
          ),
        );
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Container(
              color: color.value,
              child: Opacity(
                opacity: opacity.value,
                child: child,
              ),
            );
          },
          child: child,
        );
      },
    );
  }
}
