class Piece {
  final int id;
  final String assetPath;
  final String title;
  final String artistName;
  final String medium;
  final String size;
  final String description;

  Piece(this.id,
      {required this.assetPath,
      required this.title,
      required this.artistName,
      required this.medium,
      required this.size,
      required this.description});
}
