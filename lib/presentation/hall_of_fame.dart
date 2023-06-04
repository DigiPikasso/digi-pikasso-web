import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digi_pikasso/data.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
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
                return Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      scrollPhysics: BouncingScrollPhysics(),
                      viewportFraction: 0.5,
                      height: 44 * SizeConfig.heightMultiplier,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      autoPlayInterval: Duration(seconds: 8),
                      autoPlay: true,
                    ),
                    items: all.map((artist) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              margin:
                                  EdgeInsets.only(right: kDefaultPaddingSize),
                              child: ArtistCard(artist));
                        },
                      );
                    }).toList(),
                  ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // context.push('/${piece.id}');
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Hero(
              tag: artist.id,
              child: artist.imageAvailableLocally == false
                  ? Image.asset(
                      height: 25.74 * SizeConfig.heightMultiplier,
                      width: 35 * kMediumWidth,
                      "assets/persons/none.png",
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      height: 25.74 * SizeConfig.heightMultiplier,
                      width: 35 * kMediumWidth,
                      "assets/persons/${artist.id}.jpg",
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kSmallHeight),
              AutoSizeText(
                "${artist.firstName} ${artist.lastName}",
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Text("Born: ${artist.artistDateOfBirth}",
                  style: Theme.of(context).textTheme.bodyLarge),
              Text("Origin: ${artist.countryOfOrigin}",
                  style: Theme.of(context).textTheme.bodyLarge),
              AutoSizeText("Art Type: ${artist.mainArtType}",
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}

Future<List<Artist>> getArtists() async {
  final response = await http.get(Uri.parse(
      'https://container-service-2.urksr0dimjrfe.eu-west-1.cs.amazonlightsail.com/get-all-artists'));
  Iterable l = json.decode(response.body);

  List<Artist> artists =
      List<Artist>.from(l.map((model) => Artist.fromJson(model)));
  for (var element in artists) {
    var asset = await isLocalAsset("persons/${element.id}.jpg");
    if (asset) {
      element.imageAvailableLocally = true;
    }
  }
  return artists;
}

Future<bool> isLocalAsset(final String assetPath) async {
  final encoded =
      utf8.encoder.convert(Uri(path: Uri.encodeFull(assetPath)).path);
  final asset = await ServicesBinding.instance.defaultBinaryMessenger
      .send('flutter/assets', encoded.buffer.asByteData());
  return asset != null;
}
