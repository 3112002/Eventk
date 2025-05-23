import 'package:eventk/Features/InitialScreens/Presentation/Views/widgets/onBoarding1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
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
      begin: const Offset(0, 0),
      end: Offset(-0.23.w, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );
    _controller.forward();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool showHome = prefs.getBool('showHome') ?? false;
      final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      await Future.delayed(const Duration(seconds: 2));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => isLoggedIn
              ? OnBoardingPage1()
              : (showHome ? const OnBoardingPage1() : const OnBoardingPage1()),
        ),
      );

      if (!showHome) {
        prefs.setBool('showHome', true);
      }
    } catch (e) {
      debugPrint('Error navigating: $e');
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
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: 1,
                  child: Transform.translate(
                    offset: _positionAnimation.value *
                        MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/Images/logo_E.png',
                        width: 300.w,
                      ),
                    ),
                  ),
                );
              },
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
