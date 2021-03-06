import 'package:financial_goal_tracker/data/entry_payload.dart';
import 'package:financial_goal_tracker/presentation/datacontroller_provider.dart';
import 'package:financial_goal_tracker/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntryBottomSheet extends StatefulWidget {
  const EntryBottomSheet({Key? key}) : super(key: key);

  @override
  State<EntryBottomSheet> createState() => _EntryBottomSheetState();
}

class _EntryBottomSheetState extends State<EntryBottomSheet> {
  final _sourceTextController = TextEditingController();
  final _amountTextController = TextEditingController();
  final _typeTextController = TextEditingController();
  final _dateTextController = TextEditingController();
  var _selectedData = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0)
            .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Entry",
              style: TextStyle(fontSize: 18),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _amountTextController,
                    label: "Amount",
                    prefix: const Icon(Icons.monetization_on),
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Expanded(
                  child: PopupMenuButton<String>(
                    initialValue: "Credit",
                    itemBuilder: (c) => ['Credit', 'Debit']
                        .map(
                          (e) => PopupMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onSelected: (selected) {
                      _typeTextController.text = selected;
                    },
                    child: IgnorePointer(
                      ignoring: true,
                      child: AppTextField(
                        controller: _typeTextController,
                        label: "Type",
                        readOnly: true,
                        suffix: const Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: AppTextField(
                    controller: _sourceTextController,
                    label: "Source",
                  ),
                ),
                Expanded(
                  child: AppTextField(
                    controller: _dateTextController,
                    label: "Date",
                    readOnly: true,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 365),
                        ),
                        lastDate: DateTime.now(),
                      );

                      if (date != null) {
                        _selectedData = date;
                        _dateTextController.text =
                            DateFormat.yMMMMd().format(date);
                      } else {
                        _dateTextController.text = "";
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppButton(
              listenable: Listenable.merge(
                [
                  _amountTextController,
                  _dateTextController,
                  _sourceTextController,
                  _typeTextController,
                  context.entryDataController,
                ],
              ),
              enable: _enableButton,
              loading: () => context.entryDataController.isLoading,
              onPress: () => _saveTarget(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _saveTarget() {
    return context.entryDataController.saveEntry(
      EntryPayload(
        source: _sourceTextController.text,
        amount: double.parse(_amountTextController.text),
        date: _selectedData.millisecondsSinceEpoch,
        type: _typeTextController.text,
      ),
    );
  }

  bool _enableButton() {
    int? amount = int.tryParse(_amountTextController.text);

    return amount != null &&
        amount != 0 &&
        _dateTextController.text.isNotEmpty &&
        _sourceTextController.text.isNotEmpty &&
        _typeTextController.text.isNotEmpty;
  }
}

class AddTargetBottomSheet extends StatefulWidget {
  const AddTargetBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTargetBottomSheet> createState() => _AddTargetBottomSheetState();
}

class _AddTargetBottomSheetState extends State<AddTargetBottomSheet> {
  final _targetTextController = TextEditingController();
  late final _targetDataController = context.targetDataController;

  @override
  void initState() {
    _targetDataController.addListener(() {
      if (_targetDataController.data != null) {
        context.entryDataController.fetchEntries();
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0)
        ..copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Add Target",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 24),
          AppTextField(
            controller: _targetTextController,
            label: "Target",
            prefix: const Icon(Icons.monetization_on),
            inputType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 24),
          AppButton(
            listenable: Listenable.merge(
              [
                _targetTextController,
                _targetDataController,
              ],
            ),
            enable: _enableButton,
            loading: () => _targetDataController.isLoading,
            onPress: () => _targetDataController.saveTarget(
              double.parse(_targetTextController.text),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  bool _enableButton() {
    int? amount = int.tryParse(_targetTextController.text);

    return amount != null && amount != 0;
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.listenable,
    required this.enable,
    required this.onPress,
    required this.loading,
  }) : super(key: key);

  final Listenable listenable;
  final bool Function() enable;
  final VoidCallback onPress;
  final bool Function() loading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: AnimatedBuilder(
        animation: listenable,
        builder: (context, _) {
          return RawMaterialButton(
            onPressed: onPress,
            fillColor: enable() ? AppColor.primaryColor : Colors.grey[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: loading()
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 8,
                    ),
                  )
                : Text(
                    "Save",
                    style: theme.textTheme.button!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.inputType,
    this.readOnly,
    this.onTap,
    this.suffix,
    this.prefix,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? inputType;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Widget? suffix;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        readOnly: readOnly ?? false,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefix,
          suffixIcon: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Colors.white),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
