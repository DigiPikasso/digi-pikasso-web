import 'package:digi_pikasso/config/constants.dart';
import 'package:digi_pikasso/config/size_config.dart';
import 'package:digi_pikasso/data/models/artist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistDetail extends StatelessWidget {
  final Artist artist;
  const ArtistDetail(this.artist, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              artist.firstName,
              style: GoogleFonts.montserratTextTheme()
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            )
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Stack(
            children: [
              Hero(
                tag: artist.id,
                child: Image.network(
                  artist.artistImageLink ?? "/assets/persons/none.png",
                  height: 36.58 * SizeConfig.heightMultiplier,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: kMediumHeight * 3.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
