import 'package:flutter_test/flutter_test.dart';

/// Makes using the [Finder] with a [WidgetTester] easier
extension FinderExtensions on Finder {
  /// Taps the [Finder] and then waits till app is stable
  ///
  /// ```dart
  /// await find.byKey(Key('button')).tap(tester);
  /// ```
  Future<void> tap(WidgetTester tester) async {
    await tester.tap(this);
    await tester.pumpAndSettle();
  }

  /// Checks to see if this finder matches the [matcher]
  ///
  /// ```dart
  /// await find.text('1').should(findsOneWidget);
  /// ```
  Future<void> should(Matcher matcher) async {
    expect(this, matcher);
  }

  /// Types the [text] into this [Finder]
  ///
  /// [shouldSubmit] determines whether the tester will submit the text
  ///
  /// ```dart
  /// await find.byKey(Key('textField')).enterText('test', shouldSubmit: true);
  /// ```
  Future<void> enterText(WidgetTester tester, String text,
      {bool shouldSubmit = true}) async {
    await tester.enterText(this, text);

    if (shouldSubmit) {
      await tester.testTextInput.receiveAction(TextInputAction.done);
    }

    await tester.pumpAndSettle();
  }
}

// extension TesterExtensions on WidgetTester {
//   /// Submits text after typing
//   Future<void> enterAndSubmitText(Finder finder, String text) async {
//     await enterText(finder, text);
//     await testTextInput.receiveAction(TextInputAction.done);
//   }
// }

/// Waits for a tester to complete until a timeout.
///
/// Use this when pumpAndSettle is not waiting long enough for
/// the task to complete.
/// https://github.com/flutter/flutter/issues/88765
Future<void> waitFor(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final end = tester.binding.clock.now().add(timeout);

  do {
    if (tester.binding.clock.now().isAfter(end)) {
      throw Exception('Timed out waiting for $finder');
    }

    await tester.pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 100));
  } while (finder.evaluate().isEmpty);
}
