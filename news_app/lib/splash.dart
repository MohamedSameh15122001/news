import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout.dart';

import 'package:splash_view/source/presentation/pages/splash_view.dart';
import 'package:splash_view/source/presentation/widgets/done.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.cyan[100],
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return SplashView(
      // logo: const FlutterLogo(),
      loadingIndicator: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 100),
          child: Center(
              child: LinearProgressIndicator(
            color: Colors.cyan,
          ))),
      backgroundColor: Colors.cyan[100],
      bottomLoading: false,
      showStatusBar: true,
      title: Image.asset(
        'lib/assets/news.png',
        width: 100,
        height: 100,
      ),

      // gradient: const LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: <Color>[Colors.green, Colors.blue]),
      done: Done(
        const Layout(),
        animationDuration: const Duration(seconds: 2),
        // curve: Curves.easeInOut,
      ),
    );
  }
}
