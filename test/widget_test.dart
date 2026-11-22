import 'package:flutter_test/flutter_test.dart';

import 'package:cancelr/app.dart';
import 'package:cancelr/data/sample_data.dart';
import 'package:cancelr/data/user_settings.dart';
import 'package:cancelr/models/subscription.dart';
import 'package:cancelr/utils/validation_utils.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  setUp(() {
    SampleData.reset();
    UserSettings.reset();
  });

  testWidgets('app starts on Login and reaches Home', (tester) async {
    await tester.pumpWidget(const CancelrApp());
    expect(find.text('CANCELR'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'boran@email.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'secret1');
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    expect(find.text('CANCELR'), findsOneWidget);
  });

  testWidgets('login shows inline errors for empty fields', (tester) async {
    await tester.pumpWidget(const CancelrApp());

    await tester.tap(find.text('Log in'));
    await tester.pump();
    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
    expect(find.text('CANCELR'), findsOneWidget);
  });

  test('validation utils check email and passwords', () {
    expect(ValidationUtils.validateEmail('boran@email.com'), isNull);
    expect(ValidationUtils.validateEmail('boran@'), 'Enter a valid email');
    expect(ValidationUtils.validatePassword('123'), isNotNull);
    expect(ValidationUtils.validateConfirmPassword('abc123', 'abc124'),
        'Passwords do not match');
  });

  test('sample data sorts upcoming entries and totals them', () {
    final upcoming = SampleData.upcoming;

    expect(upcoming.first.name, 'Netflix');
    for (var i = 1; i < upcoming.length; i++) {
      expect(upcoming[i - 1].endDate.isAfter(upcoming[i].endDate), isFalse);
    }
    expect(SampleData.monthlyTotal, 48);
    expect(SampleData.savedTotal, 26);

    SampleData.markCancelled('netflix');
    expect(SampleData.cancelled.any((s) => s.id == 'netflix'), isTrue);
    expect(SampleData.monthlyTotal, 33);

    SampleData.remove('spotify');
    expect(SampleData.byId('spotify'), isNull);
  });

  test('daysLeft counts whole days from today', () {
    final today = DateTime(2026, 11, 5, 18);
    final entry = Subscription(
      id: 'x',
      name: 'X',
      type: EntryType.freeTrial,
      category: SubscriptionCategory.software,
      startDate: DateTime(2026, 10, 8),
      endDate: DateTime(2026, 11, 7, 9),
      price: 15,
    );
    expect(entry.daysLeft(today), 2);
  });
}
