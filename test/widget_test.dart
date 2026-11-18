import 'package:flutter_test/flutter_test.dart';

import 'package:cancelr/app.dart';
import 'package:cancelr/data/sample_data.dart';
import 'package:cancelr/models/subscription.dart';

void main() {
  setUp(SampleData.reset);

  testWidgets('app starts on Login and reaches Home', (tester) async {
    await tester.pumpWidget(const CancelrApp());
    expect(find.text('LOGIN'), findsOneWidget);

    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    expect(find.text('CANCELR'), findsOneWidget);
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
