import 'package:visco/l10n/generated/app_localizations.dart';

/// Helper class for retrieving localized text for health risks and tips.
///
/// This class provides methods to get localized strings based on risk/tip IDs,
/// allowing the static data in [InsightsData] to remain as identifiers while
/// the display text comes from the localization system.
class LocalizedInsights {
  LocalizedInsights._();

  // ---------------------------------------------------------------------------
  // Risk Localization Methods
  // ---------------------------------------------------------------------------

  /// Returns the localized title for a health risk based on its ID.
  static String getLocalizedRiskTitle(String id, AppLocalizations l10n) {
    return switch (id) {
      'risk-cardiometabolic' => l10n.riskCardiometabolic,
      'risk-stroke-mortality' => l10n.riskStrokeMortality,
      'risk-inflammation' => l10n.riskInflammation,
      'risk-liver' => l10n.riskLiver,
      'risk-metabolic-syndrome' => l10n.riskMetabolicSyndrome,
      'risk-cancer' => l10n.riskCancer,
      _ => id,
    };
  }

  /// Returns the localized description for a health risk based on its ID.
  static String getLocalizedRiskDescription(String id, AppLocalizations l10n) {
    return switch (id) {
      'risk-cardiometabolic' => l10n.riskCardiometabolicDesc,
      'risk-stroke-mortality' => l10n.riskStrokeMortalityDesc,
      'risk-inflammation' => l10n.riskInflammationDesc,
      'risk-liver' => l10n.riskLiverDesc,
      'risk-metabolic-syndrome' => l10n.riskMetabolicSyndromeDesc,
      'risk-cancer' => l10n.riskCancerDesc,
      _ => '',
    };
  }

  /// Returns the localized details list for a health risk based on its ID.
  static List<String> getLocalizedRiskDetails(String id, AppLocalizations l10n) {
    return switch (id) {
      'risk-cardiometabolic' => [
        l10n.riskCardiometabolicDetail1,
        l10n.riskCardiometabolicDetail2,
        l10n.riskCardiometabolicDetail3,
        l10n.riskCardiometabolicDetail4,
      ],
      'risk-stroke-mortality' => [
        l10n.riskStrokeMortalityDetail1,
        l10n.riskStrokeMortalityDetail2,
        l10n.riskStrokeMortalityDetail3,
      ],
      'risk-inflammation' => [
        l10n.riskInflammationDetail1,
        l10n.riskInflammationDetail2,
        l10n.riskInflammationDetail3,
        l10n.riskInflammationDetail4,
      ],
      'risk-liver' => [
        l10n.riskLiverDetail1,
        l10n.riskLiverDetail2,
        l10n.riskLiverDetail3,
        l10n.riskLiverDetail4,
      ],
      'risk-metabolic-syndrome' => [
        l10n.riskMetabolicSyndromeDetail1,
        l10n.riskMetabolicSyndromeDetail2,
        l10n.riskMetabolicSyndromeDetail3,
        l10n.riskMetabolicSyndromeDetail4,
        l10n.riskMetabolicSyndromeDetail5,
      ],
      'risk-cancer' => [
        l10n.riskCancerDetail1,
        l10n.riskCancerDetail2,
        l10n.riskCancerDetail3,
        l10n.riskCancerDetail4,
      ],
      _ => [],
    };
  }

  // ---------------------------------------------------------------------------
  // Tip Localization Methods
  // ---------------------------------------------------------------------------

  /// Returns the localized title for a health tip based on its ID.
  static String getLocalizedTipTitle(String id, AppLocalizations l10n) {
    return switch (id) {
      'tip-activity' => l10n.tipActivity,
      'tip-diet' => l10n.tipDiet,
      'tip-weight' => l10n.tipWeight,
      'tip-sedentary' => l10n.tipSedentary,
      'tip-sleep-stress' => l10n.tipSleepStress,
      'tip-alcohol' => l10n.tipAlcohol,
      'tip-smoking' => l10n.tipSmoking,
      _ => id,
    };
  }

  /// Returns the localized description for a health tip based on its ID.
  static String getLocalizedTipDescription(String id, AppLocalizations l10n) {
    return switch (id) {
      'tip-activity' => l10n.tipActivityDesc,
      'tip-diet' => l10n.tipDietDesc,
      'tip-weight' => l10n.tipWeightDesc,
      'tip-sedentary' => l10n.tipSedentaryDesc,
      'tip-sleep-stress' => l10n.tipSleepStressDesc,
      'tip-alcohol' => l10n.tipAlcoholDesc,
      'tip-smoking' => l10n.tipSmokingDesc,
      _ => '',
    };
  }

  /// Returns the localized action items list for a health tip based on its ID.
  static List<String> getLocalizedTipActionItems(
    String id,
    AppLocalizations l10n,
  ) {
    return switch (id) {
      'tip-activity' => [
        l10n.tipActivityAction1,
        l10n.tipActivityAction2,
        l10n.tipActivityAction3,
        l10n.tipActivityAction4,
      ],
      'tip-diet' => [
        l10n.tipDietAction1,
        l10n.tipDietAction2,
        l10n.tipDietAction3,
        l10n.tipDietAction4,
        l10n.tipDietAction5,
      ],
      'tip-weight' => [
        l10n.tipWeightAction1,
        l10n.tipWeightAction2,
        l10n.tipWeightAction3,
        l10n.tipWeightAction4,
      ],
      'tip-sedentary' => [
        l10n.tipSedentaryAction1,
        l10n.tipSedentaryAction2,
        l10n.tipSedentaryAction3,
        l10n.tipSedentaryAction4,
        l10n.tipSedentaryAction5,
      ],
      'tip-sleep-stress' => [
        l10n.tipSleepStressAction1,
        l10n.tipSleepStressAction2,
        l10n.tipSleepStressAction3,
        l10n.tipSleepStressAction4,
        l10n.tipSleepStressAction5,
      ],
      'tip-alcohol' => [
        l10n.tipAlcoholAction1,
        l10n.tipAlcoholAction2,
        l10n.tipAlcoholAction3,
        l10n.tipAlcoholAction4,
      ],
      'tip-smoking' => [
        l10n.tipSmokingAction1,
        l10n.tipSmokingAction2,
        l10n.tipSmokingAction3,
        l10n.tipSmokingAction4,
      ],
      _ => [],
    };
  }
}
