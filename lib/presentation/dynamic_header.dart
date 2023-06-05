import 'package:auto_size_text/auto_size_text.dart';
import 'package:digi_pikasso/config/constants.dart';
import 'package:digi_pikasso/config/size_config.dart';
import 'package:digi_pikasso/data/models/artist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  final Artist artist;
  MyDynamicHeader({required this.artist});

  @override
  double get maxExtent => 50.47 * SizeConfig.heightMultiplier;

  @override
  double get minExtent => 17.47 * SizeConfig.heightMultiplier;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      final double percentage =
          (constraints.maxHeight - minExtent) / (maxExtent - minExtent);
      return Container(
        height: constraints.maxHeight,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: artist.id,
                    child: Image.network(
                      height: 45.74 * SizeConfig.heightMultiplier,
                      width: 45 * kMediumWidth,
                      artist.artistImageLink ?? "/assets/persons/none.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // CircleAvatar(
                //   // maxRadius: 100,
                //   child: ClipOval(
                //     child: Image.network(

                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
              ),
            ),
            if (percentage > 0.45)
              Column(
                children: [
                  AutoSizeText(
                    "${artist.firstName} ${artist.lastName}",
                    style: GoogleFonts.corben(fontSize: 40 * percentage),
                  ),
                  SizedBox(height: 15 * percentage),
                  if (percentage > 0.60)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          color: Colors.black,
                          size: 25 * percentage,
                        ),
                        SizedBox(width: 15),
                        Text(
                          "My Artwork",
                          style: GoogleFonts.roboto(
                              fontSize: 20 * percentage,
                              color: CupertinoColors.activeBlue),
                        ),
                      ],
                    ),
                ],
              ),
            if (percentage < 0.45) SizedBox(height: 80 * percentage)
          ],
        ),
      );
      // return Container(
      //   decoration: BoxDecoration(
      //       boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.black45)],
      //       gradient: LinearGradient(colors: [Colors.blue, color])),
      //   height: constraints.maxHeight,
      //   child: SafeArea(
      //       child: Center(
      //     child: CircularProgressIndicator(
      //       value: percentage,
      //       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      //     ),
      //   )),
      // );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;
}
