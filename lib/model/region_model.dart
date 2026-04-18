class RegionModel {
  final String name;
  final String priority;
  final double deficit;
  final double recommended;
  final int population;
  final String suggestion;

  RegionModel({
    required this.name,
    required this.priority,
    required this.deficit,
    required this.recommended,
    required this.population,
    required this.suggestion,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      name: json['name'],
      priority: json['priority'],
      deficit: json['deficit'].toDouble(),
      recommended: json['recommended'].toDouble(),
      population: json['population'],
      suggestion: json['suggestion'],
    );
  }
}