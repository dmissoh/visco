import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';

class PdfExportService {
  static Future<void> exportMeasurements({
    required UserProfile profile,
    required List<Measurement> measurements,
  }) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('dd/MM/yyyy');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          _buildHeader(profile),
          pw.SizedBox(height: 20),
          _buildSummary(measurements),
          pw.SizedBox(height: 20),
          _buildMeasurementsTable(measurements, dateFormat),
          pw.SizedBox(height: 20),
          _buildFooter(),
        ],
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'visco_${profile.name.toLowerCase().replaceAll(' ', '_')}_${DateFormat('yyyyMMdd').format(DateTime.now())}.pdf',
    );
  }

  static Future<void> exportSingleMeasurement({
    required UserProfile profile,
    required Measurement measurement,
  }) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('dd/MM/yyyy');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(profile),
            pw.SizedBox(height: 30),
            _buildSingleResult(measurement, dateFormat),
            pw.Spacer(),
            _buildFooter(),
          ],
        ),
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'visco_result_${dateFormat.format(measurement.timestamp).replaceAll('/', '-')}.pdf',
    );
  }

  static pw.Widget _buildHeader(UserProfile profile) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Visco - Visceral Fat Report',
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Profile: ${profile.name}',
              style: const pw.TextStyle(fontSize: 14),
            ),
            pw.Text(
              '${profile.sex == Sex.male ? 'Male' : 'Female'}, ${profile.age} years, ${profile.heightCm.toStringAsFixed(0)} cm',
              style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
            ),
          ],
        ),
        pw.Divider(thickness: 2),
      ],
    );
  }

  static pw.Widget _buildSummary(List<Measurement> measurements) {
    if (measurements.isEmpty) {
      return pw.Text('No measurements recorded.');
    }

    final latest = measurements.first;
    final oldest = measurements.last;
    final change = measurements.length > 1
        ? latest.vatCm2 - oldest.vatCm2
        : 0.0;

    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Summary',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('Latest VAT', '${latest.vatCm2.toStringAsFixed(1)} cm\u00B2'),
              _buildSummaryItem('Latest BMI', latest.bmi.toStringAsFixed(1)),
              _buildSummaryItem('Total Records', '${measurements.length}'),
              if (measurements.length > 1)
                _buildSummaryItem(
                  'Change',
                  '${change > 0 ? '+' : ''}${change.toStringAsFixed(1)} cm\u00B2',
                ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSummaryItem(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(
          value,
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
      ],
    );
  }

  static pw.Widget _buildMeasurementsTable(
    List<Measurement> measurements,
    DateFormat dateFormat,
  ) {
    return pw.TableHelper.fromTextArray(
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
        5: pw.Alignment.center,
      },
      headers: ['Date', 'VAT (cm\u00B2)', 'BMI', 'Weight (kg)', 'Waist (cm)', 'Thigh (cm)'],
      data: measurements.map((m) => [
        dateFormat.format(m.timestamp),
        m.vatCm2.toStringAsFixed(1),
        m.bmi.toStringAsFixed(1),
        m.weightKg.toStringAsFixed(1),
        m.waistCm.toStringAsFixed(1),
        m.thighCm.toStringAsFixed(1),
      ]).toList(),
    );
  }

  static pw.Widget _buildSingleResult(Measurement measurement, DateFormat dateFormat) {
    final riskColor = switch (measurement.riskCategory) {
      RiskCategory.healthy => PdfColors.green,
      RiskCategory.elevated => PdfColors.orange,
      RiskCategory.obesity => PdfColors.red,
    };
    final riskLabel = switch (measurement.riskCategory) {
      RiskCategory.healthy => 'Healthy',
      RiskCategory.elevated => 'Elevated',
      RiskCategory.obesity => 'High Risk',
    };

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Measurement Result',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          'Date: ${dateFormat.format(measurement.timestamp)}',
          style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 24),
        pw.Container(
          padding: const pw.EdgeInsets.all(20),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: riskColor, width: 2),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Column(
            children: [
              pw.Text(
                'Visceral Fat Area',
                style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey600),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                '${measurement.vatCm2.toStringAsFixed(1)} cm\u00B2',
                style: pw.TextStyle(fontSize: 36, fontWeight: pw.FontWeight.bold),
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
                  style: const pw.TextStyle(color: PdfColors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 24),
        pw.Text(
          'Measurements',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 12),
        _buildMeasurementRow('Weight', '${measurement.weightKg.toStringAsFixed(1)} kg'),
        _buildMeasurementRow('Waist Circumference', '${measurement.waistCm.toStringAsFixed(1)} cm'),
        _buildMeasurementRow('Thigh Circumference', '${measurement.thighCm.toStringAsFixed(1)} cm'),
        _buildMeasurementRow('BMI', measurement.bmi.toStringAsFixed(1)),
      ],
    );
  }

  static pw.Widget _buildMeasurementRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(color: PdfColors.grey700)),
          pw.Text(value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Divider(),
        pw.SizedBox(height: 8),
        pw.Text(
          'Generated by Visco - Visceral Fat Calculator',
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Based on the Samouda Anthropometric Model (Obesity 2013)',
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey400),
        ),
      ],
    );
  }
}
