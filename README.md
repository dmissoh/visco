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

## Publishing to TestFlight

### Prerequisites

- Xcode installed with valid Apple Developer account
- App Store Connect access for the app
- Valid signing certificates and provisioning profiles

### Steps

1. **Bump the version** in `pubspec.yaml`:
   ```yaml
   version: 1.0.1+2  # format: major.minor.patch+buildNumber
   ```
   Increment the build number (`+N`) for each TestFlight upload.

2. **Build the iOS archive**:
   ```bash
   flutter build ipa --release
   ```

3. **Upload to App Store Connect** (choose one method):

   **Option A: Using Transporter app**
   - Open Transporter (download from Mac App Store)
   - Drag and drop the `.ipa` file from `build/ios/ipa/`
   - Click "Deliver"

   **Option B: Using xcrun**
   ```bash
   xcrun altool --upload-app --type ios \
     --file build/ios/ipa/visco.ipa \
     --apiKey YOUR_API_KEY \
     --apiIssuer YOUR_ISSUER_ID
   ```

   **Option C: Using Xcode**
   - Open `ios/Runner.xcworkspace` in Xcode
   - Product > Archive
   - Distribute App > App Store Connect > Upload

4. **Wait for processing** (5-15 minutes) in App Store Connect

5. **Add to TestFlight testing**:
   - Go to App Store Connect > TestFlight
   - Select the new build
   - Add to internal/external testers

### Troubleshooting

- If signing fails, run: `cd ios && pod install && cd ..`
- For code signing issues, check Xcode > Preferences > Accounts
- Ensure build number is higher than any previous upload

## License

MIT
