import 'package:flutter/material.dart';
import 'package:flutter_app_mj/main.dart';

// Back to Top Page
void navigateToTop(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    // MaterialPageRoute(builder: (context) => MyApp()),
    // ModalRoute.withName("/"),
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const MyApp(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
    ModalRoute.withName('/'),
  );
}
