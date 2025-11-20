import 'package:flutter/material.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({Key? key}) : super(key: key);


  Widget verticalSpace(double height) {
    return SizedBox(height: height);
  }


  Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }


  TextStyle? bodyText1(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge;
  }


  Color? primaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }



  void showSnackBar(String message, BuildContext context, {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
        backgroundColor ?? Theme.of(context).snackBarTheme.backgroundColor,
      ),
    );
  }



  @override
  Widget build(BuildContext context); // Bắt buộc các lớp con phải implement
}