import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/widgets/navigationHome.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/loginPage.dart';
import 'package:eventk/Features/InitialScreens/Presentation/Views/widgets/onBoarding1.dart';
import 'package:eventk/Features/Splash/Presentation/Views/splashScreen.dart';
import 'package:flutter/material.dart';
class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 4));

    bool showHome = getIt<CacheHelper>().getData(key: 'showHome') ?? false;
    bool isLoggedIn = getIt<CacheHelper>().getData(key: 'isLoggedIn') ?? false;

    if (!showHome) {
      await getIt<CacheHelper>().saveData(key: 'showHome', value: true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Onboarding1()),
      );
    } else if (isLoggedIn) {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationHomePage()),
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
