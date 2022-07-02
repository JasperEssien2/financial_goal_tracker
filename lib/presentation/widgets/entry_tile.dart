import 'package:financial_goal_tracker/data/dart_export.dart';
import 'package:financial_goal_tracker/presentation/datacontroller_provider.dart';
import 'package:flutter/material.dart';

class EntryListTile extends StatelessWidget {
  const EntryListTile({super.key, required this.entry});

  final Entry entry;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        horizontalTitleGap: 8,
        leading: CircleAvatar(
          radius: 15,
          backgroundColor: color.withOpacity(.3),
          child: Center(
            child: Icon(
              isCredit ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: 25,
              color: color,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            entry.source,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: RichText(
            text: TextSpan(
              text: "\$${entry.amount}",
              style: _subtitleStyle,
              children: [
                TextSpan(
                  text: " ${entry.date}",
                  style: _subtitleStyle.copyWith(fontSize: 10),
                )
              ],
            ),
          ),
        ),
        trailing: GestureDetector(
          onTap: () => context.entryDataController.deleteEntry(entry.id!),
          child: const Icon(
            Icons.remove_circle,
            size: 20,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Color get color => isCredit ? Colors.green : Colors.red;

  bool get isCredit => entry.type.toLowerCase() == 'credit';

  TextStyle get _subtitleStyle {
    return TextStyle(
      fontSize: 14,
      color: Colors.grey[700],
    );
  }
}
