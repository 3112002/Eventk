
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart'; 

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.2, 0), 
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      navigateUser();
    });
  }
void navigateUser() async {
  final token = await CacheHelper().getDataString(key: 'token');
  final isSkipped = await CacheHelper().getDataBool(key: 'showSkip');

  if (token != null && token.isNotEmpty) {
    Navigator.pushReplacementNamed(context, '/home');
  } else if (isSkipped == true) {
   
    Navigator.pushReplacementNamed(context, 'NavigationHomePage');
   Navigator.pushReplacementNamed(context, 'LoginPage');
  } else {
    Navigator.pushReplacementNamed(context, 'LoginPage');
  }
}
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      body: Center(
        child: Stack(
          children: [
            SlideTransition(
              position: _positionAnimation,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/Images/logo_E.png',
                  width: 300.w,
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Transform.translate(
                      offset: Offset(0.3.w, 0),
                      child: Image.asset(
                        'assets/Images/ventk.png',
                        width: 300.w,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
