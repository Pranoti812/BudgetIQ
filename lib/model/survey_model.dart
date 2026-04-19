class SurveyModel {
  final String region;
  final String sector;
  final int rating;
  final String comment;

  SurveyModel({
    required this.region,
    required this.sector,
    required this.rating,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      "region": region,
      "sector": sector,
      "rating": rating,
      "comment": comment,
      "timestamp": DateTime.now(),
    };
  }
}