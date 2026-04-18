import '../model/home_model.dart';
import '../service/api_service.dart';

class HomeController {
  List<BudgetItem> items = [];

  Future<void> loadData() async {
    final data = await ApiService.fetchRegions();
    items = data.map((e) => BudgetItem.fromJson(e)).toList();
  }

  double get total {
    return items.fold(0, (sum, item) => sum + item.value);
  }
}