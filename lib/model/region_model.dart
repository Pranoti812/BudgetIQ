class RegionModel {
  final String name; // industry
  final double deficit; // current_price
  final double recommended;
  final String priority;
  final int population;
  final String suggestion;

  RegionModel({
    required this.name,
    required this.deficit,
    required this.recommended,
    required this.priority,
    required this.population,
    required this.suggestion,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    double value =
        double.tryParse(json['current_price']?.toString() ?? "0") ?? 0;

    return RegionModel(
      name: json['industry'] ?? "Unknown",

      deficit: value / 100000, // convert crore → simplified

      recommended: (value / 100000) * 1.2, // +20% AI suggestion

      priority: value > 5000000
          ? "HIGH"
          : value > 2000000
              ? "MEDIUM"
              : "LOW",

      population: 50, // dummy (API doesn’t provide)

      suggestion: "Increase investment in ${json['industry']}",
    );
  }
}