# Visco

A Flutter app for estimating visceral adipose tissue (VAT) using the Samouda anthropometric model.

## Features

- Calculate visceral fat from simple body measurements (waist, thigh, weight)
- Track progress over time with charts
- Risk categorization (Healthy, Elevated, High Risk)
- Measurement guides with illustrations

## Calculation Method

Based on [Samouda et al. (2013)](https://pmc.ncbi.nlm.nih.gov/articles/PMC3618381/):

- **Male**: VAT = 6 × Waist - 4.41 × Thigh + 1.19 × Age - 213.65
- **Female**: VAT = 2.15 × Waist - 3.63 × Thigh + 1.46 × Age + 6.22 × BMI - 92.713

## Tech Stack

- Flutter 3.x
- Riverpod (state management)
- Hive (local storage)
- fl_chart (progress visualization)
- GoRouter (navigation)

## Getting Started

```bash
flutter pub get
flutter run
```

## License

MIT
