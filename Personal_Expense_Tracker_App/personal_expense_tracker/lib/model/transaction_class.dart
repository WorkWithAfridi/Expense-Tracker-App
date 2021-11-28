class Transaction {
  late String id;
  late String title;
  late double amount;
  late DateTime date;
  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  String toString(){
    return '{"Transaction" : { "id":$id, "title":$title, "amount":$amount, "date":$date}} ]';
  }

  Map<String, dynamic> toJson()=>{
    'id': id,
    'title':title,
    'amount':amount,
    'date': date.toIso8601String()
  };
}
