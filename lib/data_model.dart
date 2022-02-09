class Transactions{
  Transactions({
    required this.category,
    required this.amount,
    required this.incomeExpense,
    required this.id,
});
  String? category;
  String? id;
  double? amount;
  DateTime? date;
  String? remark;
  String? incomeExpense;
}

class Categories{
  Categories({
    required this.name,
    required this.id,
});
  String? id;
  String? name;
}