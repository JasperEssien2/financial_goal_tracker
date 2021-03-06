import 'package:equatable/equatable.dart';

class EntryResponse extends Equatable {
  const EntryResponse({
    required this.totalCredit,
    required this.totalDebit,
    required this.completePercentage,
    required this.entries,
    required this.target,
    this.chartData = const [],
  });

  final double totalCredit;
  final double totalDebit;
  final double completePercentage;
  final List<Entry> entries;
  final List<DateBarChartData> chartData;
  final double target;

  EntryResponse.fromJson(Map<String, dynamic> json)
      : totalCredit = (json['total_credit'] as int).toDouble(),
        totalDebit = json['total_debit'].toDouble(),
        completePercentage = json['completion_percentage'].toDouble(),
        entries =
            (json['entries'] as List).map((e) => Entry.fromJson(e)).toList(),
        chartData = (json['bar_chart_data'] as Map<String, dynamic>)
            .keys
            .map((key) =>
                DateBarChartData.fromJson(key, json['bar_chart_data'][key]))
            .toList(),
        target = json['target'].toDouble();

  EntryResponse.dummy()
      : totalCredit = 200,
        totalDebit = 100,
        completePercentage = 0.9,
        target = 1000,
        entries = [],
        chartData = [];

  @override
  List<Object> get props {
    return [
      totalCredit,
      totalDebit,
      completePercentage,
      entries,
      target,
      chartData,
    ];
  }
}

class Entry extends Equatable {
  const Entry({
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
  final String type;

  Entry.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        source = json["source"],
        amount = json['amount'].toDouble(),
        date = json['date'],
        type = json['type'];

  @override
  List<Object?> get props {
    return [
      id,
      source,
      amount,
      date,
      type,
    ];
  }
}

class DateBarChartData extends Equatable {
  const DateBarChartData({
    required this.date,
    required this.barChartValue,
  });

  final String date;
  final BarChartValue barChartValue;

  DateBarChartData.fromJson(String key, Map<String, dynamic> dataJson)
      : date = key,
        barChartValue = BarChartValue.fromJson(dataJson);

  @override
  List<Object> get props => [date, barChartValue];
}

class BarChartValue extends Equatable {
  const BarChartValue({
    required this.credit,
    required this.debit,
  });

  final double credit;
  final double debit;

  BarChartValue.fromJson(Map<String, dynamic> json)
      : credit = json['credit'].toDouble(),
        debit = json['debit'].toDouble();

  @override
  List<Object?> get props => [debit, credit];
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
