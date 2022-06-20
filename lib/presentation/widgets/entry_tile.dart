import 'package:flutter/material.dart';

class EntryListTile extends StatelessWidget {
  const EntryListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.green;

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
          child: const Center(
            child: Icon(
              Icons.arrow_drop_up,
              size: 25,
              color: color,
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            "Car Sales",
            style:  TextStyle(
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
              text: "\$400,000",
              style: _subtitleStyle,
              children: [
                TextSpan(
                  text: " 12 May 2022",
                  style: _subtitleStyle.copyWith(fontSize: 10),
                )
              ],
            ),
          ),
        ),
        trailing: const Icon(
          Icons.remove_circle,
          size: 20,
          color: Colors.grey,
        ),
      ),
    );
  }

  TextStyle get _subtitleStyle {
    return TextStyle(
      fontSize: 14,
      color: Colors.grey[700],
    );
  }
}
