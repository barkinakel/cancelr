import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';

enum EntryType {
  freeTrial('Free trial'),
  subscription('Subscription');

  const EntryType(this.label);
  final String label;
}

enum SubscriptionCategory {
  entertainment('Entertainment', AppColors.entertainment),
  software('Software', AppColors.software),
  education('Education', AppColors.education);

  const SubscriptionCategory(this.label, this.color);
  final String label;
  final Color color;
}

enum BillingPeriod {
  monthly('Monthly'),
  yearly('Yearly');

  const BillingPeriod(this.label);
  final String label;
}

enum EntryStatus { active, kept, cancelled }

class Subscription {
  const Subscription({
    required this.id,
    required this.name,
    required this.type,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.price,
    this.currency = r'$',
    this.billingPeriod = BillingPeriod.monthly,
    this.reminderDaysBefore = 3,
    this.status = EntryStatus.active,
    this.cancellationUrl,
    this.notes,
    this.logoUrl,
  });

  final String id;
  final String name;
  final EntryType type;
  final SubscriptionCategory category;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final String currency;
  final BillingPeriod billingPeriod;
  final int reminderDaysBefore;
  final EntryStatus status;
  final String? cancellationUrl;
  final String? notes;
  final String? logoUrl;

  int daysLeft([DateTime? today]) {
    final now = today ?? DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);
    return end.difference(start).inDays;
  }

  String get priceLabel {
    final amount = price == price.roundToDouble()
        ? price.toStringAsFixed(0)
        : price.toStringAsFixed(2);
    return '$currency$amount';
  }

  double get monthlyCost =>
      billingPeriod == BillingPeriod.yearly ? price / 12 : price;

  Subscription copyWith({
    String? name,
    EntryType? type,
    SubscriptionCategory? category,
    DateTime? startDate,
    DateTime? endDate,
    double? price,
    String? currency,
    BillingPeriod? billingPeriod,
    int? reminderDaysBefore,
    EntryStatus? status,
    String? cancellationUrl,
    String? notes,
    String? logoUrl,
  }) {
    return Subscription(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      billingPeriod: billingPeriod ?? this.billingPeriod,
      reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
      status: status ?? this.status,
      cancellationUrl: cancellationUrl ?? this.cancellationUrl,
      notes: notes ?? this.notes,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }
}
