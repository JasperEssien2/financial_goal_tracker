import 'package:financial_goal_tracker/domain/repository.dart';
import 'package:flutter/material.dart';

class RepositoryProvider extends InheritedWidget {
  const RepositoryProvider({
    super.key,
    required this.repository,
    required Widget child,
  }) : super(child: child);

  final Repository repository;

  static Repository of(BuildContext context) {
    final  result = context.getElementForInheritedWidgetOfExactType<RepositoryProvider>();
    assert(result != null, 'No RepositoryProvider found in context');
    return (result!.widget as RepositoryProvider).repository;
  }

  @override
  bool updateShouldNotify(RepositoryProvider oldWidget) => false;
}

