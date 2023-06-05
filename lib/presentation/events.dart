import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digi_pikasso/config/constants.dart';
import 'package:digi_pikasso/config/size_config.dart';
import 'package:digi_pikasso/data.dart';
import 'package:digi_pikasso/data/models/Art.dart';
import 'package:digi_pikasso/presentation/small_entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Events extends StatefulWidget {
  Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
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
                    image: AssetImage("assets/image2.jpg"),
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
                  'Exhibitions',
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
          ListView.separated(
            shrinkWrap: true,
            itemCount: 2,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return ListTile(
                  title: Text('Venue: The Sweet Side of Thingz'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: 9 Nov - 15 Nov 2023'),
                      Text('Contact: 061 242 222'),
                    ],
                  ),
                );
              }
              return ListTile(
                title: Text('Venue: 40 Tal Street'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date: 18 Nov - 20 Nov 2023'),
                    Text('Contact: 061 242 222'),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildIt(String loc, List<Art> arts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: kMediumHeight),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                loc,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(letterSpacing: 0.41, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: kMediumHeight * 3),
        Container(
          child: CarouselSlider(
            options: CarouselOptions(
              scrollPhysics: BouncingScrollPhysics(),
              viewportFraction: 0.5,
              height: 34 * SizeConfig.heightMultiplier,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: Duration(seconds: 2),
              autoPlayInterval: Duration(seconds: 8),
              autoPlay: true,
            ),
            items: arts.map((piece) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.only(right: kDefaultPaddingSize),
                    child: SmallPieceEntry(piece),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

Future<Map<String, List<Art>>> getArts() async {
  final response = await http.get(Uri.parse(
      'https://container-service-2.urksr0dimjrfe.eu-west-1.cs.amazonlightsail.com/get-all-art/'));
  Iterable l = json.decode(response.body);

  List<Art> arts = List<Art>.from(l.map((model) => Art.fromJson(model)));
  return sortArtsByLocation(arts);
}

Map<String, List<Art>> sortArtsByLocation(List<Art> arts) {
  Map<String, List<Art>> sorted = {};
  for (var art in arts) {
    if (sorted[art.location.name] == null) {
      sorted[art.location.name] = new List.empty(growable: true);
    }
    sorted[art.location.name]?.add(art);
  }
  return sorted;
}
