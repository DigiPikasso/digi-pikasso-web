import 'package:auto_size_text/auto_size_text.dart';
import 'package:digi_pikasso/config/constants.dart';
import 'package:digi_pikasso/config/size_config.dart';
import 'package:digi_pikasso/data/models/piece.dart';
import 'package:digi_pikasso/presentation/piece_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SmallPieceEntry extends StatelessWidget {
  final Piece piece;
  const SmallPieceEntry(this.piece, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.push('/${piece.id}');
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Hero(
              tag: piece.assetPath,
              child: Image.asset(
                height: 25.74 * SizeConfig.heightMultiplier,
                width: 40 * kMediumWidth,
                piece.assetPath,
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
                "${piece.title}",
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                "by ${piece.artistName}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
