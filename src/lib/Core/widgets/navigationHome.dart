import 'package:eventk/Core/utils/AuthProvider.dart';
import 'package:eventk/Core/widgets/SignInRequiredPage.dart';
import 'package:eventk/Features/Profille/Presentation/Views/profilePage.dart';
import 'package:eventk/constants.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/interetedPage.dart';
import 'package:eventk/Features/Foryou/Presentation/Views/forYouPage.dart';
import 'package:eventk/Features/Home/Presentation/Views/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:provider/provider.dart';

/* Yara Adel*/
class NavigationHomePage extends StatefulWidget {
  @override
  State<NavigationHomePage> createState() => _HomePageState();
  static String id = 'NavigationHomePage';
}

class _HomePageState extends State<NavigationHomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    FavouritesPage(),
    ForYouPage(),
    ProfilePage(),
  ];
  final navigationBarItems = [
    SalomonBottomBarItem(
        icon: Icon(LineIcons.home),
        title: Text(
          'Home',
        ),
        selectedColor: Colors.blueAccent),
    SalomonBottomBarItem(
        icon: Icon(LineIcons.star),
        title: Text(
          'Intersted',
        ),
        selectedColor: Color(0xffC9379D)),
    SalomonBottomBarItem(
        icon: const Icon(LineIcons.magic),
        title: Text(
          'For you',
        ),
        selectedColor: Color(0xFFE6A919)),
    SalomonBottomBarItem(
        icon: const Icon(
          LineIcons.userCircle,
          size: 30,
        ),
        title: Text(
          'Profile',
        ),
        selectedColor: Colors.purple),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<Authprovider>(
      builder: (context, authProvider, _) {
        final List<Widget> pages = [
          HomePage(),
          authProvider.isLoggedIn
              ? const FavouritesPage()
              : const Signinrequiredpage(
                  message:
                      'Interested events will show up here. Sign in to access them.',
                  title: "Events that You're Interested In",
                ),
          authProvider.isLoggedIn
              ? const ForYouPage()
              : const Signinrequiredpage(
                  message:
                      'Pick your interests and get personalized event recommendations.',
                  title: 'Events Specially Curated For You',
                ),
          const ProfilePage(),
        ];

        return Scaffold(
          bottomNavigationBar: Container(
            child: Card(
              elevation: MediaQuery.of(context).size.width < 600 ? 2 : 16,
              child: SizedBox(
                height: 70.h,
                child: SalomonBottomBar(
                  backgroundColor: kPrimaryColor,
                  currentIndex: currentIndex,
                  items: navigationBarItems,
                  onTap: (index) => setState(() {
                    currentIndex = index;
                  }),
                ),
              ),
            ),
          ),
          backgroundColor: kPrimaryColor,
          body: pages[currentIndex],
        );
      },
    );
  }
}
