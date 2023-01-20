import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// Some useful utilities for the [Finder]
extension FinderExtensions on Finder {
  /// Taps the [Finder] and then waits till app is stable.
  ///
  /// ```dart
  /// await find.byKey(Key('button')).tap(tester);
  /// ```
  Future<void> tap(WidgetTester tester) async {
    await tester.tap(this);
    await tester.pumpAndSettle();
  }

  /// Checks to see if this finder matches the [matcher].
  ///
  /// ```dart
  /// await find.text('1').should(findsOneWidget);
  /// ```
  Future<void> should(Matcher matcher) async {
    expect(this, matcher);
  }

  /// Types the [text] into this [Finder].
  ///
  /// [shouldSubmit] determines whether the tester will submit the text.
  ///
  /// ```dart
  /// await find.byKey(Key('textField')).enterText('test', shouldSubmit: true);
  /// ```
  Future<void> enterText(
    WidgetTester tester,
    String text, {
    bool shouldSubmit = true,
  }) async {
    await tester.enterText(this, text);

    if (shouldSubmit) {
      await tester.testTextInput.receiveAction(TextInputAction.done);
    }

    await tester.pumpAndSettle();
  }
}

/// Some useful utilities for the [WidgetTester]
extension WidgetTesterExtensions on WidgetTester {
  /// Waits for a tester to complete until a timeout.
  ///
  /// Use this when pumpAndSettle is not waiting long enough for
  /// the task to complete.
  ///
  /// When using widget tests ensure you run the test with runAsync.
  /// Widget tests are ran in FakeAsync mode so when you await a
  /// [Future.delayed] you wait indefinitely.
  /// ```dart
  /// testWidgets('a widget test', (tester) {
  ///   ...
  ///   await tester.runAsync(() async {
  ///     await tester.waitFor(find.text('1'));
  ///     ...
  ///   });
  /// })
  /// ```
  ///
  /// https://github.com/flutter/flutter/issues/88765
  Future<void> waitFor(
    Finder finder, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    final end = binding.clock.now().add(timeout);

    do {
      if (binding.clock.now().isAfter(end)) {
        throw Exception('Timed out waiting for $finder');
      }

      await pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 100));
    } while (finder.evaluate().isEmpty);
  }
}

/// When creating golden tests and using the [DeviceBuilder]
/// you can pass this as the overrideDevicesForAllScenarios.
/// ```dart
/// final builder = DeviceBuilder()
///   ..overrideDevicesForAllScenarios(
///     defaultGoldenDevices
/// )
/// ```
List<Device> defaultGoldenDevices = [
  Device.phone,
  Device.iphone11,
  Device.tabletPortrait,
  Device.tabletLandscape,
  const Device(
    name: 'desktop',
    size: Size(1920, 1080),
  )
];
