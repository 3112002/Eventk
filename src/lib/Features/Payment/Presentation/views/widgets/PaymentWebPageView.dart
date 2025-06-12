import 'dart:async';

import 'package:eventk/Core/widgets/navigationHome.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Paymentwebpageview extends StatefulWidget {
  final String paymentUrl;
  const Paymentwebpageview({super.key, required this.paymentUrl});

  @override
  State<Paymentwebpageview> createState() => _PaymentwebpageviewState();
}

class _PaymentwebpageviewState extends State<Paymentwebpageview> {
  late final WebViewController _controller;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(minutes: 12), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        NavigationHomePage.id,
        (route) => false,
      );
    });
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            String pageContent = await _controller.runJavaScriptReturningResult(
              "document.body.innerText",
            ) as String;
            if (pageContent.contains("Approved")) {
              if (mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complete Payment',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: kButtonsColor,
        elevation: 6,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
