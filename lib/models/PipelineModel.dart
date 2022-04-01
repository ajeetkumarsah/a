import 'Stage.dart';

class PipelineModel {
  final String id, name;
  final List<Stage> stages;

  PipelineModel({
    required this.id,
    required this.name,
    required this.stages,
  });

  factory PipelineModel.fromJson(Map<String, dynamic> json) {
    return PipelineModel(
      name: json["name"],
      id: json["_id"],
      stages: (json["stages"] as List)
          .map(
            (e) => Stage.fromJson(e),
          )
          .toList(),
    );
  }
}
