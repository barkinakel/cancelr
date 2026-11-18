import '../models/subscription.dart';

// Shared list for Step 2.2; Firestore replaces it in Step 3.
// After changing it, call setState on the screen that shows it.
class SampleData {
  SampleData._();

  static List<Subscription> subscriptions = buildSampleSubscriptions();

  static List<Subscription> get upcoming {
    final list = subscriptions
        .where((s) => s.status != EntryStatus.cancelled)
        .toList();
    list.sort((a, b) => a.endDate.compareTo(b.endDate));
    return list;
  }

  static List<Subscription> get cancelled {
    final list = subscriptions
        .where((s) => s.status == EntryStatus.cancelled)
        .toList();
    list.sort((a, b) => b.endDate.compareTo(a.endDate));
    return list;
  }

  static Subscription? byId(String id) {
    for (final s in subscriptions) {
      if (s.id == id) return s;
    }
    return null;
  }

  static double get monthlyTotal {
    double total = 0;
    for (final s in upcoming) {
      total += s.monthlyCost;
    }
    return total;
  }

  static double get savedTotal {
    double total = 0;
    for (final s in cancelled) {
      total += s.monthlyCost;
    }
    return total;
  }

  static void add(Subscription entry) => subscriptions.add(entry);

  static void update(Subscription entry) {
    final index = subscriptions.indexWhere((s) => s.id == entry.id);
    if (index != -1) subscriptions[index] = entry;
  }

  static void remove(String id) => subscriptions.removeWhere((s) => s.id == id);

  static void markCancelled(String id) => _setStatus(id, EntryStatus.cancelled);

  static void markKept(String id) => _setStatus(id, EntryStatus.kept);

  static void _setStatus(String id, EntryStatus status) {
    final entry = byId(id);
    if (entry != null) update(entry.copyWith(status: status));
  }

  static String newId() => DateTime.now().microsecondsSinceEpoch.toString();

  static void reset() => subscriptions = buildSampleSubscriptions();
}

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
