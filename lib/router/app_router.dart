import 'package:digi_pikasso/app.dart';
import 'package:digi_pikasso/config/size_config.dart';
import 'package:digi_pikasso/data.dart';
import 'package:digi_pikasso/presentation/art_by_id_loader.dart';
import 'package:digi_pikasso/presentation/piece_content.dart';
import 'package:digi_pikasso/presentation/shared/appbar.dart';
import 'package:digi_pikasso/presentation/shared/content_holder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return OrientationBuilder(builder: (context, orientation) {
                  SizeConfig().init(constraints, orientation);
                  return MyHomePage();
                });
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/:artId',
        pageBuilder: (context, state) {
          final artId = state.pathParameters['artId'];
          // Get the art
          return MaterialPage(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return OrientationBuilder(builder: (context, orientation) {
                  SizeConfig().init(constraints, orientation);
                  return ArtByIdLoader(artId: artId!);
                });
              },
            ),
          );
        },
      ),
    ],
    errorBuilder: (context, state) {
      return LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return Scaffold(
            appBar: getAppbar(context),
            body: ContentHolder(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.error?.toString() ?? 'page not found',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.red.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          );
        });
      });
    },
  );
}
