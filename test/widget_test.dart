import 'package:flutter_test/flutter_test.dart';

import 'package:cancelr/app.dart';
import 'package:cancelr/data/subscription_store.dart';
import 'package:cancelr/models/subscription.dart';

void main() {
  testWidgets('app starts on Login and reaches Home', (tester) async {
    await tester.pumpWidget(const CancelrApp());
    expect(find.text('LOGIN'), findsOneWidget);

    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    expect(find.text('HOME'), findsOneWidget);
  });

  test('store sorts upcoming entries by nearest date and totals them', () {
    final store = SubscriptionStore();
    final upcoming = store.upcoming;

    expect(upcoming.first.name, 'Netflix');
    for (var i = 1; i < upcoming.length; i++) {
      expect(upcoming[i - 1].endDate.isAfter(upcoming[i].endDate), isFalse);
    }
    expect(store.monthlyTotal, 48);
    expect(store.savedTotal, 26);

    store.markCancelled('netflix');
    expect(store.cancelled.any((s) => s.id == 'netflix'), isTrue);
    expect(store.monthlyTotal, 33);

    store.remove('spotify');
    expect(store.byId('spotify'), isNull);
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
