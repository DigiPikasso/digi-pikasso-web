import 'dart:convert';

import 'package:digi_pikasso/data/models/Art.dart';
import 'package:digi_pikasso/presentation/piece_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArtByIdLoader extends StatefulWidget {
  final String artId;
  const ArtByIdLoader({super.key, required this.artId});

  @override
  State<ArtByIdLoader> createState() => _ArtByIdLoaderState();
}

class _ArtByIdLoaderState extends State<ArtByIdLoader> {
  @override
  void initState() {
    super.initState();
    loadArt();
  }

  void loadArt() async {
    final response = await http.get(Uri.parse(
        'https://container-service-2.urksr0dimjrfe.eu-west-1.cs.amazonlightsail.com/get-art-by-id/${widget.artId}'));

    Iterable l = json.decode(response.body);

    List<Art> arts = List<Art>.from(l.map((model) => Art.fromJson(model)));
    Art art = arts[0];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PieceContent(art),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}
