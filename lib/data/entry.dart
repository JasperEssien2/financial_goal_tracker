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

  //TODO: Implement JSON parsing for EntryResponse model

  EntryResponse copyWith({
    double? totalCredit,
    double? totalDebit,
    double? completePercentage,
    List<Entry>? entries,
    double? target,
    List<DateBarChartData>? chartData
  }) {
    return EntryResponse(
      totalCredit: totalCredit ?? this.totalCredit,
      totalDebit: totalDebit ?? this.totalDebit,
      completePercentage: completePercentage ?? this.completePercentage,
      entries: entries ?? this.entries,
      target: target ?? this.target,
      chartData: chartData ?? this.chartData,
    );
  }

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

  //TODO: Implement JSON parsing for Entry model

  Entry copyWith({
    String? id,
    String? source,
    double? amount,
    String? date,
    String? type,
  }) {
    return Entry(
      id: id ?? this.id,
      source: source ?? this.source,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }

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

  //TODO: Implement JSON parsing for DateBarChartData model

  DateBarChartData copyWith({
    String? date,
    BarChartValue? barChartValue,
  }) {
    return DateBarChartData(
      date: date ?? this.date,
      barChartValue: barChartValue ?? this.barChartValue,
    );
  }

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

  // TODO: Implement JSON parsing for BarChartValue model

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
  List<Object> get props => [credit, debit];
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
