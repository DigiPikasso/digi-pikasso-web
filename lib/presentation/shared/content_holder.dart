import 'package:digi_pikasso/config/size_config.dart';
import 'package:flutter/material.dart';

class ContentHolder extends StatelessWidget {
  final Widget child;

  const ContentHolder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
          horizontal: 3.55 * SizeConfig.widthMultiplier, vertical: 5),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: child,
      ),
    );
  }
}
