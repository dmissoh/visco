// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Visqo';

  @override
  String get navCalculate => 'Calculate';

  @override
  String get navWhatIf => 'What-If';

  @override
  String get navProgress => 'Progress';

  @override
  String get navSettings => 'Settings';

  @override
  String get welcomeTitle => 'Welcome to Visqo';

  @override
  String get welcomeSubtitle => 'Your personal visceral fat tracker';

  @override
  String get getStarted => 'Get Started';

  @override
  String get skipAndExplore => 'Skip and explore';

  @override
  String get whatIsVatTitle => 'What is Visceral Fat?';

  @override
  String get hiddenFatTitle => 'Hidden Fat';

  @override
  String get hiddenFatDesc =>
      'Visceral fat is stored deep inside your abdomen, surrounding vital organs like the liver, stomach, and intestines.';

  @override
  String get healthRisksTitle => 'Health Risks';

  @override
  String get healthRisksDesc =>
      'High levels are linked to increased risk of heart disease, type 2 diabetes, and metabolic syndrome.';

  @override
  String get notVisibleTitle => 'Not Always Visible';

  @override
  String get notVisibleDesc =>
      'Unlike subcutaneous fat (under the skin), visceral fat can be high even in people who appear slim.';

  @override
  String get continueButton => 'Continue';

  @override
  String get howItWorksTitle => 'How Visqo Works';

  @override
  String get stepMeasure => 'Measure';

  @override
  String get stepMeasureDesc =>
      'Take simple body measurements: waist and thigh circumference.';

  @override
  String get stepCalculate => 'Calculate';

  @override
  String get stepCalculateDesc =>
      'Visqo uses a scientifically validated formula to estimate your visceral fat area.';

  @override
  String get stepTrack => 'Track';

  @override
  String get stepTrackDesc =>
      'Monitor your progress over time with charts and trends.';

  @override
  String get scientificNote =>
      'Based on peer-reviewed research with 80-84% accuracy compared to CT scans.';

  @override
  String get setUpProfile => 'Set Up Profile';

  @override
  String get profileSetupTitle => 'Let\'s set up your profile';

  @override
  String get profileSetupSubtitle =>
      'This information is used to calculate your visceral fat accurately.';

  @override
  String get newProfileTitle => 'New Profile';

  @override
  String get createNewProfile => 'Create a new profile';

  @override
  String get profileName => 'Profile Name';

  @override
  String get profileNameHint => 'e.g., John, Mom, Dad';

  @override
  String get pleaseEnterProfileName => 'Please enter a profile name';

  @override
  String get createProfile => 'Create Profile';

  @override
  String get startTracking => 'Start Tracking';

  @override
  String get sexLabel => 'Sex';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get height => 'Height';

  @override
  String get createProfileToStart => 'Create a Profile to Start';

  @override
  String get createProfileExplanation =>
      'To calculate your visceral fat, we need some basic information about you like your sex, age, and height.';

  @override
  String get todaysMeasurements => 'Today\'s Measurements';

  @override
  String get weight => 'Weight';

  @override
  String get enterWeight => 'Enter weight';

  @override
  String get waistCircumference => 'Waist Circumference';

  @override
  String get enterWaist => 'Enter waist';

  @override
  String get thighCircumference => 'Thigh Circumference';

  @override
  String get enterThigh => 'Enter thigh';

  @override
  String get calculateAndSave => 'Calculate & Save';

  @override
  String get noPreviousMeasurements => 'No previous measurements';

  @override
  String get measured => 'Measured';

  @override
  String get today => 'Today';

  @override
  String get result => 'Result';

  @override
  String get viewHealthInsights => 'View Health Insights';

  @override
  String get viewProgressChart => 'View Progress Chart';

  @override
  String get shareResult => 'Share Result';

  @override
  String get visceralFatTrend => 'Visceral Fat Trend';

  @override
  String get history => 'History';

  @override
  String get noMeasurementsYet => 'No measurements yet';

  @override
  String get startTrackingToSeeProgress =>
      'Start tracking to see your progress';

  @override
  String get doctorsReport => 'Doctor\'s Report';

  @override
  String olderMeasurements(int count) {
    return '$count older measurements';
  }

  @override
  String get unlockFullProgress => 'Unlock to see your full progress';

  @override
  String get settings => 'Settings';

  @override
  String get profiles => 'Profiles';

  @override
  String get addProfile => 'Add Profile';

  @override
  String get currentProfile => 'Current Profile';

  @override
  String get age => 'Age';

  @override
  String get years => 'years';

  @override
  String ageYears(int age) {
    return '$age years';
  }

  @override
  String get deleteProfile => 'Delete Profile';

  @override
  String deleteProfileConfirmation(String name) {
    return 'Delete \"$name\" and all their measurements? This cannot be undone.';
  }

  @override
  String get goals => 'Goals';

  @override
  String get vatGoal => 'VAT Goal';

  @override
  String get notSet => 'Not set';

  @override
  String get setVatGoal => 'Set VAT Goal';

  @override
  String get setVatGoalDescription =>
      'Set a target visceral fat area to track on your progress chart.';

  @override
  String get goalHint => 'e.g., 100';

  @override
  String get goalTip => 'Tip: Below 100 cm² is considered healthy';

  @override
  String get clear => 'Clear';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get units => 'Units';

  @override
  String get metric => 'Metric';

  @override
  String get metricUnits => 'kg, cm';

  @override
  String get imperial => 'Imperial';

  @override
  String get imperialUnits => 'lbs, inches';

  @override
  String get reminders => 'Reminders';

  @override
  String get measurementReminder => 'Measurement Reminder';

  @override
  String get frequency => 'Frequency';

  @override
  String get off => 'Off';

  @override
  String get weekly => 'Weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get noRemindersScheduled => 'No reminders scheduled';

  @override
  String everyDayAt(String day, String time) {
    return 'Every $day at $time';
  }

  @override
  String everyOrdinalAt(String ordinal, String time) {
    return 'Every $ordinal at $time';
  }

  @override
  String get time => 'Time';

  @override
  String get dayOfWeek => 'Day of Week';

  @override
  String get dayOfMonth => 'Day of Month';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get appearance => 'Appearance';

  @override
  String get system => 'System';

  @override
  String get followSystemSettings => 'Follow system settings';

  @override
  String get light => 'Light';

  @override
  String get alwaysLightTheme => 'Always use light theme';

  @override
  String get dark => 'Dark';

  @override
  String get alwaysDarkTheme => 'Always use dark theme';

  @override
  String get data => 'Data';

  @override
  String get resetAllData => 'Reset All Data';

  @override
  String get deleteAllProfilesAndMeasurements =>
      'Delete all profiles and measurements';

  @override
  String get resetAllDataConfirmation =>
      'This will delete ALL profiles and measurements. You will need to set up a new profile. This cannot be undone.';

  @override
  String get reset => 'Reset';

  @override
  String get delete => 'Delete';

  @override
  String get developerOptions => 'Developer Options';

  @override
  String get premiumStatusOverride => 'Premium Status Override';

  @override
  String get simulatingPremium => 'Simulating Premium';

  @override
  String get simulatingFree => 'Simulating Free';

  @override
  String get usingRealStatus => 'Using Real Status';

  @override
  String get actual => 'actual';

  @override
  String get premium => 'Premium';

  @override
  String get free => 'Free';

  @override
  String get real => 'Real';

  @override
  String get pro => 'PRO';

  @override
  String get multipleProfiles => 'Multiple Profiles';

  @override
  String get unlimitedHistory => 'Unlimited History';

  @override
  String get help => 'Help';

  @override
  String get aboutVisqo => 'About Visqo';

  @override
  String get aboutVisqoDescription =>
      'Visqo helps you estimate your visceral fat using simple body measurements. Visceral fat is the fat stored around your internal organs and is linked to increased health risks. By tracking your measurements over time, you can monitor your progress toward a healthier body composition.';

  @override
  String get howToMeasureWaist => 'How to Measure Waist Circumference';

  @override
  String get instructions => 'Instructions';

  @override
  String get waistStep1 =>
      'Stand upright with your feet together and arms relaxed at your sides.';

  @override
  String get waistStep2 =>
      'Locate the bottom of your ribs and the top of your hip bones (iliac crest).';

  @override
  String get waistStep3 =>
      'Place the tape measure midway between these two points, roughly at your navel level.';

  @override
  String get waistStep4 =>
      'Wrap the tape around your waist, keeping it parallel to the floor.';

  @override
  String get waistStep5 =>
      'Breathe out normally and take the reading without pulling the tape too tight.';

  @override
  String get waistTip =>
      'Measure directly on skin or over light clothing for accuracy.';

  @override
  String get howToMeasureThigh => 'How to Measure Thigh Circumference';

  @override
  String get thighStep1 =>
      'Stand upright with your weight evenly distributed on both legs.';

  @override
  String get thighStep2 =>
      'Identify the gluteal crease (the fold where your buttock meets your thigh).';

  @override
  String get thighStep3 =>
      'Position the tape measure just below (distal to) the gluteal crease.';

  @override
  String get thighStep4 =>
      'Wrap the tape horizontally around your thigh, keeping it perpendicular to the thigh axis.';

  @override
  String get thighStep5 =>
      'Keep your muscles relaxed and read the measurement without compressing the skin.';

  @override
  String get thighTip =>
      'Measure both thighs and use the average if they differ significantly.';

  @override
  String get settingGoalTitle => 'Setting a Goal';

  @override
  String get settingGoalStep1 => 'Go to Settings from the calculator screen.';

  @override
  String get settingGoalStep2 =>
      'Tap on \"Set VAT Goal\" in the Goals section.';

  @override
  String get settingGoalStep3 => 'Enter your target VAT value and save.';

  @override
  String get settingGoalDescription =>
      'You can set a personal VAT goal to help track your progress toward a healthier body composition.';

  @override
  String get goalChartDescription =>
      'Once set, your goal will appear as a green dashed line on the progress chart, helping you visualize how close you are to your target.';

  @override
  String get goalHealthTip =>
      'A VAT below 100 cm² is generally considered healthy. Consult a healthcare provider for personalized advice.';

  @override
  String get trendIndicatorTitle => 'Understanding the Trend Indicator';

  @override
  String get trendIndicatorDescription =>
      'The trend indicator shows how your VAT has changed compared to your previous measurement.';

  @override
  String get trendDecreasing => 'Decreasing';

  @override
  String get trendDecreasingDesc =>
      'Your VAT is lower than before. Great progress toward reducing visceral fat.';

  @override
  String get trendIncreasing => 'Increasing';

  @override
  String get trendIncreasingDesc =>
      'Your VAT is higher than before. Consider reviewing your diet and exercise routine.';

  @override
  String get trendStable => 'Stable';

  @override
  String get trendStableDesc =>
      'Your VAT has changed less than 1 cm². Your levels are holding steady.';

  @override
  String get trendMagnitudeNote =>
      'The trend indicator also displays the exact change in VAT (e.g., -5.2) so you can see the magnitude of the difference.';

  @override
  String get calculationTitle => 'How is Visceral Fat Calculated?';

  @override
  String get calculationDescription =>
      'Visqo uses the Samouda Anthropometric Model to estimate visceral adipose tissue (VAT) area without requiring expensive imaging like CT scans or MRI.';

  @override
  String get calculationModelDescription =>
      'The model uses simple body measurements combined with your age and BMI to predict VAT with high accuracy:';

  @override
  String get formulaForMen => 'For Men';

  @override
  String get formulaMen =>
      'VAT = 6 x Waist - 4.41 x Thigh + 1.19 x Age - 213.65';

  @override
  String get accuracyMen => 'Explains 80.3% of VAT variance';

  @override
  String get formulaForWomen => 'For Women';

  @override
  String get formulaWomen =>
      'VAT = 2.15 x Waist - 3.63 x Thigh + 1.46 x Age + 6.22 x BMI - 92.713';

  @override
  String get accuracyWomen => 'Explains 83.6% of VAT variance';

  @override
  String get resultUnit =>
      'The result is expressed in cm², representing the estimated cross-sectional area of visceral fat tissue.';

  @override
  String get understandingResultsTitle => 'Understanding Your Results';

  @override
  String get resultsIntro =>
      'Your VAT result is categorized into three risk levels:';

  @override
  String get riskHealthy => 'Healthy';

  @override
  String get riskHealthyRange => 'Less than 100 cm²';

  @override
  String get riskHealthyDesc =>
      'Normal visceral fat levels associated with lower health risks.';

  @override
  String get riskElevated => 'Elevated';

  @override
  String get riskElevatedRange => '100 - 130 cm²';

  @override
  String get riskElevatedDesc =>
      'Moderately elevated levels. Consider lifestyle changes.';

  @override
  String get riskHighRisk => 'High Risk';

  @override
  String get riskHighRiskRange => 'Greater than 130 cm²';

  @override
  String get riskHighRiskDesc =>
      'High visceral fat associated with increased metabolic health risks.';

  @override
  String get learnMoreHealthRisks => 'Learn More About Health Risks & Tips';

  @override
  String get learnMoreHealthRisksDesc =>
      'Understand the health implications and evidence-based ways to reduce visceral fat.';

  @override
  String get scientificReference => 'Scientific Reference';

  @override
  String get referenceIntro =>
      'The calculation method used in this app is based on peer-reviewed research:';

  @override
  String get referenceAuthors =>
      'Samouda, H., Dutour, A., Chaumoitre, K., Panuel, M., Dutour, O., & Dadoun, F.';

  @override
  String get referenceTitle =>
      'VAT=TAAT-SAAT: innovative anthropometric model to predict visceral adipose tissue without resort to CT-Scan or DXA.';

  @override
  String get referenceJournal => 'Obesity (2013), 21(1), E41-E50.';

  @override
  String get healthInsights => 'Health Insights';

  @override
  String get aboutVisceralFat => 'About Visceral Fat';

  @override
  String get aboutVisceralFatDescription =>
      'Visceral fat is stored deep within the abdominal cavity around internal organs. Unlike subcutaneous fat, it plays a hormonally active role and is linked to increased health risks. Learn about the risks and evidence-based ways to reduce it.';

  @override
  String get healthRisksOfElevatedVat =>
      'Health Risks of Elevated Visceral Fat';

  @override
  String get healthRisksSubtitle =>
      'Understanding the risks can help motivate positive changes';

  @override
  String get evidenceBasedTips => 'Evidence-Based Tips';

  @override
  String get evidenceBasedTipsSubtitle =>
      'Simple actions to help reduce visceral fat';

  @override
  String get recommendedForYou => 'Recommended for You';

  @override
  String get maintainYourHealth => 'Maintain Your Health';

  @override
  String get additionalTips => 'Additional Tips';

  @override
  String get disclaimer =>
      'This information is for educational purposes only and should not replace professional medical advice. Please consult a healthcare provider for personalized guidance.';

  @override
  String get riskCardiometabolic => 'Cardiometabolic Disease';

  @override
  String get riskCardiometabolicDesc =>
      'Elevated visceral fat significantly increases the risk of developing serious cardiovascular and metabolic conditions.';

  @override
  String get riskCardiometabolicDetail1 =>
      'Increased risk of type 2 diabetes through insulin resistance';

  @override
  String get riskCardiometabolicDetail2 =>
      'Higher likelihood of hypertension (high blood pressure)';

  @override
  String get riskCardiometabolicDetail3 =>
      'Unfavorable cholesterol profile (dyslipidemia)';

  @override
  String get riskCardiometabolicDetail4 =>
      'Greater risk of coronary heart disease and heart failure';

  @override
  String get riskStrokeMortality => 'Stroke and Mortality';

  @override
  String get riskStrokeMortalityDesc =>
      'Higher visceral fat levels are associated with increased stroke risk and may contribute to higher all-cause mortality.';

  @override
  String get riskStrokeMortalityDetail1 => 'Elevated risk of ischemic stroke';

  @override
  String get riskStrokeMortalityDetail2 =>
      'Association with higher all-cause mortality rates';

  @override
  String get riskStrokeMortalityDetail3 =>
      'Risk persists even at normal BMI levels';

  @override
  String get riskInflammation => 'Chronic Inflammation';

  @override
  String get riskInflammationDesc =>
      'Visceral fat tissue actively secretes inflammatory molecules that promote systemic inflammation throughout the body.';

  @override
  String get riskInflammationDetail1 =>
      'Secretes inflammatory cytokines (IL-6, TNF-alpha)';

  @override
  String get riskInflammationDetail2 => 'Disrupts normal hormone signaling';

  @override
  String get riskInflammationDetail3 =>
      'Creates low-level chronic inflammation';

  @override
  String get riskInflammationDetail4 =>
      'Inflammation is a risk factor for many chronic diseases';

  @override
  String get riskLiver => 'Non-Alcoholic Fatty Liver Disease';

  @override
  String get riskLiverDesc =>
      'Visceral fat accumulation is strongly correlated with fat infiltration in the liver and elevated liver enzymes.';

  @override
  String get riskLiverDetail1 =>
      'Fat deposits in liver tissue (hepatic steatosis)';

  @override
  String get riskLiverDetail2 => 'Elevated liver enzyme levels (ALT, AST)';

  @override
  String get riskLiverDetail3 =>
      'Can progress to more serious liver conditions';

  @override
  String get riskLiverDetail4 => 'Often reversible with lifestyle changes';

  @override
  String get riskMetabolicSyndrome => 'Metabolic Syndrome';

  @override
  String get riskMetabolicSyndromeDesc =>
      'Visceral adiposity is a core driver of metabolic syndrome, a cluster of conditions that increase disease risk.';

  @override
  String get riskMetabolicSyndromeDetail1 => 'Elevated blood sugar levels';

  @override
  String get riskMetabolicSyndromeDetail2 => 'High blood pressure';

  @override
  String get riskMetabolicSyndromeDetail3 => 'Abnormal cholesterol levels';

  @override
  String get riskMetabolicSyndromeDetail4 =>
      'Central obesity (excess waist fat)';

  @override
  String get riskMetabolicSyndromeDetail5 =>
      'Significantly increases heart disease and diabetes risk';

  @override
  String get riskCancer => 'Cancer Associations';

  @override
  String get riskCancerDesc =>
      'Emerging evidence links visceral fat with metabolic dysregulation and higher risk for certain cancers.';

  @override
  String get riskCancerDetail1 =>
      'Altered hormone signaling may promote cancer growth';

  @override
  String get riskCancerDetail2 =>
      'Chronic inflammation creates favorable environment for cancer';

  @override
  String get riskCancerDetail3 => 'Associated with certain malignancies';

  @override
  String get riskCancerDetail4 => 'Research ongoing to understand mechanisms';

  @override
  String get tipActivity => 'Regular Physical Activity';

  @override
  String get tipActivityDesc =>
      'Consistent aerobic exercise and strength training are among the most effective ways to reduce visceral fat.';

  @override
  String get tipActivityAction1 =>
      'Aim for 150+ minutes per week of moderate-intensity aerobic activity';

  @override
  String get tipActivityAction2 =>
      'Include 2 or more days per week of strength training';

  @override
  String get tipActivityAction3 =>
      'Walking, cycling, swimming, and jogging are excellent choices';

  @override
  String get tipActivityAction4 =>
      'Strength training helps maintain lean muscle mass';

  @override
  String get tipDiet => 'Balanced, Nutrient-Dense Diet';

  @override
  String get tipDietDesc =>
      'Focus on whole foods and limit processed foods to help reduce visceral fat accumulation.';

  @override
  String get tipDietAction1 => 'Emphasize vegetables, fruits, and whole grains';

  @override
  String get tipDietAction2 => 'Choose lean proteins (fish, poultry, legumes)';

  @override
  String get tipDietAction3 => 'Limit added sugars and refined carbohydrates';

  @override
  String get tipDietAction4 => 'Reduce intake of highly processed foods';

  @override
  String get tipDietAction5 => 'Choose healthy fats (olive oil, nuts, avocado)';

  @override
  String get tipWeight => 'Weight Management';

  @override
  String get tipWeightDesc =>
      'Maintaining a healthy weight through sustainable calorie control helps reduce visceral fat stores.';

  @override
  String get tipWeightAction1 =>
      'Create a modest calorie deficit for gradual weight loss';

  @override
  String get tipWeightAction2 =>
      'Track waist circumference as a progress indicator';

  @override
  String get tipWeightAction3 =>
      'Monitor waist-to-height ratio (aim for < 0.5)';

  @override
  String get tipWeightAction4 =>
      'Focus on sustainable changes, not crash diets';

  @override
  String get tipSedentary => 'Reduce Sedentary Time';

  @override
  String get tipSedentaryDesc =>
      'Breaking up prolonged sitting with light movement contributes to overall energy expenditure.';

  @override
  String get tipSedentaryAction1 => 'Stand up and move every 30-60 minutes';

  @override
  String get tipSedentaryAction2 => 'Take walking breaks during work';

  @override
  String get tipSedentaryAction3 => 'Use a standing desk when possible';

  @override
  String get tipSedentaryAction4 => 'Choose stairs over elevators';

  @override
  String get tipSedentaryAction5 =>
      'Even light activity helps reduce visceral fat';

  @override
  String get tipSleepStress => 'Quality Sleep and Stress Management';

  @override
  String get tipSleepStressDesc =>
      'Poor sleep and chronic stress raise cortisol, a hormone linked to abdominal fat accumulation.';

  @override
  String get tipSleepStressAction1 =>
      'Aim for 7-9 hours of quality sleep per night';

  @override
  String get tipSleepStressAction2 => 'Maintain a consistent sleep schedule';

  @override
  String get tipSleepStressAction3 =>
      'Practice stress-reducing activities (meditation, yoga)';

  @override
  String get tipSleepStressAction4 => 'Limit screen time before bed';

  @override
  String get tipSleepStressAction5 => 'Address sources of chronic stress';

  @override
  String get tipAlcohol => 'Limit Alcohol Consumption';

  @override
  String get tipAlcoholDesc =>
      'Alcohol adds calories and may promote visceral fat accumulation when consumed regularly in excess.';

  @override
  String get tipAlcoholAction1 =>
      'Limit to moderate consumption (1 drink/day women, 2/day men)';

  @override
  String get tipAlcoholAction2 => 'Choose lower-calorie options when drinking';

  @override
  String get tipAlcoholAction3 => 'Avoid binge drinking episodes';

  @override
  String get tipAlcoholAction4 => 'Consider alcohol-free days each week';

  @override
  String get tipSmoking => 'Smoking Cessation';

  @override
  String get tipSmokingDesc =>
      'Smoking is associated with central fat accumulation and amplifies cardiometabolic risk.';

  @override
  String get tipSmokingAction1 =>
      'Quit smoking to reduce visceral fat accumulation';

  @override
  String get tipSmokingAction2 =>
      'Seek support programs or medications if needed';

  @override
  String get tipSmokingAction3 => 'Benefits begin within days of quitting';

  @override
  String get tipSmokingAction4 =>
      'Reduces overall cardiovascular risk significantly';

  @override
  String get waist => 'Waist';

  @override
  String get proximalThigh => 'Proximal Thigh';

  @override
  String get lowerRib => 'Lower rib';

  @override
  String get hipBone => 'Hip bone';

  @override
  String get midpoint => 'Midpoint';

  @override
  String get glutealCrease => 'Gluteal crease';

  @override
  String get justBelowCrease => 'Just below crease';

  @override
  String errorStartingApp(String error) {
    return 'Error starting app: $error\n\nPlease reinstall the app.';
  }

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get german => 'German';

  @override
  String get french => 'French';

  @override
  String get howToMeasureWaistShort => 'How to Measure Waist';

  @override
  String get howToMeasureThighShort => 'How to Measure Thigh';

  @override
  String get guideWaistStep1 => 'Stand relaxed, feet together';

  @override
  String get guideWaistStep2 =>
      'Wrap tape horizontally at navel (belly button) level';

  @override
  String get guideWaistStep3 => 'Keep tape snug but not tight';

  @override
  String get guideWaistStep4 => 'Measure at end of normal exhale';

  @override
  String get guideThighStep1 => 'Stand straight with feet shoulder-width apart';

  @override
  String get guideThighStep2 =>
      'Measure at the proximal thigh (just below the gluteal fold)';

  @override
  String get guideThighStep3 => 'Wrap tape around the thigh horizontally';

  @override
  String get guideThighStep4 => 'Keep tape snug but not compressing';

  @override
  String get gotIt => 'Got it';

  @override
  String get healthTrajectory => 'Health Trajectory';

  @override
  String get directionDecreasing => 'decreasing';

  @override
  String get directionIncreasing => 'increasing';

  @override
  String goalEtaMessage(String eta) {
    return 'At this rate, you\'ll reach your goal in ~$eta';
  }

  @override
  String get unlockProjection => 'Unlock to see your 12-month projection';

  @override
  String get noDataToDisplay => 'No data to display';

  @override
  String minValue(int value, String unit) {
    return 'Min $value $unit';
  }

  @override
  String maxValue(int value, String unit) {
    return 'Max $value $unit';
  }

  @override
  String yourVisceralFatIs(String level) {
    return 'Your visceral fat is $level';
  }

  @override
  String get yourVisceralFatIsPrefix => 'Your visceral fat is ';

  @override
  String get actionItems => 'Action Items';

  @override
  String get riskHigh => 'High Risk';

  @override
  String get riskElevatedRisk => 'Elevated Risk';

  @override
  String get riskModerate => 'Moderate Risk';

  @override
  String get bmiUnderweight => 'Underweight';

  @override
  String get bmiNormal => 'Normal';

  @override
  String get bmiOverweight => 'Overweight';

  @override
  String get bmiObese => 'Obese';

  @override
  String get bodyMassIndex => 'Body Mass Index';

  @override
  String get visceralObesity => 'Visceral Obesity';

  @override
  String get visceralFatArea => 'Visceral Fat Area';

  @override
  String get measurementsUsed => 'Measurements Used';

  @override
  String heightWithUnit(String unit) {
    return 'Height ($unit)';
  }

  @override
  String get riskScaleHealthy => 'Healthy';

  @override
  String get riskScaleElevated => 'Elevated';

  @override
  String get riskScaleObesity => 'Obesity';

  @override
  String yourVatValue(String value) {
    return 'You: $value cm²';
  }
}
