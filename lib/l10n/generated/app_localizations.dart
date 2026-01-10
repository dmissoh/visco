import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Visqo'**
  String get appTitle;

  /// No description provided for @navCalculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get navCalculate;

  /// No description provided for @navWhatIf.
  ///
  /// In en, this message translates to:
  /// **'What-If'**
  String get navWhatIf;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Visqo'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your personal visceral fat tracker'**
  String get welcomeSubtitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @skipAndExplore.
  ///
  /// In en, this message translates to:
  /// **'Skip and explore'**
  String get skipAndExplore;

  /// No description provided for @whatIsVatTitle.
  ///
  /// In en, this message translates to:
  /// **'What is Visceral Fat?'**
  String get whatIsVatTitle;

  /// No description provided for @hiddenFatTitle.
  ///
  /// In en, this message translates to:
  /// **'Hidden Fat'**
  String get hiddenFatTitle;

  /// No description provided for @hiddenFatDesc.
  ///
  /// In en, this message translates to:
  /// **'Visceral fat is stored deep inside your abdomen, surrounding vital organs like the liver, stomach, and intestines.'**
  String get hiddenFatDesc;

  /// No description provided for @healthRisksTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Risks'**
  String get healthRisksTitle;

  /// No description provided for @healthRisksDesc.
  ///
  /// In en, this message translates to:
  /// **'High levels are linked to increased risk of heart disease, type 2 diabetes, and metabolic syndrome.'**
  String get healthRisksDesc;

  /// No description provided for @notVisibleTitle.
  ///
  /// In en, this message translates to:
  /// **'Not Always Visible'**
  String get notVisibleTitle;

  /// No description provided for @notVisibleDesc.
  ///
  /// In en, this message translates to:
  /// **'Unlike subcutaneous fat (under the skin), visceral fat can be high even in people who appear slim.'**
  String get notVisibleDesc;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @howItWorksTitle.
  ///
  /// In en, this message translates to:
  /// **'How Visqo Works'**
  String get howItWorksTitle;

  /// No description provided for @stepMeasure.
  ///
  /// In en, this message translates to:
  /// **'Measure'**
  String get stepMeasure;

  /// No description provided for @stepMeasureDesc.
  ///
  /// In en, this message translates to:
  /// **'Take simple body measurements: waist and thigh circumference.'**
  String get stepMeasureDesc;

  /// No description provided for @stepCalculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get stepCalculate;

  /// No description provided for @stepCalculateDesc.
  ///
  /// In en, this message translates to:
  /// **'Visqo uses a scientifically validated formula to estimate your visceral fat area.'**
  String get stepCalculateDesc;

  /// No description provided for @stepTrack.
  ///
  /// In en, this message translates to:
  /// **'Track'**
  String get stepTrack;

  /// No description provided for @stepTrackDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor your progress over time with charts and trends.'**
  String get stepTrackDesc;

  /// No description provided for @scientificNote.
  ///
  /// In en, this message translates to:
  /// **'Based on peer-reviewed research with 80-84% accuracy compared to CT scans.'**
  String get scientificNote;

  /// No description provided for @setUpProfile.
  ///
  /// In en, this message translates to:
  /// **'Set Up Profile'**
  String get setUpProfile;

  /// No description provided for @profileSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s set up your profile'**
  String get profileSetupTitle;

  /// No description provided for @profileSetupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This information is used to calculate your visceral fat accurately.'**
  String get profileSetupSubtitle;

  /// No description provided for @newProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'New Profile'**
  String get newProfileTitle;

  /// No description provided for @createNewProfile.
  ///
  /// In en, this message translates to:
  /// **'Create a new profile'**
  String get createNewProfile;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Profile Name'**
  String get profileName;

  /// No description provided for @profileNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., John, Mom, Dad'**
  String get profileNameHint;

  /// No description provided for @pleaseEnterProfileName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a profile name'**
  String get pleaseEnterProfileName;

  /// No description provided for @createProfile.
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get createProfile;

  /// No description provided for @startTracking.
  ///
  /// In en, this message translates to:
  /// **'Start Tracking'**
  String get startTracking;

  /// No description provided for @sexLabel.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get sexLabel;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @createProfileToStart.
  ///
  /// In en, this message translates to:
  /// **'Create a Profile to Start'**
  String get createProfileToStart;

  /// No description provided for @createProfileExplanation.
  ///
  /// In en, this message translates to:
  /// **'To calculate your visceral fat, we need some basic information about you like your sex, age, and height.'**
  String get createProfileExplanation;

  /// No description provided for @todaysMeasurements.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Measurements'**
  String get todaysMeasurements;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @enterWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter weight'**
  String get enterWeight;

  /// No description provided for @waistCircumference.
  ///
  /// In en, this message translates to:
  /// **'Waist Circumference'**
  String get waistCircumference;

  /// No description provided for @enterWaist.
  ///
  /// In en, this message translates to:
  /// **'Enter waist'**
  String get enterWaist;

  /// No description provided for @thighCircumference.
  ///
  /// In en, this message translates to:
  /// **'Thigh Circumference'**
  String get thighCircumference;

  /// No description provided for @enterThigh.
  ///
  /// In en, this message translates to:
  /// **'Enter thigh'**
  String get enterThigh;

  /// No description provided for @calculateAndSave.
  ///
  /// In en, this message translates to:
  /// **'Calculate & Save'**
  String get calculateAndSave;

  /// No description provided for @noPreviousMeasurements.
  ///
  /// In en, this message translates to:
  /// **'No previous measurements'**
  String get noPreviousMeasurements;

  /// No description provided for @measured.
  ///
  /// In en, this message translates to:
  /// **'Measured'**
  String get measured;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @viewHealthInsights.
  ///
  /// In en, this message translates to:
  /// **'View Health Insights'**
  String get viewHealthInsights;

  /// No description provided for @viewProgressChart.
  ///
  /// In en, this message translates to:
  /// **'View Progress Chart'**
  String get viewProgressChart;

  /// No description provided for @shareResult.
  ///
  /// In en, this message translates to:
  /// **'Share Result'**
  String get shareResult;

  /// No description provided for @visceralFatTrend.
  ///
  /// In en, this message translates to:
  /// **'Visceral Fat Trend'**
  String get visceralFatTrend;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @noMeasurementsYet.
  ///
  /// In en, this message translates to:
  /// **'No measurements yet'**
  String get noMeasurementsYet;

  /// No description provided for @startTrackingToSeeProgress.
  ///
  /// In en, this message translates to:
  /// **'Start tracking to see your progress'**
  String get startTrackingToSeeProgress;

  /// No description provided for @doctorsReport.
  ///
  /// In en, this message translates to:
  /// **'Doctor\'s Report'**
  String get doctorsReport;

  /// No description provided for @olderMeasurements.
  ///
  /// In en, this message translates to:
  /// **'{count} older measurements'**
  String olderMeasurements(int count);

  /// No description provided for @unlockFullProgress.
  ///
  /// In en, this message translates to:
  /// **'Unlock to see your full progress'**
  String get unlockFullProgress;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @profiles.
  ///
  /// In en, this message translates to:
  /// **'Profiles'**
  String get profiles;

  /// No description provided for @addProfile.
  ///
  /// In en, this message translates to:
  /// **'Add Profile'**
  String get addProfile;

  /// No description provided for @currentProfile.
  ///
  /// In en, this message translates to:
  /// **'Current Profile'**
  String get currentProfile;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @ageYears.
  ///
  /// In en, this message translates to:
  /// **'{age} years'**
  String ageYears(int age);

  /// No description provided for @deleteProfile.
  ///
  /// In en, this message translates to:
  /// **'Delete Profile'**
  String get deleteProfile;

  /// No description provided for @deleteProfileConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\" and all their measurements? This cannot be undone.'**
  String deleteProfileConfirmation(String name);

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @vatGoal.
  ///
  /// In en, this message translates to:
  /// **'VAT Goal'**
  String get vatGoal;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @setVatGoal.
  ///
  /// In en, this message translates to:
  /// **'Set VAT Goal'**
  String get setVatGoal;

  /// No description provided for @setVatGoalDescription.
  ///
  /// In en, this message translates to:
  /// **'Set a target visceral fat area to track on your progress chart.'**
  String get setVatGoalDescription;

  /// No description provided for @goalHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 100'**
  String get goalHint;

  /// No description provided for @goalTip.
  ///
  /// In en, this message translates to:
  /// **'Tip: Below 100 cm² is considered healthy'**
  String get goalTip;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get units;

  /// No description provided for @metric.
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get metric;

  /// No description provided for @metricUnits.
  ///
  /// In en, this message translates to:
  /// **'kg, cm'**
  String get metricUnits;

  /// No description provided for @imperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial'**
  String get imperial;

  /// No description provided for @imperialUnits.
  ///
  /// In en, this message translates to:
  /// **'lbs, inches'**
  String get imperialUnits;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @measurementReminder.
  ///
  /// In en, this message translates to:
  /// **'Measurement Reminder'**
  String get measurementReminder;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @noRemindersScheduled.
  ///
  /// In en, this message translates to:
  /// **'No reminders scheduled'**
  String get noRemindersScheduled;

  /// No description provided for @everyDayAt.
  ///
  /// In en, this message translates to:
  /// **'Every {day} at {time}'**
  String everyDayAt(String day, String time);

  /// No description provided for @everyOrdinalAt.
  ///
  /// In en, this message translates to:
  /// **'Every {ordinal} at {time}'**
  String everyOrdinalAt(String ordinal, String time);

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @dayOfWeek.
  ///
  /// In en, this message translates to:
  /// **'Day of Week'**
  String get dayOfWeek;

  /// No description provided for @dayOfMonth.
  ///
  /// In en, this message translates to:
  /// **'Day of Month'**
  String get dayOfMonth;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @followSystemSettings.
  ///
  /// In en, this message translates to:
  /// **'Follow system settings'**
  String get followSystemSettings;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @alwaysLightTheme.
  ///
  /// In en, this message translates to:
  /// **'Always use light theme'**
  String get alwaysLightTheme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @alwaysDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Always use dark theme'**
  String get alwaysDarkTheme;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @resetAllData.
  ///
  /// In en, this message translates to:
  /// **'Reset All Data'**
  String get resetAllData;

  /// No description provided for @deleteAllProfilesAndMeasurements.
  ///
  /// In en, this message translates to:
  /// **'Delete all profiles and measurements'**
  String get deleteAllProfilesAndMeasurements;

  /// No description provided for @resetAllDataConfirmation.
  ///
  /// In en, this message translates to:
  /// **'This will delete ALL profiles and measurements. You will need to set up a new profile. This cannot be undone.'**
  String get resetAllDataConfirmation;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @developerOptions.
  ///
  /// In en, this message translates to:
  /// **'Developer Options'**
  String get developerOptions;

  /// No description provided for @premiumStatusOverride.
  ///
  /// In en, this message translates to:
  /// **'Premium Status Override'**
  String get premiumStatusOverride;

  /// No description provided for @simulatingPremium.
  ///
  /// In en, this message translates to:
  /// **'Simulating Premium'**
  String get simulatingPremium;

  /// No description provided for @simulatingFree.
  ///
  /// In en, this message translates to:
  /// **'Simulating Free'**
  String get simulatingFree;

  /// No description provided for @usingRealStatus.
  ///
  /// In en, this message translates to:
  /// **'Using Real Status'**
  String get usingRealStatus;

  /// No description provided for @actual.
  ///
  /// In en, this message translates to:
  /// **'actual'**
  String get actual;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @real.
  ///
  /// In en, this message translates to:
  /// **'Real'**
  String get real;

  /// No description provided for @pro.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get pro;

  /// No description provided for @multipleProfiles.
  ///
  /// In en, this message translates to:
  /// **'Multiple Profiles'**
  String get multipleProfiles;

  /// No description provided for @unlimitedHistory.
  ///
  /// In en, this message translates to:
  /// **'Unlimited History'**
  String get unlimitedHistory;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @aboutVisqo.
  ///
  /// In en, this message translates to:
  /// **'About Visqo'**
  String get aboutVisqo;

  /// No description provided for @aboutVisqoDescription.
  ///
  /// In en, this message translates to:
  /// **'Visqo helps you estimate your visceral fat using simple body measurements. Visceral fat is the fat stored around your internal organs and is linked to increased health risks. By tracking your measurements over time, you can monitor your progress toward a healthier body composition.'**
  String get aboutVisqoDescription;

  /// No description provided for @howToMeasureWaist.
  ///
  /// In en, this message translates to:
  /// **'How to Measure Waist Circumference'**
  String get howToMeasureWaist;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructions;

  /// No description provided for @waistStep1.
  ///
  /// In en, this message translates to:
  /// **'Stand upright with your feet together and arms relaxed at your sides.'**
  String get waistStep1;

  /// No description provided for @waistStep2.
  ///
  /// In en, this message translates to:
  /// **'Locate the bottom of your ribs and the top of your hip bones (iliac crest).'**
  String get waistStep2;

  /// No description provided for @waistStep3.
  ///
  /// In en, this message translates to:
  /// **'Place the tape measure midway between these two points, roughly at your navel level.'**
  String get waistStep3;

  /// No description provided for @waistStep4.
  ///
  /// In en, this message translates to:
  /// **'Wrap the tape around your waist, keeping it parallel to the floor.'**
  String get waistStep4;

  /// No description provided for @waistStep5.
  ///
  /// In en, this message translates to:
  /// **'Breathe out normally and take the reading without pulling the tape too tight.'**
  String get waistStep5;

  /// No description provided for @waistTip.
  ///
  /// In en, this message translates to:
  /// **'Measure directly on skin or over light clothing for accuracy.'**
  String get waistTip;

  /// No description provided for @howToMeasureThigh.
  ///
  /// In en, this message translates to:
  /// **'How to Measure Thigh Circumference'**
  String get howToMeasureThigh;

  /// No description provided for @thighStep1.
  ///
  /// In en, this message translates to:
  /// **'Stand upright with your weight evenly distributed on both legs.'**
  String get thighStep1;

  /// No description provided for @thighStep2.
  ///
  /// In en, this message translates to:
  /// **'Identify the gluteal crease (the fold where your buttock meets your thigh).'**
  String get thighStep2;

  /// No description provided for @thighStep3.
  ///
  /// In en, this message translates to:
  /// **'Position the tape measure just below (distal to) the gluteal crease.'**
  String get thighStep3;

  /// No description provided for @thighStep4.
  ///
  /// In en, this message translates to:
  /// **'Wrap the tape horizontally around your thigh, keeping it perpendicular to the thigh axis.'**
  String get thighStep4;

  /// No description provided for @thighStep5.
  ///
  /// In en, this message translates to:
  /// **'Keep your muscles relaxed and read the measurement without compressing the skin.'**
  String get thighStep5;

  /// No description provided for @thighTip.
  ///
  /// In en, this message translates to:
  /// **'Measure both thighs and use the average if they differ significantly.'**
  String get thighTip;

  /// No description provided for @settingGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Setting a Goal'**
  String get settingGoalTitle;

  /// No description provided for @settingGoalStep1.
  ///
  /// In en, this message translates to:
  /// **'Go to Settings from the calculator screen.'**
  String get settingGoalStep1;

  /// No description provided for @settingGoalStep2.
  ///
  /// In en, this message translates to:
  /// **'Tap on \"Set VAT Goal\" in the Goals section.'**
  String get settingGoalStep2;

  /// No description provided for @settingGoalStep3.
  ///
  /// In en, this message translates to:
  /// **'Enter your target VAT value and save.'**
  String get settingGoalStep3;

  /// No description provided for @settingGoalDescription.
  ///
  /// In en, this message translates to:
  /// **'You can set a personal VAT goal to help track your progress toward a healthier body composition.'**
  String get settingGoalDescription;

  /// No description provided for @goalChartDescription.
  ///
  /// In en, this message translates to:
  /// **'Once set, your goal will appear as a green dashed line on the progress chart, helping you visualize how close you are to your target.'**
  String get goalChartDescription;

  /// No description provided for @goalHealthTip.
  ///
  /// In en, this message translates to:
  /// **'A VAT below 100 cm² is generally considered healthy. Consult a healthcare provider for personalized advice.'**
  String get goalHealthTip;

  /// No description provided for @trendIndicatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Understanding the Trend Indicator'**
  String get trendIndicatorTitle;

  /// No description provided for @trendIndicatorDescription.
  ///
  /// In en, this message translates to:
  /// **'The trend indicator shows how your VAT has changed compared to your previous measurement.'**
  String get trendIndicatorDescription;

  /// No description provided for @trendDecreasing.
  ///
  /// In en, this message translates to:
  /// **'Decreasing'**
  String get trendDecreasing;

  /// No description provided for @trendDecreasingDesc.
  ///
  /// In en, this message translates to:
  /// **'Your VAT is lower than before. Great progress toward reducing visceral fat.'**
  String get trendDecreasingDesc;

  /// No description provided for @trendIncreasing.
  ///
  /// In en, this message translates to:
  /// **'Increasing'**
  String get trendIncreasing;

  /// No description provided for @trendIncreasingDesc.
  ///
  /// In en, this message translates to:
  /// **'Your VAT is higher than before. Consider reviewing your diet and exercise routine.'**
  String get trendIncreasingDesc;

  /// No description provided for @trendStable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get trendStable;

  /// No description provided for @trendStableDesc.
  ///
  /// In en, this message translates to:
  /// **'Your VAT has changed less than 1 cm². Your levels are holding steady.'**
  String get trendStableDesc;

  /// No description provided for @trendMagnitudeNote.
  ///
  /// In en, this message translates to:
  /// **'The trend indicator also displays the exact change in VAT (e.g., -5.2) so you can see the magnitude of the difference.'**
  String get trendMagnitudeNote;

  /// No description provided for @calculationTitle.
  ///
  /// In en, this message translates to:
  /// **'How is Visceral Fat Calculated?'**
  String get calculationTitle;

  /// No description provided for @calculationDescription.
  ///
  /// In en, this message translates to:
  /// **'Visqo uses the Samouda Anthropometric Model to estimate visceral adipose tissue (VAT) area without requiring expensive imaging like CT scans or MRI.'**
  String get calculationDescription;

  /// No description provided for @calculationModelDescription.
  ///
  /// In en, this message translates to:
  /// **'The model uses simple body measurements combined with your age and BMI to predict VAT with high accuracy:'**
  String get calculationModelDescription;

  /// No description provided for @formulaForMen.
  ///
  /// In en, this message translates to:
  /// **'For Men'**
  String get formulaForMen;

  /// No description provided for @formulaMen.
  ///
  /// In en, this message translates to:
  /// **'VAT = 6 x Waist - 4.41 x Thigh + 1.19 x Age - 213.65'**
  String get formulaMen;

  /// No description provided for @accuracyMen.
  ///
  /// In en, this message translates to:
  /// **'Explains 80.3% of VAT variance'**
  String get accuracyMen;

  /// No description provided for @formulaForWomen.
  ///
  /// In en, this message translates to:
  /// **'For Women'**
  String get formulaForWomen;

  /// No description provided for @formulaWomen.
  ///
  /// In en, this message translates to:
  /// **'VAT = 2.15 x Waist - 3.63 x Thigh + 1.46 x Age + 6.22 x BMI - 92.713'**
  String get formulaWomen;

  /// No description provided for @accuracyWomen.
  ///
  /// In en, this message translates to:
  /// **'Explains 83.6% of VAT variance'**
  String get accuracyWomen;

  /// No description provided for @resultUnit.
  ///
  /// In en, this message translates to:
  /// **'The result is expressed in cm², representing the estimated cross-sectional area of visceral fat tissue.'**
  String get resultUnit;

  /// No description provided for @understandingResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Understanding Your Results'**
  String get understandingResultsTitle;

  /// No description provided for @resultsIntro.
  ///
  /// In en, this message translates to:
  /// **'Your VAT result is categorized into three risk levels:'**
  String get resultsIntro;

  /// No description provided for @riskHealthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get riskHealthy;

  /// No description provided for @riskHealthyRange.
  ///
  /// In en, this message translates to:
  /// **'Less than 100 cm²'**
  String get riskHealthyRange;

  /// No description provided for @riskHealthyDesc.
  ///
  /// In en, this message translates to:
  /// **'Normal visceral fat levels associated with lower health risks.'**
  String get riskHealthyDesc;

  /// No description provided for @riskElevated.
  ///
  /// In en, this message translates to:
  /// **'Elevated'**
  String get riskElevated;

  /// No description provided for @riskElevatedRange.
  ///
  /// In en, this message translates to:
  /// **'100 - 130 cm²'**
  String get riskElevatedRange;

  /// No description provided for @riskElevatedDesc.
  ///
  /// In en, this message translates to:
  /// **'Moderately elevated levels. Consider lifestyle changes.'**
  String get riskElevatedDesc;

  /// No description provided for @riskHighRisk.
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get riskHighRisk;

  /// No description provided for @riskHighRiskRange.
  ///
  /// In en, this message translates to:
  /// **'Greater than 130 cm²'**
  String get riskHighRiskRange;

  /// No description provided for @riskHighRiskDesc.
  ///
  /// In en, this message translates to:
  /// **'High visceral fat associated with increased metabolic health risks.'**
  String get riskHighRiskDesc;

  /// No description provided for @learnMoreHealthRisks.
  ///
  /// In en, this message translates to:
  /// **'Learn More About Health Risks & Tips'**
  String get learnMoreHealthRisks;

  /// No description provided for @learnMoreHealthRisksDesc.
  ///
  /// In en, this message translates to:
  /// **'Understand the health implications and evidence-based ways to reduce visceral fat.'**
  String get learnMoreHealthRisksDesc;

  /// No description provided for @scientificReference.
  ///
  /// In en, this message translates to:
  /// **'Scientific Reference'**
  String get scientificReference;

  /// No description provided for @referenceIntro.
  ///
  /// In en, this message translates to:
  /// **'The calculation method used in this app is based on peer-reviewed research:'**
  String get referenceIntro;

  /// No description provided for @referenceAuthors.
  ///
  /// In en, this message translates to:
  /// **'Samouda, H., Dutour, A., Chaumoitre, K., Panuel, M., Dutour, O., & Dadoun, F.'**
  String get referenceAuthors;

  /// No description provided for @referenceTitle.
  ///
  /// In en, this message translates to:
  /// **'VAT=TAAT-SAAT: innovative anthropometric model to predict visceral adipose tissue without resort to CT-Scan or DXA.'**
  String get referenceTitle;

  /// No description provided for @referenceJournal.
  ///
  /// In en, this message translates to:
  /// **'Obesity (2013), 21(1), E41-E50.'**
  String get referenceJournal;

  /// No description provided for @healthInsights.
  ///
  /// In en, this message translates to:
  /// **'Health Insights'**
  String get healthInsights;

  /// No description provided for @aboutVisceralFat.
  ///
  /// In en, this message translates to:
  /// **'About Visceral Fat'**
  String get aboutVisceralFat;

  /// No description provided for @aboutVisceralFatDescription.
  ///
  /// In en, this message translates to:
  /// **'Visceral fat is stored deep within the abdominal cavity around internal organs. Unlike subcutaneous fat, it plays a hormonally active role and is linked to increased health risks. Learn about the risks and evidence-based ways to reduce it.'**
  String get aboutVisceralFatDescription;

  /// No description provided for @healthRisksOfElevatedVat.
  ///
  /// In en, this message translates to:
  /// **'Health Risks of Elevated Visceral Fat'**
  String get healthRisksOfElevatedVat;

  /// No description provided for @healthRisksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Understanding the risks can help motivate positive changes'**
  String get healthRisksSubtitle;

  /// No description provided for @evidenceBasedTips.
  ///
  /// In en, this message translates to:
  /// **'Evidence-Based Tips'**
  String get evidenceBasedTips;

  /// No description provided for @evidenceBasedTipsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Simple actions to help reduce visceral fat'**
  String get evidenceBasedTipsSubtitle;

  /// No description provided for @recommendedForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommended for You'**
  String get recommendedForYou;

  /// No description provided for @maintainYourHealth.
  ///
  /// In en, this message translates to:
  /// **'Maintain Your Health'**
  String get maintainYourHealth;

  /// No description provided for @additionalTips.
  ///
  /// In en, this message translates to:
  /// **'Additional Tips'**
  String get additionalTips;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'This information is for educational purposes only and should not replace professional medical advice. Please consult a healthcare provider for personalized guidance.'**
  String get disclaimer;

  /// No description provided for @riskCardiometabolic.
  ///
  /// In en, this message translates to:
  /// **'Cardiometabolic Disease'**
  String get riskCardiometabolic;

  /// No description provided for @riskCardiometabolicDesc.
  ///
  /// In en, this message translates to:
  /// **'Elevated visceral fat significantly increases the risk of developing serious cardiovascular and metabolic conditions.'**
  String get riskCardiometabolicDesc;

  /// No description provided for @riskCardiometabolicDetail1.
  ///
  /// In en, this message translates to:
  /// **'Increased risk of type 2 diabetes through insulin resistance'**
  String get riskCardiometabolicDetail1;

  /// No description provided for @riskCardiometabolicDetail2.
  ///
  /// In en, this message translates to:
  /// **'Higher likelihood of hypertension (high blood pressure)'**
  String get riskCardiometabolicDetail2;

  /// No description provided for @riskCardiometabolicDetail3.
  ///
  /// In en, this message translates to:
  /// **'Unfavorable cholesterol profile (dyslipidemia)'**
  String get riskCardiometabolicDetail3;

  /// No description provided for @riskCardiometabolicDetail4.
  ///
  /// In en, this message translates to:
  /// **'Greater risk of coronary heart disease and heart failure'**
  String get riskCardiometabolicDetail4;

  /// No description provided for @riskStrokeMortality.
  ///
  /// In en, this message translates to:
  /// **'Stroke and Mortality'**
  String get riskStrokeMortality;

  /// No description provided for @riskStrokeMortalityDesc.
  ///
  /// In en, this message translates to:
  /// **'Higher visceral fat levels are associated with increased stroke risk and may contribute to higher all-cause mortality.'**
  String get riskStrokeMortalityDesc;

  /// No description provided for @riskStrokeMortalityDetail1.
  ///
  /// In en, this message translates to:
  /// **'Elevated risk of ischemic stroke'**
  String get riskStrokeMortalityDetail1;

  /// No description provided for @riskStrokeMortalityDetail2.
  ///
  /// In en, this message translates to:
  /// **'Association with higher all-cause mortality rates'**
  String get riskStrokeMortalityDetail2;

  /// No description provided for @riskStrokeMortalityDetail3.
  ///
  /// In en, this message translates to:
  /// **'Risk persists even at normal BMI levels'**
  String get riskStrokeMortalityDetail3;

  /// No description provided for @riskInflammation.
  ///
  /// In en, this message translates to:
  /// **'Chronic Inflammation'**
  String get riskInflammation;

  /// No description provided for @riskInflammationDesc.
  ///
  /// In en, this message translates to:
  /// **'Visceral fat tissue actively secretes inflammatory molecules that promote systemic inflammation throughout the body.'**
  String get riskInflammationDesc;

  /// No description provided for @riskInflammationDetail1.
  ///
  /// In en, this message translates to:
  /// **'Secretes inflammatory cytokines (IL-6, TNF-alpha)'**
  String get riskInflammationDetail1;

  /// No description provided for @riskInflammationDetail2.
  ///
  /// In en, this message translates to:
  /// **'Disrupts normal hormone signaling'**
  String get riskInflammationDetail2;

  /// No description provided for @riskInflammationDetail3.
  ///
  /// In en, this message translates to:
  /// **'Creates low-level chronic inflammation'**
  String get riskInflammationDetail3;

  /// No description provided for @riskInflammationDetail4.
  ///
  /// In en, this message translates to:
  /// **'Inflammation is a risk factor for many chronic diseases'**
  String get riskInflammationDetail4;

  /// No description provided for @riskLiver.
  ///
  /// In en, this message translates to:
  /// **'Non-Alcoholic Fatty Liver Disease'**
  String get riskLiver;

  /// No description provided for @riskLiverDesc.
  ///
  /// In en, this message translates to:
  /// **'Visceral fat accumulation is strongly correlated with fat infiltration in the liver and elevated liver enzymes.'**
  String get riskLiverDesc;

  /// No description provided for @riskLiverDetail1.
  ///
  /// In en, this message translates to:
  /// **'Fat deposits in liver tissue (hepatic steatosis)'**
  String get riskLiverDetail1;

  /// No description provided for @riskLiverDetail2.
  ///
  /// In en, this message translates to:
  /// **'Elevated liver enzyme levels (ALT, AST)'**
  String get riskLiverDetail2;

  /// No description provided for @riskLiverDetail3.
  ///
  /// In en, this message translates to:
  /// **'Can progress to more serious liver conditions'**
  String get riskLiverDetail3;

  /// No description provided for @riskLiverDetail4.
  ///
  /// In en, this message translates to:
  /// **'Often reversible with lifestyle changes'**
  String get riskLiverDetail4;

  /// No description provided for @riskMetabolicSyndrome.
  ///
  /// In en, this message translates to:
  /// **'Metabolic Syndrome'**
  String get riskMetabolicSyndrome;

  /// No description provided for @riskMetabolicSyndromeDesc.
  ///
  /// In en, this message translates to:
  /// **'Visceral adiposity is a core driver of metabolic syndrome, a cluster of conditions that increase disease risk.'**
  String get riskMetabolicSyndromeDesc;

  /// No description provided for @riskMetabolicSyndromeDetail1.
  ///
  /// In en, this message translates to:
  /// **'Elevated blood sugar levels'**
  String get riskMetabolicSyndromeDetail1;

  /// No description provided for @riskMetabolicSyndromeDetail2.
  ///
  /// In en, this message translates to:
  /// **'High blood pressure'**
  String get riskMetabolicSyndromeDetail2;

  /// No description provided for @riskMetabolicSyndromeDetail3.
  ///
  /// In en, this message translates to:
  /// **'Abnormal cholesterol levels'**
  String get riskMetabolicSyndromeDetail3;

  /// No description provided for @riskMetabolicSyndromeDetail4.
  ///
  /// In en, this message translates to:
  /// **'Central obesity (excess waist fat)'**
  String get riskMetabolicSyndromeDetail4;

  /// No description provided for @riskMetabolicSyndromeDetail5.
  ///
  /// In en, this message translates to:
  /// **'Significantly increases heart disease and diabetes risk'**
  String get riskMetabolicSyndromeDetail5;

  /// No description provided for @riskCancer.
  ///
  /// In en, this message translates to:
  /// **'Cancer Associations'**
  String get riskCancer;

  /// No description provided for @riskCancerDesc.
  ///
  /// In en, this message translates to:
  /// **'Emerging evidence links visceral fat with metabolic dysregulation and higher risk for certain cancers.'**
  String get riskCancerDesc;

  /// No description provided for @riskCancerDetail1.
  ///
  /// In en, this message translates to:
  /// **'Altered hormone signaling may promote cancer growth'**
  String get riskCancerDetail1;

  /// No description provided for @riskCancerDetail2.
  ///
  /// In en, this message translates to:
  /// **'Chronic inflammation creates favorable environment for cancer'**
  String get riskCancerDetail2;

  /// No description provided for @riskCancerDetail3.
  ///
  /// In en, this message translates to:
  /// **'Associated with certain malignancies'**
  String get riskCancerDetail3;

  /// No description provided for @riskCancerDetail4.
  ///
  /// In en, this message translates to:
  /// **'Research ongoing to understand mechanisms'**
  String get riskCancerDetail4;

  /// No description provided for @tipActivity.
  ///
  /// In en, this message translates to:
  /// **'Regular Physical Activity'**
  String get tipActivity;

  /// No description provided for @tipActivityDesc.
  ///
  /// In en, this message translates to:
  /// **'Consistent aerobic exercise and strength training are among the most effective ways to reduce visceral fat.'**
  String get tipActivityDesc;

  /// No description provided for @tipActivityAction1.
  ///
  /// In en, this message translates to:
  /// **'Aim for 150+ minutes per week of moderate-intensity aerobic activity'**
  String get tipActivityAction1;

  /// No description provided for @tipActivityAction2.
  ///
  /// In en, this message translates to:
  /// **'Include 2 or more days per week of strength training'**
  String get tipActivityAction2;

  /// No description provided for @tipActivityAction3.
  ///
  /// In en, this message translates to:
  /// **'Walking, cycling, swimming, and jogging are excellent choices'**
  String get tipActivityAction3;

  /// No description provided for @tipActivityAction4.
  ///
  /// In en, this message translates to:
  /// **'Strength training helps maintain lean muscle mass'**
  String get tipActivityAction4;

  /// No description provided for @tipDiet.
  ///
  /// In en, this message translates to:
  /// **'Balanced, Nutrient-Dense Diet'**
  String get tipDiet;

  /// No description provided for @tipDietDesc.
  ///
  /// In en, this message translates to:
  /// **'Focus on whole foods and limit processed foods to help reduce visceral fat accumulation.'**
  String get tipDietDesc;

  /// No description provided for @tipDietAction1.
  ///
  /// In en, this message translates to:
  /// **'Emphasize vegetables, fruits, and whole grains'**
  String get tipDietAction1;

  /// No description provided for @tipDietAction2.
  ///
  /// In en, this message translates to:
  /// **'Choose lean proteins (fish, poultry, legumes)'**
  String get tipDietAction2;

  /// No description provided for @tipDietAction3.
  ///
  /// In en, this message translates to:
  /// **'Limit added sugars and refined carbohydrates'**
  String get tipDietAction3;

  /// No description provided for @tipDietAction4.
  ///
  /// In en, this message translates to:
  /// **'Reduce intake of highly processed foods'**
  String get tipDietAction4;

  /// No description provided for @tipDietAction5.
  ///
  /// In en, this message translates to:
  /// **'Choose healthy fats (olive oil, nuts, avocado)'**
  String get tipDietAction5;

  /// No description provided for @tipWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight Management'**
  String get tipWeight;

  /// No description provided for @tipWeightDesc.
  ///
  /// In en, this message translates to:
  /// **'Maintaining a healthy weight through sustainable calorie control helps reduce visceral fat stores.'**
  String get tipWeightDesc;

  /// No description provided for @tipWeightAction1.
  ///
  /// In en, this message translates to:
  /// **'Create a modest calorie deficit for gradual weight loss'**
  String get tipWeightAction1;

  /// No description provided for @tipWeightAction2.
  ///
  /// In en, this message translates to:
  /// **'Track waist circumference as a progress indicator'**
  String get tipWeightAction2;

  /// No description provided for @tipWeightAction3.
  ///
  /// In en, this message translates to:
  /// **'Monitor waist-to-height ratio (aim for < 0.5)'**
  String get tipWeightAction3;

  /// No description provided for @tipWeightAction4.
  ///
  /// In en, this message translates to:
  /// **'Focus on sustainable changes, not crash diets'**
  String get tipWeightAction4;

  /// No description provided for @tipSedentary.
  ///
  /// In en, this message translates to:
  /// **'Reduce Sedentary Time'**
  String get tipSedentary;

  /// No description provided for @tipSedentaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Breaking up prolonged sitting with light movement contributes to overall energy expenditure.'**
  String get tipSedentaryDesc;

  /// No description provided for @tipSedentaryAction1.
  ///
  /// In en, this message translates to:
  /// **'Stand up and move every 30-60 minutes'**
  String get tipSedentaryAction1;

  /// No description provided for @tipSedentaryAction2.
  ///
  /// In en, this message translates to:
  /// **'Take walking breaks during work'**
  String get tipSedentaryAction2;

  /// No description provided for @tipSedentaryAction3.
  ///
  /// In en, this message translates to:
  /// **'Use a standing desk when possible'**
  String get tipSedentaryAction3;

  /// No description provided for @tipSedentaryAction4.
  ///
  /// In en, this message translates to:
  /// **'Choose stairs over elevators'**
  String get tipSedentaryAction4;

  /// No description provided for @tipSedentaryAction5.
  ///
  /// In en, this message translates to:
  /// **'Even light activity helps reduce visceral fat'**
  String get tipSedentaryAction5;

  /// No description provided for @tipSleepStress.
  ///
  /// In en, this message translates to:
  /// **'Quality Sleep and Stress Management'**
  String get tipSleepStress;

  /// No description provided for @tipSleepStressDesc.
  ///
  /// In en, this message translates to:
  /// **'Poor sleep and chronic stress raise cortisol, a hormone linked to abdominal fat accumulation.'**
  String get tipSleepStressDesc;

  /// No description provided for @tipSleepStressAction1.
  ///
  /// In en, this message translates to:
  /// **'Aim for 7-9 hours of quality sleep per night'**
  String get tipSleepStressAction1;

  /// No description provided for @tipSleepStressAction2.
  ///
  /// In en, this message translates to:
  /// **'Maintain a consistent sleep schedule'**
  String get tipSleepStressAction2;

  /// No description provided for @tipSleepStressAction3.
  ///
  /// In en, this message translates to:
  /// **'Practice stress-reducing activities (meditation, yoga)'**
  String get tipSleepStressAction3;

  /// No description provided for @tipSleepStressAction4.
  ///
  /// In en, this message translates to:
  /// **'Limit screen time before bed'**
  String get tipSleepStressAction4;

  /// No description provided for @tipSleepStressAction5.
  ///
  /// In en, this message translates to:
  /// **'Address sources of chronic stress'**
  String get tipSleepStressAction5;

  /// No description provided for @tipAlcohol.
  ///
  /// In en, this message translates to:
  /// **'Limit Alcohol Consumption'**
  String get tipAlcohol;

  /// No description provided for @tipAlcoholDesc.
  ///
  /// In en, this message translates to:
  /// **'Alcohol adds calories and may promote visceral fat accumulation when consumed regularly in excess.'**
  String get tipAlcoholDesc;

  /// No description provided for @tipAlcoholAction1.
  ///
  /// In en, this message translates to:
  /// **'Limit to moderate consumption (1 drink/day women, 2/day men)'**
  String get tipAlcoholAction1;

  /// No description provided for @tipAlcoholAction2.
  ///
  /// In en, this message translates to:
  /// **'Choose lower-calorie options when drinking'**
  String get tipAlcoholAction2;

  /// No description provided for @tipAlcoholAction3.
  ///
  /// In en, this message translates to:
  /// **'Avoid binge drinking episodes'**
  String get tipAlcoholAction3;

  /// No description provided for @tipAlcoholAction4.
  ///
  /// In en, this message translates to:
  /// **'Consider alcohol-free days each week'**
  String get tipAlcoholAction4;

  /// No description provided for @tipSmoking.
  ///
  /// In en, this message translates to:
  /// **'Smoking Cessation'**
  String get tipSmoking;

  /// No description provided for @tipSmokingDesc.
  ///
  /// In en, this message translates to:
  /// **'Smoking is associated with central fat accumulation and amplifies cardiometabolic risk.'**
  String get tipSmokingDesc;

  /// No description provided for @tipSmokingAction1.
  ///
  /// In en, this message translates to:
  /// **'Quit smoking to reduce visceral fat accumulation'**
  String get tipSmokingAction1;

  /// No description provided for @tipSmokingAction2.
  ///
  /// In en, this message translates to:
  /// **'Seek support programs or medications if needed'**
  String get tipSmokingAction2;

  /// No description provided for @tipSmokingAction3.
  ///
  /// In en, this message translates to:
  /// **'Benefits begin within days of quitting'**
  String get tipSmokingAction3;

  /// No description provided for @tipSmokingAction4.
  ///
  /// In en, this message translates to:
  /// **'Reduces overall cardiovascular risk significantly'**
  String get tipSmokingAction4;

  /// No description provided for @waist.
  ///
  /// In en, this message translates to:
  /// **'Waist'**
  String get waist;

  /// No description provided for @proximalThigh.
  ///
  /// In en, this message translates to:
  /// **'Proximal Thigh'**
  String get proximalThigh;

  /// No description provided for @lowerRib.
  ///
  /// In en, this message translates to:
  /// **'Lower rib'**
  String get lowerRib;

  /// No description provided for @hipBone.
  ///
  /// In en, this message translates to:
  /// **'Hip bone'**
  String get hipBone;

  /// No description provided for @midpoint.
  ///
  /// In en, this message translates to:
  /// **'Midpoint'**
  String get midpoint;

  /// No description provided for @glutealCrease.
  ///
  /// In en, this message translates to:
  /// **'Gluteal crease'**
  String get glutealCrease;

  /// No description provided for @justBelowCrease.
  ///
  /// In en, this message translates to:
  /// **'Just below crease'**
  String get justBelowCrease;

  /// No description provided for @errorStartingApp.
  ///
  /// In en, this message translates to:
  /// **'Error starting app: {error}\n\nPlease reinstall the app.'**
  String errorStartingApp(String error);

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @howToMeasureWaistShort.
  ///
  /// In en, this message translates to:
  /// **'How to Measure Waist'**
  String get howToMeasureWaistShort;

  /// No description provided for @howToMeasureThighShort.
  ///
  /// In en, this message translates to:
  /// **'How to Measure Thigh'**
  String get howToMeasureThighShort;

  /// No description provided for @guideWaistStep1.
  ///
  /// In en, this message translates to:
  /// **'Stand relaxed, feet together'**
  String get guideWaistStep1;

  /// No description provided for @guideWaistStep2.
  ///
  /// In en, this message translates to:
  /// **'Wrap tape horizontally at navel (belly button) level'**
  String get guideWaistStep2;

  /// No description provided for @guideWaistStep3.
  ///
  /// In en, this message translates to:
  /// **'Keep tape snug but not tight'**
  String get guideWaistStep3;

  /// No description provided for @guideWaistStep4.
  ///
  /// In en, this message translates to:
  /// **'Measure at end of normal exhale'**
  String get guideWaistStep4;

  /// No description provided for @guideThighStep1.
  ///
  /// In en, this message translates to:
  /// **'Stand straight with feet shoulder-width apart'**
  String get guideThighStep1;

  /// No description provided for @guideThighStep2.
  ///
  /// In en, this message translates to:
  /// **'Measure at the proximal thigh (just below the gluteal fold)'**
  String get guideThighStep2;

  /// No description provided for @guideThighStep3.
  ///
  /// In en, this message translates to:
  /// **'Wrap tape around the thigh horizontally'**
  String get guideThighStep3;

  /// No description provided for @guideThighStep4.
  ///
  /// In en, this message translates to:
  /// **'Keep tape snug but not compressing'**
  String get guideThighStep4;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @healthTrajectory.
  ///
  /// In en, this message translates to:
  /// **'Health Trajectory'**
  String get healthTrajectory;

  /// No description provided for @directionDecreasing.
  ///
  /// In en, this message translates to:
  /// **'decreasing'**
  String get directionDecreasing;

  /// No description provided for @directionIncreasing.
  ///
  /// In en, this message translates to:
  /// **'increasing'**
  String get directionIncreasing;

  /// No description provided for @goalEtaMessage.
  ///
  /// In en, this message translates to:
  /// **'At this rate, you\'ll reach your goal in ~{eta}'**
  String goalEtaMessage(String eta);

  /// No description provided for @unlockProjection.
  ///
  /// In en, this message translates to:
  /// **'Unlock to see your 12-month projection'**
  String get unlockProjection;

  /// No description provided for @noDataToDisplay.
  ///
  /// In en, this message translates to:
  /// **'No data to display'**
  String get noDataToDisplay;

  /// No description provided for @minValue.
  ///
  /// In en, this message translates to:
  /// **'Min {value} {unit}'**
  String minValue(int value, String unit);

  /// No description provided for @maxValue.
  ///
  /// In en, this message translates to:
  /// **'Max {value} {unit}'**
  String maxValue(int value, String unit);

  /// No description provided for @yourVisceralFatIs.
  ///
  /// In en, this message translates to:
  /// **'Your visceral fat is {level}'**
  String yourVisceralFatIs(String level);

  /// No description provided for @yourVisceralFatIsPrefix.
  ///
  /// In en, this message translates to:
  /// **'Your visceral fat is '**
  String get yourVisceralFatIsPrefix;

  /// No description provided for @actionItems.
  ///
  /// In en, this message translates to:
  /// **'Action Items'**
  String get actionItems;

  /// No description provided for @riskHigh.
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get riskHigh;

  /// No description provided for @riskElevatedRisk.
  ///
  /// In en, this message translates to:
  /// **'Elevated Risk'**
  String get riskElevatedRisk;

  /// No description provided for @riskModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get riskModerate;

  /// No description provided for @bmiUnderweight.
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get bmiUnderweight;

  /// No description provided for @bmiNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get bmiNormal;

  /// No description provided for @bmiOverweight.
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get bmiOverweight;

  /// No description provided for @bmiObese.
  ///
  /// In en, this message translates to:
  /// **'Obese'**
  String get bmiObese;

  /// No description provided for @bodyMassIndex.
  ///
  /// In en, this message translates to:
  /// **'Body Mass Index'**
  String get bodyMassIndex;

  /// No description provided for @visceralObesity.
  ///
  /// In en, this message translates to:
  /// **'Visceral Obesity'**
  String get visceralObesity;

  /// No description provided for @visceralFatArea.
  ///
  /// In en, this message translates to:
  /// **'Visceral Fat Area'**
  String get visceralFatArea;

  /// No description provided for @measurementsUsed.
  ///
  /// In en, this message translates to:
  /// **'Measurements Used'**
  String get measurementsUsed;

  /// No description provided for @heightWithUnit.
  ///
  /// In en, this message translates to:
  /// **'Height ({unit})'**
  String heightWithUnit(String unit);

  /// No description provided for @riskScaleHealthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get riskScaleHealthy;

  /// No description provided for @riskScaleElevated.
  ///
  /// In en, this message translates to:
  /// **'Elevated'**
  String get riskScaleElevated;

  /// No description provided for @riskScaleObesity.
  ///
  /// In en, this message translates to:
  /// **'Obesity'**
  String get riskScaleObesity;

  /// No description provided for @yourVatValue.
  ///
  /// In en, this message translates to:
  /// **'You: {value} cm²'**
  String yourVatValue(String value);

  /// No description provided for @vatSummaryHealthyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Visceral Fat is Healthy'**
  String get vatSummaryHealthyTitle;

  /// No description provided for @vatSummaryHealthyDescImproving.
  ///
  /// In en, this message translates to:
  /// **'Great progress! Your visceral fat is in a healthy range and continuing to improve. Keep up your healthy habits.'**
  String get vatSummaryHealthyDescImproving;

  /// No description provided for @vatSummaryHealthyDesc.
  ///
  /// In en, this message translates to:
  /// **'Your visceral fat is in a healthy range. Maintain your current lifestyle to keep it that way.'**
  String get vatSummaryHealthyDesc;

  /// No description provided for @vatSummaryElevatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Visceral Fat is Elevated'**
  String get vatSummaryElevatedTitle;

  /// No description provided for @vatSummaryElevatedDescImproving.
  ///
  /// In en, this message translates to:
  /// **'You\'re making progress! While your visceral fat is still elevated, the trend is improving. Keep following the tips below.'**
  String get vatSummaryElevatedDescImproving;

  /// No description provided for @vatSummaryElevatedDesc.
  ///
  /// In en, this message translates to:
  /// **'Your visceral fat is moderately elevated, which may increase health risks. Consider the evidence-based tips below to help reduce it.'**
  String get vatSummaryElevatedDesc;

  /// No description provided for @vatSummaryHighTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Visceral Fat is High'**
  String get vatSummaryHighTitle;

  /// No description provided for @vatSummaryHighDescImproving.
  ///
  /// In en, this message translates to:
  /// **'You\'re on the right track! Your visceral fat is high but improving. Continue with your efforts and consult a healthcare provider for personalized guidance.'**
  String get vatSummaryHighDescImproving;

  /// No description provided for @vatSummaryHighDesc.
  ///
  /// In en, this message translates to:
  /// **'Your visceral fat level indicates increased health risks. We recommend reviewing the information below and consulting with a healthcare provider.'**
  String get vatSummaryHighDesc;

  /// No description provided for @vatSummaryNoMeasurementTitle.
  ///
  /// In en, this message translates to:
  /// **'No Measurement Available'**
  String get vatSummaryNoMeasurementTitle;

  /// No description provided for @vatSummaryNoMeasurementDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete a VAT measurement to see personalized health insights.'**
  String get vatSummaryNoMeasurementDesc;

  /// No description provided for @improving.
  ///
  /// In en, this message translates to:
  /// **'Improving'**
  String get improving;

  /// No description provided for @whatIfCalculator.
  ///
  /// In en, this message translates to:
  /// **'What-If Calculator'**
  String get whatIfCalculator;

  /// No description provided for @createProfileFirst.
  ///
  /// In en, this message translates to:
  /// **'Create a Profile First'**
  String get createProfileFirst;

  /// No description provided for @whatIfNeedsProfile.
  ///
  /// In en, this message translates to:
  /// **'The What-If calculator needs your profile information to simulate results. Please create a profile first.'**
  String get whatIfNeedsProfile;

  /// No description provided for @simulateInstructions.
  ///
  /// In en, this message translates to:
  /// **'Simulate different scenarios to plan your goals. Results are not saved.'**
  String get simulateInstructions;

  /// No description provided for @enterMeasurements.
  ///
  /// In en, this message translates to:
  /// **'Enter Measurements'**
  String get enterMeasurements;

  /// No description provided for @targetWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get targetWeight;

  /// No description provided for @enterTargetWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter target weight'**
  String get enterTargetWeight;

  /// No description provided for @targetWaist.
  ///
  /// In en, this message translates to:
  /// **'Waist Circumference'**
  String get targetWaist;

  /// No description provided for @enterTargetWaist.
  ///
  /// In en, this message translates to:
  /// **'Enter target waist'**
  String get enterTargetWaist;

  /// No description provided for @targetThigh.
  ///
  /// In en, this message translates to:
  /// **'Thigh Circumference'**
  String get targetThigh;

  /// No description provided for @enterTargetThigh.
  ///
  /// In en, this message translates to:
  /// **'Enter target thigh'**
  String get enterTargetThigh;

  /// No description provided for @simulate.
  ///
  /// In en, this message translates to:
  /// **'Simulate'**
  String get simulate;

  /// No description provided for @simulatedResult.
  ///
  /// In en, this message translates to:
  /// **'Simulated Result'**
  String get simulatedResult;

  /// No description provided for @wouldAchieveGoal.
  ///
  /// In en, this message translates to:
  /// **'This would achieve your goal!'**
  String get wouldAchieveGoal;

  /// No description provided for @aboveGoal.
  ///
  /// In en, this message translates to:
  /// **'{value} cm² above goal'**
  String aboveGoal(String value);

  /// No description provided for @yourGoalValue.
  ///
  /// In en, this message translates to:
  /// **'Your goal: {value} cm²'**
  String yourGoalValue(String value);

  /// No description provided for @whatIfTip.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting weight or waist to see how it affects your VAT'**
  String get whatIfTip;

  /// No description provided for @waistWithValue.
  ///
  /// In en, this message translates to:
  /// **'Waist: {value} cm'**
  String waistWithValue(String value);

  /// No description provided for @categoryCardiometabolic.
  ///
  /// In en, this message translates to:
  /// **'Cardiometabolic'**
  String get categoryCardiometabolic;

  /// No description provided for @categoryStrokeMortality.
  ///
  /// In en, this message translates to:
  /// **'Stroke & Mortality'**
  String get categoryStrokeMortality;

  /// No description provided for @categoryInflammation.
  ///
  /// In en, this message translates to:
  /// **'Inflammation'**
  String get categoryInflammation;

  /// No description provided for @categoryLiverDisease.
  ///
  /// In en, this message translates to:
  /// **'Liver Disease'**
  String get categoryLiverDisease;

  /// No description provided for @categoryMetabolicSyndrome.
  ///
  /// In en, this message translates to:
  /// **'Metabolic Syndrome'**
  String get categoryMetabolicSyndrome;

  /// No description provided for @categoryCancer.
  ///
  /// In en, this message translates to:
  /// **'Cancer'**
  String get categoryCancer;

  /// No description provided for @categoryPhysicalActivity.
  ///
  /// In en, this message translates to:
  /// **'Physical Activity'**
  String get categoryPhysicalActivity;

  /// No description provided for @categoryDiet.
  ///
  /// In en, this message translates to:
  /// **'Diet'**
  String get categoryDiet;

  /// No description provided for @categoryWeightManagement.
  ///
  /// In en, this message translates to:
  /// **'Weight Management'**
  String get categoryWeightManagement;

  /// No description provided for @categoryLifestyle.
  ///
  /// In en, this message translates to:
  /// **'Lifestyle'**
  String get categoryLifestyle;

  /// No description provided for @categorySleepStress.
  ///
  /// In en, this message translates to:
  /// **'Sleep & Stress'**
  String get categorySleepStress;

  /// No description provided for @categoryAlcohol.
  ///
  /// In en, this message translates to:
  /// **'Alcohol'**
  String get categoryAlcohol;

  /// No description provided for @categorySmoking.
  ///
  /// In en, this message translates to:
  /// **'Smoking'**
  String get categorySmoking;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
