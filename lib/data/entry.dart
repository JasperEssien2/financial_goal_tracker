import 'package:financial_goal_tracker/data/dart_export.dart';

class EntryResponse {
  EntryResponse({
    required this.totalCredit,
    required this.totalDebit,
    required this.completePercentage,
    required this.entries,
    required this.target,
  });

  final double totalCredit;
  final double totalDebit;
  final double completePercentage;
  final List<Entry> entries;
  final double target;
}

class Entry {
  Entry({
    this.id,
    required this.source,
    required this.amount,
    required this.date,
    required this.type,
  });

  final String? id;
  final String source;
  final double amount;
  final String date;
  final EntryType type;
}

class DateBarChartData {
  DateBarChartData({
    required this.date,
    required this.barChartValue,
  });

  final String date;
  final BarChartValue barChartValue;
}

class BarChartValue {
  BarChartValue({
    required this.credit,
    required this.debit,
  });

  final double credit;
  final double debit;

  BarChartValue.fromJson(Map<String, dynamic> json)
      : credit = json['credit'],
        debit = json['debit'];
}

class EntryPayload extends Entry {
  EntryPayload({
    required super.source,
    required super.amount,
    required super.date,
    required super.type,
  });

  Map<String, dynamic> toJson() {
    return {};
  }
}

enum EntryType {
  credit,
  debit,
}

extension EntryTypeExt on EntryType {
  String get toEnumString {
    switch (this) {
      case EntryType.credit:
        return "Credit";
      case EntryType.debit:
        return "Debit";
    }
  }
}
