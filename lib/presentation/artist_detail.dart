import 'package:digi_pikasso/config/constants.dart';
import 'package:digi_pikasso/data/models/artist.dart';
import 'package:digi_pikasso/presentation/dynamic_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArtistDetail extends StatelessWidget {
  final Artist artist;
  const ArtistDetail(this.artist, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(),
        SliverPersistentHeader(
          pinned: true,
          delegate: MyDynamicHeader(artist: artist),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(
                left: kDefaultPaddingSize,
                right: kDefaultPaddingSize,
                bottom: kDefaultPaddingSize,
                top: kDefaultPaddingSize),
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPaddingSize, vertical: kMediumHeight),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.7),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  "About Me",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  artist.shortDescription,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 80.0,
          delegate: SliverChildListDelegate(
            [
              Entry(
                title: "Origin",
                body: artist.countryOfOrigin,
              ),
              Entry(
                title: "Main Art Type",
                body: artist.mainArtType,
              ),
              Entry(
                title: "Date of Birth",
                body: artist.artistDateOfBirth ?? "N/A",
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class Entry extends StatelessWidget {
  final String title;
  final String body;
  Entry({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        body,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
