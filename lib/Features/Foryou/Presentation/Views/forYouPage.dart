import 'package:eventk/Features/Foryou/Presentation/Views/Widgets/forYoudetales.dart';
import 'package:flutter/material.dart';

/*Yara❤️*/
import 'package:eventk/Core/widgets/CustomAppBar.dart';

class ForYouPage extends StatelessWidget {
  static String id = 'ForYouPage';
  const ForYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Events Specially Curated For You"),
      body: ForYouPageDetalies(),
    );
  }
}
