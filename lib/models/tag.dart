class Tag {
  final String id, name, colorCode, hexColorCode;

  Tag({
    required this.id,
    required this.name,
    required this.colorCode,
    required this.hexColorCode,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["_id"],
        name: json["name"],
        colorCode: json["colorCode"],
        hexColorCode: json['hexColorCode'],
      );
}
