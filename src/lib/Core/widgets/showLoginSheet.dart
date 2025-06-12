import 'package:eventk/Core/widgets/LoginRequiredButtonSheet.dart';
import 'package:flutter/material.dart';

void showLoginSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) =>  LoginRequiredButtonSheet (),
  );
}