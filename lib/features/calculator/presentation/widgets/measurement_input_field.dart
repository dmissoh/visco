import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';

class MeasurementInputField extends StatefulWidget {
  final String label;
  final String unit;
  final String hint;
  final bool showInfoButton;
  final VoidCallback? onInfoPressed;
  final ValueChanged<double?> onChanged;
  final double? minValue;
  final double? maxValue;

  const MeasurementInputField({
    super.key,
    required this.label,
    required this.unit,
    required this.hint,
    this.showInfoButton = false,
    this.onInfoPressed,
    required this.onChanged,
    this.minValue,
    this.maxValue,
  });

  @override
  State<MeasurementInputField> createState() => _MeasurementInputFieldState();
}

class _MeasurementInputFieldState extends State<MeasurementInputField> {
  final _controller = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validate(double? value) {
    if (value == null) return null;
    
    if (widget.minValue != null && value < widget.minValue!) {
      return 'Min ${widget.minValue!.toInt()} ${widget.unit}';
    }
    if (widget.maxValue != null && value > widget.maxValue!) {
      return 'Max ${widget.maxValue!.toInt()} ${widget.unit}';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: AppTypography.caption(color: colors.textSecondary),
            ),
            if (widget.showInfoButton) ...[
              const SizedBox(width: AppSpacing.xs),
              GestureDetector(
                onTap: widget.onInfoPressed,
                child: Icon(
                  Icons.info_outline,
                  size: 18,
                  color: colors.accent,
                ),
              ),
            ],
          ],
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
            final error = _validate(parsed);
            setState(() => _errorText = error);
            // Only pass valid values to parent
            widget.onChanged(error == null ? parsed : null);
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixText: widget.unit,
            suffixStyle: AppTypography.body(color: colors.textSecondary),
            errorText: _errorText,
          ),
          style: AppTypography.body(color: colors.textPrimary),
        ),
      ],
    );
  }
}
