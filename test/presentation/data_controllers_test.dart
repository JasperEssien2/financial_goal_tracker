import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:financial_goal_tracker/data/dart_export.dart';
import 'package:financial_goal_tracker/domain/repository.dart';
import 'package:financial_goal_tracker/presentation/data_controllers.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements Repository {}

class FakeEntryPayload extends Fake implements EntryPayload {}

void main() {
  late MockRepository repository;
  late TargetDataController targetController;
  late EntryDataController entryController;

  setUp(
    () {
      registerFallbackValue(FakeEntryPayload());
      repository = MockRepository();
      targetController = TargetDataController(repository);
      entryController = EntryDataController(repository);
    },
  );

  group(
    "Test TargetDataController",
    () {
      group(
        "TargetDataController loading state",
        () {
          test(
            "Ensure that isLoading is true, when saveTarget called initially, ",
            () {
              targetController.saveTarget(900).ignore();

              expectLoading(targetController);
            },
          );

          test(
            "Ensure that isLoading is true, when fetchTarget() called initially ",
            () {
              targetController.fetchTarget().ignore();

              expectLoading(targetController);
            },
          );
        },
      );

      group(
        "TargetDataController success state",
        () {
          test(
            "Ensure that data is set and loading is false, when saveTarget called and request successful",
            () async {
              when(() => repository.postTarget(any())).thenAnswer(
                (_) => Future.value(const Right(900)),
              );

              await targetController.saveTarget(900);

              expectSuccess(
                targetController,
                successData: 900,
                verify: () => verify(() => repository.postTarget(900)),
              );
            },
          );

          test(
            "Ensure that data is set and loading is false, when fetchTarget() called and request successful",
            () async {
              when(() => repository.getTarget()).thenAnswer(
                (_) => Future.value(const Right(200)),
              );

              await targetController.fetchTarget();

              expectSuccess(
                targetController,
                successData: 200,
                verify: () => verify(() => repository.getTarget()),
              );
            },
          );
        },
      );

      group(
        "TargetDataController error state ",
        () {
          test(
            "Ensure that error is set and loading is false, when saveTarget called and request fails",
            () async {
              when(() => repository.postTarget(any())).thenAnswer(
                (_) => Future.value(const Left("Error")),
              );

              await targetController.saveTarget(900);

              expectError(
                targetController,
                error: "Error",
                verify: () => verify(() => repository.postTarget(900)),
              );
            },
          );

          test(
            "Ensure that error is set and loading is false, when fetchTarget() called and request fails",
            () async {
              when(() => repository.getTarget()).thenAnswer(
                (_) => Future.value(const Left("Error")),
              );

              await targetController.fetchTarget();

              expectError(
                targetController,
                error: "Error",
                verify: () => verify(() => repository.getTarget()),
              );
            },
          );
        },
      );
    },
  );

  group(
    "Test EntryDataController",
    () {
      group(
        "EntryDataController loading state",
        () {
          test(
            "Ensure that isLoading is true, when fetchEntries called initially, ",
            () {
              entryController.fetchEntries().ignore();

              expectLoading(entryController);
            },
          );

          test(
            "Ensure that isLoading is true, when saveEntry() called initially ",
            () {
              entryController.saveEntry(_dummyEntryPayload()).ignore();

              expectLoading(entryController);
            },
          );

          test(
            "Ensure that isLoading is true, when deleteEbtry() called initially ",
            () {
              entryController.deleteEntry('entryId').ignore();

              expectLoading(entryController);
            },
          );
        },
      );

      group(
        "EntryDataController success state",
        () {
          test(
            "Ensure that data is set and loading is false, when fetchEntries() called and request successful",
            () async {
              when(() => repository.getEntries()).thenAnswer(
                (_) => Future.value(Right(EntryResponse.dummy())),
              );

              await entryController.fetchEntries();

              expectSuccess<EntryResponse?>(
                entryController,
                successData: EntryResponse.dummy(),
                verify: () => verify(() => repository.getEntries()),
              );
            },
          );

          test(
            "Ensure that data is set and loading is false, when saveEntry() called and request successful",
            () async {
              when(() => repository.getEntries()).thenAnswer(
                (_) => Future.value(Right(EntryResponse.dummy())),
              );

              await entryController.fetchEntries();

              expectSuccess<EntryResponse?>(
                entryController,
                successData: EntryResponse.dummy(),
                verify: () => verify(() => repository.getEntries()),
              );
            },
          );

          test(
            "Ensure that data is set and loading is false, when deleteEntry() called and request successful",
            () async {
              when(() => repository.deleteEntry("entryId")).thenAnswer(
                (_) => Future.value(Right(EntryResponse.dummy())),
              );

              await entryController.deleteEntry('entryId');

              expectSuccess<EntryResponse?>(
                entryController,
                successData: EntryResponse.dummy(),
                verify: () => verify(() => repository.deleteEntry('entryId')),
              );
            },
          );
        },
      );

      group(
        "EntryDataController error state ",
        () {
          test(
            "Ensure that error is set and loading is false, when getEntries() called and request fails",
            () async {
              when(() => repository.getEntries()).thenAnswer(
                (_) => Future.value(const Left("Error")),
              );

              await entryController.fetchEntries();

              expectError<EntryResponse?>(
                entryController,
                error: "Error",
                verify: () => verify(() => repository.getEntries()),
              );
            },
          );

          test(
            "Ensure that error is set and loading is false, when postEntry() called and request fails",
            () async {
              when(() => repository.postEntry(any())).thenAnswer(
                (_) => Future.value(const Left("Error")),
              );

              await entryController.saveEntry(_dummyEntryPayload());

              expectError<EntryResponse?>(
                entryController,
                error: "Error",
                verify: () =>
                    verify(() => repository.postEntry(_dummyEntryPayload())),
              );
            },
          );

          test(
            "Ensure that error is set and loading is false, when deleteEntry() called and request fails",
            () async {
              when(() => repository.deleteEntry(any())).thenAnswer(
                (_) => Future.value(const Left("Error")),
              );

              await entryController.deleteEntry('entryId');

              expectError<EntryResponse?>(
                entryController,
                error: "Error",
                verify: () => verify(() => repository.deleteEntry('entryId')),
              );
            },
          );
        },
      );
    },
  );

  tearDownAll(
    () {
      targetController.dispose();
      entryController.dispose();
    },
  );
}

EntryPayload _dummyEntryPayload() {
  return const EntryPayload(
    source: "source",
    amount: 300,
    date: 5456566556,
    type: "Credit",
  );
}

expectLoading(DataController dataController) {
  expect(dataController.isLoading, true);
}

expectSuccess<T>(
  DataController<T> dataController, {
  required T successData,
  Function()? verify,
}) {
  expect(dataController.isLoading, false);
  expect(dataController.data, successData);

  if (verify != null) {
    verify();
  }
}

expectError<T>(
  DataController<T> dataController, {
  required String error,
  Function()? verify,
}) {
  expect(dataController.isLoading, false);
  expect(dataController.error, error);

  if (verify != null) {
    verify();
  }
}
