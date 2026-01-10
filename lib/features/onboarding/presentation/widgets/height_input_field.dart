import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

class HeightInputField extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const HeightInputField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<HeightInputField> createState() => _HeightInputFieldState();
}

class _HeightInputFieldState extends State<HeightInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.heightWithUnit('cm'),
          style: AppTypography.caption(color: colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          onChanged: (value) {
            final parsed = double.tryParse(value);
            if (parsed != null && parsed > 0) {
              widget.onChanged(parsed);
            }
          },
          decoration: InputDecoration(
            suffixText: 'cm',
            suffixStyle: AppTypography.body(color: colors.textSecondary),
          ),
          style: AppTypography.body(color: colors.textPrimary),
        ),
      ],
    );
  }
}
