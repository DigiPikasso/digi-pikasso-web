import 'package:digi_pikasso/config/constants.dart';
import 'package:digi_pikasso/config/size_config.dart';
import 'package:digi_pikasso/data/models/Art.dart';
import 'package:digi_pikasso/data/models/piece.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PieceContent extends StatelessWidget {
  final Art piece;
  const PieceContent(this.piece, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              piece.title,
              style: GoogleFonts.montserratTextTheme()
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            ),
            SvgPicture.asset(
              "assets/header-logo.svg",
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Stack(
            children: [
              Hero(
                tag: piece.id,
                child: Image.asset(
                  "assets/art_images/${piece.id}.jpg",
                  height: 36.58 * SizeConfig.heightMultiplier,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: kMediumHeight * 3.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                ),
              )
            ],
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 34.58 * SizeConfig.heightMultiplier),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPaddingSize),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2 * SizeConfig.heightMultiplier),
                      Text(
                        piece.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: kMediumHeight * 2),
                      Text(
                        "Description",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: kMediumHeight),
                      Text(piece.description ?? "N/A"),
                      SizedBox(height: kMediumHeight * 2),
                      Text(
                        "Notes",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: kMediumHeight),
                      Text(piece.notes ?? "N/A"),
                      SizedBox(height: kMediumHeight * 2),
                      SizedBox(height: kMediumHeight),
                      SizedBox(width: kMediumWidth * 2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Piece Information",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: kMediumHeight),
                          RichText(
                            text: TextSpan(
                              text: 'Artist: ',
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "${piece.artist.firstName} ${piece.artist.lastName}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: CupertinoColors.activeBlue),
                                ),
                              ],
                            ),
                          ),
                          informationEntryWidget(context, 'Size (h w)',
                              '${piece.height} x ${piece.width}'),
                          informationEntryWidget(
                              context, 'Medium', piece.medium),
                          informationEntryWidget(
                              context, 'Type', piece.artType.name),
                          informationEntryWidget(
                              context, 'Current Location', piece.location.name),
                          // SizedBox(height: kSmallHeight),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Text("Status"),
                          //     SizedBox(width: kMediumWidth),
                          //     PieceStatus()
                          //   ],
                          // ),
                          SizedBox(height: kMediumHeight * 2),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Location History",
                          //       style: Theme.of(context)
                          //           .textTheme
                          //           .titleLarge!
                          //           .copyWith(fontWeight: FontWeight.w600),
                          //     ),
                          //     SizedBox(width: kMediumWidth),
                          //     FilledButton.icon(
                          //         onPressed: () {},
                          //         icon: Icon(Icons.add),
                          //         label: Text('Add new'))
                          //   ],
                          // ),
                          // SizedBox(height: kMediumHeight),
                          // DataTable(
                          //   columns: [
                          //     DataColumn(
                          //         label: Text('Location',
                          //             style: Theme.of(context)
                          //                 .textTheme
                          //                 .titleMedium)),
                          //     DataColumn(
                          //         label: Text('Dates',
                          //             style: Theme.of(context)
                          //                 .textTheme
                          //                 .titleMedium)),
                          //     DataColumn(
                          //         label: Text('Current',
                          //             style: Theme.of(context)
                          //                 .textTheme
                          //                 .titleMedium)),
                          //   ],
                          //   rows: [
                          //     DataRow(cells: [
                          //       DataCell(Text('FNB Parkside')),
                          //       DataCell(Text('24 Jan 2021 - present')),
                          //       DataCell(Text('Yes')),
                          //     ]),
                          //     DataRow(cells: [
                          //       DataCell(Text('FNB Parkside')),
                          //       DataCell(Text('24 Jan 2021 - present')),
                          //       DataCell(Text('')),
                          //     ]),
                          //     DataRow(cells: [
                          //       DataCell(Text('FNB Parkside')),
                          //       DataCell(Text('24 Jan 2021 - present')),
                          //       DataCell(Text('')),
                          //     ]),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container informationEntryWidget(
      BuildContext context, String title, String content) {
    return Container(
      margin: EdgeInsets.only(top: kSmallHeight),
      child: RichText(
        text: TextSpan(
          text: '$title: ',
          style: Theme.of(context).textTheme.bodyMedium,
          children: <TextSpan>[
            TextSpan(
              text: content,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class PieceStatus extends StatefulWidget {
  const PieceStatus({super.key});

  @override
  State<PieceStatus> createState() => _PieceStatusState();
}

class _PieceStatusState extends State<PieceStatus> {
  List<String> pieceStatusList = <String>['Available', 'Sold', 'Lost'];

  String dropdownValue = "Available";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: pieceStatusList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }
}
