import 'package:digi_pikasso/presentation/catalog.dart';
import 'package:digi_pikasso/presentation/hall_of_fame.dart';
import 'package:digi_pikasso/presentation/shared/appbar.dart';
import 'package:digi_pikasso/presentation/theme/apptheme.dart';
import 'package:digi_pikasso/router/app_router.dart';
import 'package:flutter/material.dart';

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
    HallOfFame(),
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
