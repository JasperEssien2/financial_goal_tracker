import 'package:equatable/equatable.dart';

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

  //TODO Implement JSON parsing for EntryResponse model

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

  //TODO Implement JSON parsing for Entry model
}

class DateBarChartData {
  DateBarChartData({
    required this.date,
    required this.barChartValue,
  });

  final String date;
  final BarChartValue barChartValue;

  //TODO Implement JSON parsing for DateBarChartData model
}

class BarChartValue extends Equatable {
  const BarChartValue({
    required this.credit,
    required this.debit,
  });

  final double credit;
  final double debit;

  //TODO Implement JSON parsing for BarChartValue model

  BarChartValue.fromJson(Map<String, dynamic> json)
      : credit = json['credit'],
        debit = json['debit'];

  const BarChartValue.dummy()
      : credit = 20,
        debit = 50;

  BarChartValue copyWith({
    double? credit,
    double? debit,
  }) {
    return BarChartValue(
      credit: credit ?? this.credit,
      debit: debit ?? this.debit,
    );
  }

  @override
  List<Object?> get props => [credit, debit];
}

class EntryPayload {
  EntryPayload({
    required this.source,
    required this.amount,
    required this.date,
    required this.type,
  });

  final int date;
  final String source;
  final double amount;
  final String type;

  //TODO Implement to JSON parsing for EntryPayload model

  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'amount': amount,
      'date': date,
      'type': type,
    };
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
