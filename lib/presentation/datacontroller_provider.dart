import 'package:financial_goal_tracker/presentation/data_controllers.dart';
import 'package:flutter/material.dart';

class DataControllerProvider<T> extends InheritedWidget {
  const DataControllerProvider({
    required this.dataController,
    super.key,
    required super.child,
  });

  final T dataController;

  static T of<T>(BuildContext context) {
    final element = context
        .getElementForInheritedWidgetOfExactType<DataControllerProvider<T>>();

    assert(element != null, "No $T found");

    return (element!.widget as DataControllerProvider<T>).dataController;
  }

  @override
  bool updateShouldNotify(DataControllerProvider<T> oldWidget) =>
      oldWidget.dataController != dataController;
}

extension BuildContextX on BuildContext {
  TargetDataController get targetDataController =>
      DataControllerProvider.of<TargetDataController>(this);

  EntryDataController get entryDataController =>
      DataControllerProvider.of<EntryDataController>(this);
}
