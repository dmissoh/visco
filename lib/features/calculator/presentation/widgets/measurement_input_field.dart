import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';

enum MeasurementType { weight, length }

class MeasurementInputField extends StatefulWidget {
  final String label;
  final String unit;
  final String hint;
  final bool showInfoButton;
  final VoidCallback? onInfoPressed;
  final ValueChanged<double?> onChanged;
  final double? minValue;
  final double? maxValue;
  final MeasurementType? measurementType;
  final UnitSystem unitSystem;

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
    this.measurementType,
    this.unitSystem = UnitSystem.metric,
  });

  @override
  State<MeasurementInputField> createState() => _MeasurementInputFieldState();
}

class _MeasurementInputFieldState extends State<MeasurementInputField> {
  final _controller = TextEditingController();
  String? _errorText;

  String get _displayUnit {
    if (widget.measurementType == null) return widget.unit;
    return widget.measurementType == MeasurementType.weight
        ? UnitConverter.weightUnit(widget.unitSystem)
        : UnitConverter.lengthUnit(widget.unitSystem);
  }

  double? get _displayMinValue {
    if (widget.minValue == null || widget.measurementType == null) return widget.minValue;
    if (widget.unitSystem == UnitSystem.imperial) {
      return widget.measurementType == MeasurementType.weight
          ? UnitConverter.kgToLbs(widget.minValue!)
          : UnitConverter.cmToInches(widget.minValue!);
    }
    return widget.minValue;
  }

  double? get _displayMaxValue {
    if (widget.maxValue == null || widget.measurementType == null) return widget.maxValue;
    if (widget.unitSystem == UnitSystem.imperial) {
      return widget.measurementType == MeasurementType.weight
          ? UnitConverter.kgToLbs(widget.maxValue!)
          : UnitConverter.cmToInches(widget.maxValue!);
    }
    return widget.maxValue;
  }

  double _convertToMetric(double value) {
    if (widget.measurementType == null || widget.unitSystem == UnitSystem.metric) {
      return value;
    }
    return widget.measurementType == MeasurementType.weight
        ? UnitConverter.lbsToKg(value)
        : UnitConverter.inchesToCm(value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validate(double? value) {
    if (value == null) return null;
    
    final minVal = _displayMinValue;
    final maxVal = _displayMaxValue;
    
    if (minVal != null && value < minVal) {
      return 'Min ${minVal.toInt()} $_displayUnit';
    }
    if (maxVal != null && value > maxVal) {
      return 'Max ${maxVal.toInt()} $_displayUnit';
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
            // Convert to metric and pass valid values to parent
            if (error == null && parsed != null) {
              widget.onChanged(_convertToMetric(parsed));
            } else {
              widget.onChanged(null);
            }
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixText: _displayUnit,
            suffixStyle: AppTypography.body(color: colors.textSecondary),
            errorText: _errorText,
          ),
          style: AppTypography.body(color: colors.textPrimary),
        ),
      ],
    );
  }
}
