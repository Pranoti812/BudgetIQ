import '../model/region_model.dart';
import '../service/api_service.dart';

class RegionController {
  List<RegionModel> regions = [];

  /// LOAD DATA
  Future<void> loadRegions() async {
    final data = await ApiService.fetchRegions();
    regions = data.map((e) => RegionModel.fromJson(e)).toList();
  }

  /// 🔥 TOTAL DEFICIT
  double get totalDeficit =>
      regions.fold(0, (sum, r) => sum + r.deficit);

  /// 🔥 TOTAL RECOMMENDED
  double get totalRecommended =>
      regions.fold(0, (sum, r) => sum + r.recommended);

  /// 🔥 TOP PRIORITY REGIONS
  List<RegionModel> get highPriority =>
      regions.where((r) => r.priority == "HIGH").toList();

  /// 🔥 GRAPH DATA
  List<Map<String, dynamic>> getChartData() {
    return regions.map((r) {
      return {
        "name": r.name,
        "deficit": r.deficit,
        "recommended": r.recommended,
      };
    }).toList();
  }
}