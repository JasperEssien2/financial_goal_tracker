import 'package:dio/dio.dart';
import 'package:financial_goal_tracker/data/dart_export.dart';
import 'package:financial_goal_tracker/data/helpers/auth_helper.dart';
import 'package:financial_goal_tracker/presentation/data_controllers.dart';
import 'package:financial_goal_tracker/presentation/datacontroller_provider.dart';
import 'package:financial_goal_tracker/presentation/home_screen.dart';
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
    return FutureBuilder<Map<String, String>?>(
      future: AuthHelper.authenticate(),
      builder: (context, snapshot) {
        final headers = snapshot.data;

        if (headers != null) {
          headers.addAll(
            {
              "Accept": "application/json",
              "Access-Control-Allow-Origin": "*",

            },
          );
        }

        final repository = RepositoryImpl(Dio(
          BaseOptions(
            headers: headers,
          ),
        ));
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
          home: headers == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : DataControllerProvider<EntryDataController>(
                  dataController: EntryDataController(repository),
                  child: DataControllerProvider<TargetDataController>(
                    dataController: TargetDataController(repository),
                    child: const HomeScreen(),
                  ),
                ),
        );
      },
    );
  }
}
