import '../model/region_model.dart';
import '../service/api_service.dart';

class RegionController {
  List<RegionModel> regions = [];

  Future<void> loadRegions() async {
    final data = await ApiService.fetchRegions();
    regions = data.map((e) => RegionModel.fromJson(e)).toList();
  }
}