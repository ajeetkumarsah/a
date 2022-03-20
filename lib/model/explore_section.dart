class ExploreModel {
  final String heading;
  final String description;
  final Function onClick;
  final String? icon;

  ExploreModel(
      {required this.heading,
      required this.description,
      required this.onClick,
      this.icon});
}
