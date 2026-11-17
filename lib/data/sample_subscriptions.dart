import '../models/subscription.dart';

// Dates are relative to today so "days left" always looks the same.
List<Subscription> buildSampleSubscriptions() {
  final today = DateTime.now();
  DateTime inDays(int days) => today.add(Duration(days: days));

  return [
    Subscription(
      id: 'netflix',
      name: 'Netflix',
      type: EntryType.freeTrial,
      category: SubscriptionCategory.entertainment,
      startDate: inDays(-28),
      endDate: inDays(2),
      price: 15,
      cancellationUrl: 'https://www.netflix.com/cancelplan',
      logoUrl: _logo('netflix.com'),
    ),
    Subscription(
      id: 'spotify',
      name: 'Spotify',
      type: EntryType.freeTrial,
      category: SubscriptionCategory.entertainment,
      startDate: inDays(-25),
      endDate: inDays(5),
      price: 6,
      logoUrl: _logo('spotify.com'),
    ),
    Subscription(
      id: 'adobe',
      name: 'Adobe CC',
      type: EntryType.subscription,
      category: SubscriptionCategory.software,
      startDate: inDays(-18),
      endDate: inDays(12),
      price: 20,
      status: EntryStatus.kept,
      logoUrl: _logo('adobe.com'),
    ),
    Subscription(
      id: 'duolingo',
      name: 'Duolingo',
      type: EntryType.subscription,
      category: SubscriptionCategory.education,
      startDate: inDays(-6),
      endDate: inDays(24),
      price: 7,
      status: EntryStatus.kept,
      logoUrl: _logo('duolingo.com'),
    ),
    Subscription(
      id: 'canva',
      name: 'Canva',
      type: EntryType.freeTrial,
      category: SubscriptionCategory.software,
      startDate: inDays(-40),
      endDate: inDays(-10),
      price: 13,
      status: EntryStatus.cancelled,
      logoUrl: _logo('canva.com'),
    ),
    Subscription(
      id: 'headspace',
      name: 'Headspace',
      type: EntryType.freeTrial,
      category: SubscriptionCategory.education,
      startDate: inDays(-35),
      endDate: inDays(-5),
      price: 13,
      status: EntryStatus.cancelled,
      logoUrl: _logo('headspace.com'),
    ),
  ];
}

String _logo(String domain) =>
    'https://www.google.com/s2/favicons?domain=$domain&sz=128';
