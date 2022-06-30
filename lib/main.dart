import 'package:dio/dio.dart';
import 'package:financial_goal_tracker/data/repository_impl.dart';
import 'package:financial_goal_tracker/presentation/home_screen.dart';
import 'package:financial_goal_tracker/presentation/repository_provider.dart';
import 'package:financial_goal_tracker/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finances Tracker',
      theme: ThemeData(
        primaryColor: AppColor.primaryColor,
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          modalBackgroundColor: AppColor.primaryContainer,
          elevation: 5.0,
        ),
        colorScheme: ColorScheme.light(
          secondary: AppColor.secondary,
          tertiary: AppColor.tertiary,
          primaryContainer: AppColor.primaryContainer,
          tertiaryContainer: AppColor.tertiaryContainer,
        ),
      ),
      home: RepositoryProvider(
        repository: RepositoryImpl(Dio()),
        child: const HomeScreen(),
      ),
    );
  }
}
