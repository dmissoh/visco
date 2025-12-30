import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';

/// Professional PDF export service for generating Doctor's Reports
class PdfExportService {
  static const _primaryColor = PdfColor.fromInt(0xFF2383E2);
  static const _successColor = PdfColor.fromInt(0xFF0F7B6C);
  static const _warningColor = PdfColor.fromInt(0xFFC77D00);
  static const _dangerColor = PdfColor.fromInt(0xFFE03E3E);

  /// Export multiple measurements as a Doctor's Report
  static Future<void> exportMeasurements({
    required UserProfile profile,
    required List<Measurement> measurements,
  }) async {
    final pdf = pw.Document(
      title: "Doctor's Report - Visceral Fat Assessment",
      author: 'Visqo App',
      subject: 'Visceral Adipose Tissue Assessment Report',
    );
    final dateFormat = DateFormat('dd/MM/yyyy');
    final now = DateTime.now();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => _buildDocumentHeader(profile, now),
        footer: (context) => _buildDocumentFooter(context),
        build: (context) => [
          pw.SizedBox(height: 20),
          _buildPatientInfoSection(profile),
          pw.SizedBox(height: 24),
          _buildClinicalSummary(measurements),
          pw.SizedBox(height: 24),
          _buildMeasurementsTable(measurements, dateFormat),
          pw.SizedBox(height: 24),
          _buildRiskInterpretation(),
          pw.SizedBox(height: 24),
          _buildMethodologyNote(),
        ],
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'doctors_report_${profile.name.toLowerCase().replaceAll(' ', '_')}_${DateFormat('yyyyMMdd').format(now)}.pdf',
    );
  }

  /// Export a single measurement as a Doctor's Report
  static Future<void> exportSingleMeasurement({
    required UserProfile profile,
    required Measurement measurement,
  }) async {
    final pdf = pw.Document(
      title: "Doctor's Report - Visceral Fat Assessment",
      author: 'Visqo App',
      subject: 'Visceral Adipose Tissue Assessment Report',
    );
    final dateFormat = DateFormat('dd/MM/yyyy');
    final now = DateTime.now();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildDocumentHeader(profile, now),
            pw.SizedBox(height: 20),
            _buildPatientInfoSection(profile),
            pw.SizedBox(height: 24),
            _buildSingleResultSection(measurement, dateFormat),
            pw.SizedBox(height: 24),
            _buildRiskInterpretation(),
            pw.Spacer(),
            _buildMethodologyNote(),
            pw.SizedBox(height: 16),
            _buildSinglePageFooter(),
          ],
        ),
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'doctors_report_${dateFormat.format(measurement.timestamp).replaceAll('/', '-')}.pdf',
    );
  }

  static pw.Widget _buildDocumentHeader(UserProfile profile, DateTime date) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 16),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: _primaryColor, width: 3)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "DOCTOR'S REPORT",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: _primaryColor,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Visceral Adipose Tissue Assessment',
                style: const pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'Report Date',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
              ),
              pw.Text(
                DateFormat('dd MMMM yyyy').format(date),
                style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPatientInfoSection(UserProfile profile) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'PATIENT INFORMATION',
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.grey700,
              letterSpacing: 1,
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            children: [
              _buildInfoItem('Name', profile.name),
              pw.SizedBox(width: 40),
              _buildInfoItem('Sex', profile.sex == Sex.male ? 'Male' : 'Female'),
              pw.SizedBox(width: 40),
              _buildInfoItem('Age', '${profile.age} years'),
              pw.SizedBox(width: 40),
              _buildInfoItem('Height', '${profile.heightCm.toStringAsFixed(0)} cm'),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildInfoItem(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  static pw.Widget _buildClinicalSummary(List<Measurement> measurements) {
    if (measurements.isEmpty) {
      return pw.Text('No measurements recorded.');
    }

    final latest = measurements.first;
    final oldest = measurements.last;
    final change = measurements.length > 1 ? latest.vatCm2 - oldest.vatCm2 : 0.0;
    final riskColor = _getRiskColor(latest.riskCategory);
    final riskLabel = _getRiskLabel(latest.riskCategory);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'CLINICAL SUMMARY',
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey700,
            letterSpacing: 1,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Main VAT Result
            pw.Expanded(
              flex: 2,
              child: pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: riskColor, width: 2),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Current Visceral Fat Area',
                      style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      '${latest.vatCm2.toStringAsFixed(1)} cm\u00B2',
                      style: pw.TextStyle(fontSize: 32, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: pw.BoxDecoration(
                        color: riskColor,
                        borderRadius: pw.BorderRadius.circular(12),
                      ),
                      child: pw.Text(
                        riskLabel,
                        style: const pw.TextStyle(color: PdfColors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(width: 16),
            // Secondary metrics
            pw.Expanded(
              flex: 3,
              child: pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    _buildMetricItem('BMI', latest.bmi.toStringAsFixed(1), _getBmiStatus(latest.bmi)),
                    _buildMetricItem('Weight', '${latest.weightKg.toStringAsFixed(1)} kg', null),
                    _buildMetricItem('Records', '${measurements.length}', null),
                    if (measurements.length > 1)
                      _buildMetricItem(
                        'Trend',
                        '${change > 0 ? '+' : ''}${change.toStringAsFixed(1)}',
                        change < 0 ? 'Improving' : (change > 0 ? 'Increasing' : 'Stable'),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildMetricItem(String label, String value, String? status) {
    return pw.Column(
      children: [
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
        ),
        if (status != null) ...[
          pw.SizedBox(height: 2),
          pw.Text(
            status,
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
          ),
        ],
      ],
    );
  }

  static String _getBmiStatus(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  static pw.Widget _buildSingleResultSection(Measurement measurement, DateFormat dateFormat) {
    final riskColor = _getRiskColor(measurement.riskCategory);
    final riskLabel = _getRiskLabel(measurement.riskCategory);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'ASSESSMENT RESULTS',
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey700,
            letterSpacing: 1,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Measured on ${dateFormat.format(measurement.timestamp)}',
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 16),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Main Result
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(24),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: riskColor, width: 2),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Visceral Adipose Tissue Area',
                      style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey600),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Text(
                      '${measurement.vatCm2.toStringAsFixed(1)} cm\u00B2',
                      style: pw.TextStyle(fontSize: 36, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: pw.BoxDecoration(
                        color: riskColor,
                        borderRadius: pw.BorderRadius.circular(16),
                      ),
                      child: pw.Text(
                        riskLabel,
                        style: const pw.TextStyle(color: PdfColors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(width: 24),
            // Body Measurements
            pw.Expanded(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  borderRadius: pw.BorderRadius.circular(8),
                  border: pw.Border.all(color: PdfColors.grey200),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Body Measurements',
                      style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 12),
                    _buildMeasurementRow('Weight', '${measurement.weightKg.toStringAsFixed(1)} kg'),
                    pw.Divider(color: PdfColors.grey200),
                    _buildMeasurementRow('Waist Circumference', '${measurement.waistCm.toStringAsFixed(1)} cm'),
                    pw.Divider(color: PdfColors.grey200),
                    _buildMeasurementRow('Thigh Circumference', '${measurement.thighCm.toStringAsFixed(1)} cm'),
                    pw.Divider(color: PdfColors.grey200),
                    _buildMeasurementRow('Body Mass Index', '${measurement.bmi.toStringAsFixed(1)} (${_getBmiStatus(measurement.bmi)})'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildMeasurementsTable(
    List<Measurement> measurements,
    DateFormat dateFormat,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'MEASUREMENT HISTORY',
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey700,
            letterSpacing: 1,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.TableHelper.fromTextArray(
          headerStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 9,
            color: PdfColors.grey800,
          ),
          cellStyle: const pw.TextStyle(fontSize: 9),
          headerDecoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            border: pw.Border.all(color: PdfColors.grey300),
          ),
          cellHeight: 28,
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.center,
            2: pw.Alignment.center,
            3: pw.Alignment.center,
            4: pw.Alignment.center,
            5: pw.Alignment.center,
            6: pw.Alignment.center,
          },
          headers: ['Date', 'VAT (cm\u00B2)', 'Risk', 'BMI', 'Weight', 'Waist', 'Thigh'],
          data: measurements.map((m) => [
            dateFormat.format(m.timestamp),
            m.vatCm2.toStringAsFixed(1),
            _getRiskLabel(m.riskCategory),
            m.bmi.toStringAsFixed(1),
            '${m.weightKg.toStringAsFixed(1)} kg',
            '${m.waistCm.toStringAsFixed(1)} cm',
            '${m.thighCm.toStringAsFixed(1)} cm',
          ]).toList(),
        ),
      ],
    );
  }

  static pw.Widget _buildMeasurementRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
          pw.Text(value, style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  static pw.Widget _buildRiskInterpretation() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: PdfColors.blue100),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'RISK INTERPRETATION GUIDE',
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
              color: _primaryColor,
              letterSpacing: 1,
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            children: [
              _buildRiskLegendItem('Healthy', '< 100 cm\u00B2', _successColor),
              pw.SizedBox(width: 24),
              _buildRiskLegendItem('Elevated', '100-130 cm\u00B2', _warningColor),
              pw.SizedBox(width: 24),
              _buildRiskLegendItem('High Risk', '> 130 cm\u00B2', _dangerColor),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            'Visceral adipose tissue (VAT) accumulation is associated with increased cardiometabolic risk. '
            'Values above 100 cm\u00B2 may warrant lifestyle modifications and medical consultation.',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildRiskLegendItem(String label, String range, PdfColor color) {
    return pw.Row(
      children: [
        pw.Container(
          width: 12,
          height: 12,
          decoration: pw.BoxDecoration(
            color: color,
            borderRadius: pw.BorderRadius.circular(2),
          ),
        ),
        pw.SizedBox(width: 6),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(label, style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
            pw.Text(range, style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600)),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildMethodologyNote() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'METHODOLOGY',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.grey600,
              letterSpacing: 1,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            'This assessment uses the Samouda Anthropometric Model for estimating visceral adipose tissue area. '
            'The model has been validated against CT scan measurements and published in Obesity (2013). '
            'Results should be interpreted by a healthcare professional in conjunction with other clinical findings.',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildDocumentFooter(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: PdfColors.grey300)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Generated by Visqo App',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
          ),
          pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSinglePageFooter() {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: PdfColors.grey300)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Generated by Visqo App',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
          ),
          pw.Text(
            'This report is intended for healthcare professional review.',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
          ),
        ],
      ),
    );
  }

  static PdfColor _getRiskColor(RiskCategory category) {
    return switch (category) {
      RiskCategory.healthy => _successColor,
      RiskCategory.elevated => _warningColor,
      RiskCategory.obesity => _dangerColor,
    };
  }

  static String _getRiskLabel(RiskCategory category) {
    return switch (category) {
      RiskCategory.healthy => 'Healthy',
      RiskCategory.elevated => 'Elevated',
      RiskCategory.obesity => 'High Risk',
    };
  }
}
