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
    name: json['name'] ?? "Unknown",
    priority: json['priority'] ?? "LOW",
    deficit: (json['deficit'] as num?)?.toDouble() ?? 0,
    recommended: (json['recommended'] as num?)?.toDouble() ?? 0,
    population: (json['population'] as num?)?.toInt() ?? 0,
    suggestion: json['suggestion'] ?? "",
  );
  }
}