import 'package:salessimplify/models/DealModel.dart';

class DealCategory {
  final String stageId, stageName, color;
  final List<DealModel> deals;

  DealCategory({
    required this.stageId,
    required this.stageName,
    required this.color,
    required this.deals,
  });

  factory DealCategory.fromJson(Map<String, dynamic> json) {
    return DealCategory(
      stageId: json["stageId"],
      stageName: json["stageName"],
      color: json["color"],
      deals: (json["deals"] as List)
          .map(
            (e) => DealModel.fromJson(e),
          )
          .toList(),
    );
  }
}
