import 'package:financial_goal_tracker/presentation/datacontroller_provider.dart';
import 'package:financial_goal_tracker/presentation/theme/colors.dart';
import 'package:financial_goal_tracker/presentation/widgets/entry_tile.dart';
import 'package:financial_goal_tracker/presentation/widgets/widget_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data_controllers.dart';
import 'widgets/entry_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool targetBottomSheetUp = false;

  @override
  void initState() {
    context.targetDataController.addListener(() {
      if (_noTargetSet && !targetBottomSheetUp) {
        _showAddTargetBottomSheet();
      } else if (_hasTarget) {
        context.entryDataController.fetchEntries();
      }
    });
    context.targetDataController.fetchTarget();

    super.initState();
  }

  void _showAddTargetBottomSheet() {
    final width = MediaQuery.of(context).size.width;
    targetBottomSheetUp = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: width > 600 ? width * .6 : width,
      ),
      builder: (c) => DataControllerProvider<TargetDataController>(
        dataController: context.targetDataController,
        child: DataControllerProvider<EntryDataController>(
          dataController: context.entryDataController,
          child: const AddTargetBottomSheet(),
        ),
      ),
    );
  }

  bool get _noTargetSet =>
      context.targetDataController.error == 'No target found';

  bool get _hasTarget {
    return !context.targetDataController.hasError &&
        context.targetDataController.data != null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraint) {
        final padding = constraint.maxWidth > 600
            ? EdgeInsets.symmetric(horizontal: constraint.maxWidth * .2)
            : const EdgeInsets.symmetric(horizontal: 8);

        return Container(
          padding: padding,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.primaryContainer,
                colorScheme.secondaryContainer,
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverAppBar(
                  backgroundColor: Colors.transparent,
                  floating: true,
                  pinned: true,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.light,
                  ),
                  title: Text(
                    "Target",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Row(
                        children: const [
                          Expanded(
                            child: TargetAmountCard(),
                          ),
                          Expanded(
                            child: TargetPieChart(),
                          ),
                        ],
                      ),
                      const MonthlyBarChart(),
                      AnimatedBuilder(
                        animation: context.entryDataController,
                        builder: (context, _) {
                          return Column(
                            children: context.entryDataController.data?.entries
                                    .map((e) => EntryListTile(entry: e))
                                    .toList() ??
                                [],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: const FAButton(),
          ),
        );
      },
    );
  }
}

class FAButton extends StatelessWidget {
  const FAButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return FloatingActionButton(
      backgroundColor: AppColor.primaryColor,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          constraints: BoxConstraints(
            maxWidth: width > 600 ? width * .6 : width,
          ),
          builder: (c) => DataControllerProvider<EntryDataController>(
            dataController: context.entryDataController,
            child: const EntryBottomSheet(),
          ),
        );
      },
      elevation: 12,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        ),
      ),
      child: const Icon(
        Icons.create_rounded,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}
