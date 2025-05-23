import 'package:eventk/Core/widgets/navigationHome.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/categoriesDetaliesBody.dart';
import 'package:flutter/material.dart';

/*Yara❤️*/
class CategoreDeatlis extends StatelessWidget {
  const CategoreDeatlis({super.key});
  static String id = ' CategoreDeatlis';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigationHomePage(),
                    ));
              },
              icon: Icon(Icons.close)),
        ]),
      ),
      body: Categoriesdetaliesbody(),
    );
  }
}
