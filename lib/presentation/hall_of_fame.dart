import 'dart:convert';
import 'dart:ui';
import 'package:digi_pikasso/data.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:digi_pikasso/config/constants.dart';
import 'package:digi_pikasso/config/size_config.dart';
import 'package:digi_pikasso/data/models/artist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HallOfFame extends StatefulWidget {
  HallOfFame({super.key});

  @override
  State<HallOfFame> createState() => _HallOfFameState();
}

class _HallOfFameState extends State<HallOfFame> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 35.58 * SizeConfig.heightMultiplier,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/hall.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.black45,
                        Colors.black45,
                      ]),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        spreadRadius: -1,
                        blurRadius: 30,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                child: Text(
                  'Wall of Artists',
                  style:
                      GoogleFonts.montserratTextTheme().displayLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                ),
              )
            ],
          ),
          SizedBox(height: kMediumHeight * 3),
          FutureBuilder(
              future: getArtists(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                }
                var all = snapshot.data!;
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(all.length, (index) {
                    return Container(
                        margin: EdgeInsets.only(
                          left: index % 2 != 0 ? 0 : kDefaultPaddingSize,
                        ),
                        child: ArtistCard(all[index]));
                  }),
                );
              })),
        ],
      ),
    );
  }
}

class ArtistCard extends StatelessWidget {
  final Artist artist;
  const ArtistCard(this.artist, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            child: Image.asset(
              height: 25.74 * SizeConfig.heightMultiplier,
              width: 24 * kMediumWidth,
              "assets/woman.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: -SizeConfig.heightMultiplier,
            child: Container(
              padding: EdgeInsets.all(5),
              width: 24 * kMediumWidth,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .appBarTheme
                    .backgroundColor!
                    .withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kSmallHeight),
                  AutoSizeText(
                    "${artist.firstName} ${artist.lastName}",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  Text(
                    "Born: ${artist.artistDateOfBirth}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    "Origin: ${artist.countryOfOrigin}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                  AutoSizeText(
                    "Art Type: ${artist.mainArtType}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<Artist>> getArtists() async {
  // final response = await http.get(Uri.parse(
  //     'https://container-service-2.urksr0dimjrfe.eu-west-1.cs.amazonlightsail.com/get-all-artists'));
  // Iterable l = json.decode(response.body);
  Iterable l = json.decode(allArtists);

  List<Artist> artists =
      List<Artist>.from(l.map((model) => Artist.fromJson(model)));
  return artists;
}
