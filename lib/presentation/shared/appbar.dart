import 'package:digi_pikasso/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar getAppbar(BuildContext context) {
  return AppBar(
    // automaticallyImplyLeading: false,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/header-logo.svg",
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 3.55 * SizeConfig.widthMultiplier,
        ),
        Text(
          "DigiPikasso",
          style: GoogleFonts.pacificoTextTheme()
              .headlineSmall!
              .copyWith(color: Colors.white),
        )
      ],
    ),
  );
}
