import 'package:material_ui/material_ui.dart';

import '../data/sample_data.dart';
import '../models/subscription.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_button.dart';
import 'app_text_field.dart';

// Owner: Zeynep
// Shared form for the Add and Edit screens.
class SubscriptionForm extends StatefulWidget {
  const SubscriptionForm({
    super.key,
    this.initial,
    required this.submitLabel,
    required this.onSubmit,
  });

  // Null when adding a new entry, filled when editing.
  final Subscription? initial;
  final String submitLabel;
  final void Function(Subscription entry) onSubmit;

  @override
  State<SubscriptionForm> createState() => _SubscriptionFormState();
}

class _SubscriptionFormState extends State<SubscriptionForm> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;

  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _startController;
  late final TextEditingController _endController;
  late final TextEditingController _linkController;
  late final TextEditingController _notesController;

  late SubscriptionCategory _category;
  late EntryType _type;
  late BillingPeriod _billing;
  late int _reminderDays;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    // In Add screen it opens empty. In Edit screen the form opens filled with the card's info.
    final initial = widget.initial;
    final today = DateTime.now();

    _category = initial?.category ?? SubscriptionCategory.entertainment;
    _type = initial?.type ?? EntryType.freeTrial;
    _billing = initial?.billingPeriod ?? BillingPeriod.monthly;
    _reminderDays = initial?.reminderDaysBefore ?? 3;
    _startDate =
        initial?.startDate ?? DateTime(today.year, today.month, today.day);
    _endDate = initial?.endDate ?? _startDate.add(const Duration(days: 30));

    _nameController = TextEditingController(text: initial?.name ?? '');
    _priceController = TextEditingController(
      text: initial == null ? '' : _formatPrice(initial.price),
    );
    _startController = TextEditingController(text: _formatDate(_startDate));
    _endController = TextEditingController(text: _formatDate(_endDate));
    _linkController =
        TextEditingController(text: initial?.cancellationUrl ?? '');
    _notesController = TextEditingController(text: initial?.notes ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _startController.dispose();
    _endController.dispose();
    _linkController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  //  helpers
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  String _formatDate(DateTime date) =>
      '${date.day} ${_months[date.month - 1]} ${date.year}';
  String _formatPrice(double price) => price == price.roundToDouble()
      ? price.toStringAsFixed(0)
      : price.toStringAsFixed(2);
  double? _parsePrice(String? text) =>
      double.tryParse((text ?? '').trim().replaceAll(',', '.'));
  List<int> get _reminderOptions => {1, 3, 7, _reminderDays}.toList()..sort();

  // When a date field is tapped, opens a calendar to pick the date.
  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked == null) return;

    setState(() {
      if (isStart) {
        _startDate = picked;
        _startController.text = _formatDate(picked);
      } else {
        _endDate = picked;
        _endController.text = _formatDate(picked);
      }
    });
  }

  // validators

  // If the service name is empty, shows an error under the field.
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter a service name';
    return null;
  }

  // If the price is empty, not a number or 0, shows an error.
  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter a price';
    final price = _parsePrice(value);
    if (price == null || price <= 0) return 'Enter a valid price';
    return null;
  }

  // If the end date is before the start date, shows an error.
  String? _validateEndDate(String? _) {
    if (!_endDate.isAfter(_startDate)) return 'Invalid end date';
    return null;
  }

  // Link is optional, but if written it must start with https://
  String? _validateLink(String? value) {
    final link = (value ?? '').trim();
    if (link.isEmpty) return null; // optional field
    if (!link.startsWith('http://') && !link.startsWith('https://')) {
      return 'Start with https://';
    }
    return null;
  }

  //  submit

  // When Save is pressed checks all fields and if there are no errors creates the card.
  void _submit() {
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;

    final link = _linkController.text.trim();
    final notes = _notesController.text.trim();

    final entry = Subscription(
      id: widget.initial?.id ?? SampleData.newId(),
      name: _nameController.text.trim(),
      type: _type,
      category: _category,
      startDate: _startDate,
      endDate: _endDate,
      price: _parsePrice(_priceController.text)!,
      currency: widget.initial?.currency ?? r'$',
      billingPeriod: _billing,
      reminderDaysBefore: _reminderDays,
      status: widget.initial?.status ?? EntryStatus.active,
      cancellationUrl: link.isEmpty ? null : link,
      notes: notes.isEmpty ? null : notes,
      logoUrl: widget.initial?.logoUrl,
    );

    widget.onSubmit(entry);
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _submitted
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Category sets the card color', style: AppTextStyles.label),
          const SizedBox(height: AppSpacing.s),
          // Category buttons: the selected one takes the category color.
          Row(
            children: [
              for (final category in SubscriptionCategory.values) ...[
                Expanded(
                  child: _ChoiceChip(
                    label: category.label,
                    selected: _category == category,
                    selectedColor: category.color,
                    onTap: () => setState(() => _category = category),
                  ),
                ),
                if (category != SubscriptionCategory.values.last)
                  const SizedBox(width: AppSpacing.s),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          // Choose Free trial or Subscription.
          Row(
            children: [
              for (final type in EntryType.values) ...[
                Expanded(
                  child: _ChoiceChip(
                    label: type.label,
                    selected: _type == type,
                    selectedColor: AppColors.textPrimary,
                    onTap: () => setState(() => _type = type),
                  ),
                ),
                if (type != EntryType.values.last)
                  const SizedBox(width: AppSpacing.s),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.l),
          // Service name field (required).
          AppTextField(
            label: 'Service name',
            hint: 'Enter a service name',
            controller: _nameController,
            validator: _validateName,
          ),
          const SizedBox(height: AppSpacing.m),
          // Start and end date fields. Tapping opens the calendar.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Start date',
                  controller: _startController,
                  readOnly: true,
                  onTap: () => _pickDate(isStart: true),
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: AppTextField(
                  label: 'End date',
                  controller: _endController,
                  readOnly: true,
                  onTap: () => _pickDate(isStart: false),
                  validator: _validateEndDate,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          // Price field and billing period (Monthly / Yearly).
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  label: r'Price ($)',
                  hint: '15.00',
                  controller: _priceController,
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  validator: _validatePrice,
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: _LabeledField(
                  label: 'Billing',
                  child: DropdownButtonFormField<BillingPeriod>(
                    initialValue: _billing,
                    isExpanded: true,
                    dropdownColor: AppColors.surface,
                    style: AppTextStyles.body,
                    items: [
                      for (final period in BillingPeriod.values)
                        DropdownMenuItem(
                          value: period,
                          child: Text(period.label),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => _billing = value);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          // How many days before to remind, and the cancellation link.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _LabeledField(
                  label: 'Remind me',
                  child: DropdownButtonFormField<int>(
                    initialValue: _reminderDays,
                    isExpanded: true,
                    dropdownColor: AppColors.surface,
                    style: AppTextStyles.body,
                    items: [
                      for (final days in _reminderOptions)
                        DropdownMenuItem(
                          value: days,
                          child: Text(
                            '$days ${days == 1 ? 'day' : 'days'} before',
                          ),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => _reminderDays = value);
                    },
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: AppTextField(
                  label: 'Cancellation link',
                  hint: 'https://',
                  controller: _linkController,
                  keyboardType: TextInputType.url,
                  validator: _validateLink,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
          // Optional notes.
          AppTextField(
            label: 'Notes (optional)',
            hint: 'Add a note',
            controller: _notesController,
          ),
          const SizedBox(height: AppSpacing.xl),
          // Save button ("Save" in Add, "Save changes" in Edit).
          AppButton(label: widget.submitLabel, onPressed: _submit),
        ],
      ),
    );
  }
}

// Title row with a close button, used at the top of Add and Edit.
class FormHeader extends StatelessWidget {
  const FormHeader({super.key, required this.title, required this.onClose});

  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.screenTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close),
          color: AppColors.textPrimary,
          tooltip: 'Close',
        ),
      ],
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusField),
      child: Container(
        height: AppSpacing.minTapTarget,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
        decoration: BoxDecoration(
          color: selected ? selectedColor : AppColors.background,
          borderRadius: BorderRadius.circular(AppSpacing.radiusField),
          border: Border.all(
            color: selected ? selectedColor : AppColors.outline,
          ),
        ),
        // scaleDown keeps long labels from overflowing on small phones
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: AppTextStyles.bodyStrong.copyWith(
              color: selected ? AppColors.onCard : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.xs),
        child,
      ],
    );
  }
}