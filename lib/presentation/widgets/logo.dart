import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  bool? small = false;

  AppLogo({this.small, super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo.svg',
      width: small != null ? 48.0 : 72.0,
      height: small != null ? 48.0 : 72.0,
    );
  }
}
