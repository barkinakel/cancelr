import 'package:material_ui/material_ui.dart';

import '../models/subscription.dart';
import 'sample_subscriptions.dart';

// In-memory for now; Firestore in Step 3.
class SubscriptionStore extends ChangeNotifier {
  SubscriptionStore([List<Subscription>? initial])
      : _items = initial ?? buildSampleSubscriptions();

  final List<Subscription> _items;

  static SubscriptionStore of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<SubscriptionScope>();
    assert(scope != null, 'No SubscriptionScope found above this widget.');
    return scope!.notifier!;
  }

  List<Subscription> get upcoming {
    final list = _items
        .where((s) => s.status != EntryStatus.cancelled)
        .toList()
      ..sort((a, b) => a.endDate.compareTo(b.endDate));
    return list;
  }

  List<Subscription> get cancelled {
    final list = _items
        .where((s) => s.status == EntryStatus.cancelled)
        .toList()
      ..sort((a, b) => b.endDate.compareTo(a.endDate));
    return list;
  }

  Subscription? byId(String id) {
    for (final s in _items) {
      if (s.id == id) return s;
    }
    return null;
  }

  double get monthlyTotal =>
      upcoming.fold(0, (sum, s) => sum + s.monthlyCost);

  double get savedTotal => cancelled.fold(0, (sum, s) => sum + s.monthlyCost);

  void add(Subscription entry) {
    _items.add(entry);
    notifyListeners();
  }

  void update(Subscription entry) {
    final index = _items.indexWhere((s) => s.id == entry.id);
    if (index == -1) return;
    _items[index] = entry;
    notifyListeners();
  }

  void remove(String id) {
    _items.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  void markCancelled(String id) => _setStatus(id, EntryStatus.cancelled);

  void markKept(String id) => _setStatus(id, EntryStatus.kept);

  void _setStatus(String id, EntryStatus status) {
    final entry = byId(id);
    if (entry == null) return;
    update(entry.copyWith(status: status));
  }

  String newId() => DateTime.now().microsecondsSinceEpoch.toString();
}

class SubscriptionScope extends InheritedNotifier<SubscriptionStore> {
  const SubscriptionScope({
    super.key,
    required SubscriptionStore store,
    required super.child,
  }) : super(notifier: store);
}
