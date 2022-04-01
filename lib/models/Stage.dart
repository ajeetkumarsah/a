class Stage {
  final String status, color, name, id;

  Stage({
    required this.status,
    required this.color,
    required this.name,
    required this.id,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        id: json["_id"],
        name: json["name"],
        color: json["color"],
        status: json["status"],
      );
}
