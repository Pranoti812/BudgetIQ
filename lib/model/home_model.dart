class BudgetItem {
  final String title;
  final double value;
  final String amount;

  BudgetItem({
    required this.title,
    required this.value,
    required this.amount,
  });

  factory BudgetItem.fromJson(Map<String, dynamic> json) {
    return BudgetItem(
      title: json['title'] ?? "",
      value: (json['value'] as num).toDouble(),
      amount: json['amount'] ?? "",
    );
  }
}