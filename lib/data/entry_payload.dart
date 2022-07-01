import 'package:equatable/equatable.dart';
import 'package:financial_goal_tracker/data/dart_export.dart';

class EntryPayload extends Equatable {
  const EntryPayload({
    required this.source,
    required this.amount,
    required this.date,
    required this.type,
  });

  final int date;
  final String source;
  final double amount;
  final EntryType type;

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'source': source,
      'amount': amount,
      'type': type.toEnumString,
    };
  }

  @override
  List<Object> get props => [date, source, amount, type];
}
