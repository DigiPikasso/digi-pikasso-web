import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:digi_pikasso/config/constants.dart';
import 'package:digi_pikasso/config/size_config.dart';
import 'package:digi_pikasso/data.dart';
import 'package:digi_pikasso/presentation/shared/appbar.dart';
import 'package:digi_pikasso/presentation/small_entry.dart';
import 'package:digi_pikasso/presentation/theme/apptheme.dart';
import 'package:digi_pikasso/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      routeInformationParser: AppRouter().router.routeInformationParser,
      routerDelegate: AppRouter().router.routerDelegate,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  /// The currently selected index of the side menu
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
              child: Text(''),
            ),
            ListTile(
              leading: Icon(
                Icons.image_outlined,
                color: Color(0xFF009999),
              ),
              title: const Text('Art Catalogue'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 0;
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.people,
                color: Color(0xFF009999),
              ),
              title: const Text('Hall of Fame'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 1;
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.music_note,
                color: Color(0xFF009999),
              ),
              title: const Text('Art Exhibitions'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 2;
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.map,
                color: Color(0xFF009999),
              ),
              title: const Text('Art Locator'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 3;
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Color(0xFF009999),
              ),
              title: const Text('Building Management'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  selectedIndex = 4;
                });
              },
            ),
          ],
        ),
      ),
      body: views[selectedIndex],
    );
  }

  List<Widget> views = [
    Catalog(),
    Center(
      child: Text('Hall of Fame'),
    ),
    Center(
      child: Text('Art Exhibitions'),
    ),
    Center(
      child: Text('Art Locator'),
    ),
    Center(
      child: Text('Building Management'),
    ),
  ];
}

class Catalog extends StatelessWidget {
  Catalog({super.key});
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
                    image: AssetImage("assets/home_image.png"),
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
                  'Art Catalogue',
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingSize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "FNB Parkside",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      letterSpacing: 0.41, fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      letterSpacing: 0.41,
                      color: CupertinoColors.activeBlue,
                      fontWeight: FontWeight.bold),
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
              items: pieces.map((piece) {
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
      ),
    );
  }
}
