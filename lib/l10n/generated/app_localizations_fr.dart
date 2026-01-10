// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Visqo';

  @override
  String get navCalculate => 'Calculer';

  @override
  String get navWhatIf => 'Simulation';

  @override
  String get navProgress => 'Progression';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get welcomeTitle => 'Bienvenue sur Visqo';

  @override
  String get welcomeSubtitle => 'Votre suivi personnel de graisse viscérale';

  @override
  String get getStarted => 'Commencer';

  @override
  String get skipAndExplore => 'Passer et explorer';

  @override
  String get whatIsVatTitle => 'Qu\'est-ce que la graisse viscérale ?';

  @override
  String get hiddenFatTitle => 'Graisse cachée';

  @override
  String get hiddenFatDesc =>
      'La graisse viscérale est stockée en profondeur dans l\'abdomen, autour des organes vitaux comme le foie, l\'estomac et les intestins.';

  @override
  String get healthRisksTitle => 'Risques pour la santé';

  @override
  String get healthRisksDesc =>
      'Des niveaux élevés sont associés à un risque accru de maladies cardiaques, de diabète de type 2 et de syndrome métabolique.';

  @override
  String get notVisibleTitle => 'Pas toujours visible';

  @override
  String get notVisibleDesc =>
      'Contrairement à la graisse sous-cutanée (sous la peau), la graisse viscérale peut être élevée même chez les personnes minces.';

  @override
  String get continueButton => 'Continuer';

  @override
  String get howItWorksTitle => 'Comment fonctionne Visqo';

  @override
  String get stepMeasure => 'Mesurer';

  @override
  String get stepMeasureDesc =>
      'Prenez des mesures corporelles simples : tour de taille et tour de cuisse.';

  @override
  String get stepCalculate => 'Calculer';

  @override
  String get stepCalculateDesc =>
      'Visqo utilise une formule scientifiquement validée pour estimer votre surface de graisse viscérale.';

  @override
  String get stepTrack => 'Suivre';

  @override
  String get stepTrackDesc =>
      'Suivez votre progression dans le temps grâce aux graphiques et tendances.';

  @override
  String get scientificNote =>
      'Basé sur des recherches publiées avec une précision de 80 à 84 % par rapport aux scanners.';

  @override
  String get setUpProfile => 'Créer un profil';

  @override
  String get profileSetupTitle => 'Configurons votre profil';

  @override
  String get profileSetupSubtitle =>
      'Ces informations sont utilisées pour calculer précisément votre graisse viscérale.';

  @override
  String get newProfileTitle => 'Nouveau profil';

  @override
  String get createNewProfile => 'Créer un nouveau profil';

  @override
  String get profileName => 'Nom du profil';

  @override
  String get profileNameHint => 'ex. : Jean, Maman, Papa';

  @override
  String get pleaseEnterProfileName => 'Veuillez entrer un nom de profil';

  @override
  String get createProfile => 'Créer le profil';

  @override
  String get startTracking => 'Commencer le suivi';

  @override
  String get sexLabel => 'Sexe';

  @override
  String get male => 'Homme';

  @override
  String get female => 'Femme';

  @override
  String get dateOfBirth => 'Date de naissance';

  @override
  String get height => 'Taille';

  @override
  String get createProfileToStart => 'Créez un profil pour commencer';

  @override
  String get createProfileExplanation =>
      'Pour calculer votre graisse viscérale, nous avons besoin d\'informations de base comme votre sexe, votre âge et votre taille.';

  @override
  String get todaysMeasurements => 'Mesures du jour';

  @override
  String get weight => 'Poids';

  @override
  String get enterWeight => 'Entrez le poids';

  @override
  String get waistCircumference => 'Tour de taille';

  @override
  String get enterWaist => 'Entrez le tour de taille';

  @override
  String get thighCircumference => 'Tour de cuisse';

  @override
  String get enterThigh => 'Entrez le tour de cuisse';

  @override
  String get calculateAndSave => 'Calculer et enregistrer';

  @override
  String get noPreviousMeasurements => 'Aucune mesure précédente';

  @override
  String get measured => 'Mesuré';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get result => 'Résultat';

  @override
  String get viewHealthInsights => 'Voir les conseils santé';

  @override
  String get viewProgressChart => 'Voir le graphique de progression';

  @override
  String get shareResult => 'Partager le résultat';

  @override
  String get visceralFatTrend => 'Évolution de la graisse viscérale';

  @override
  String get history => 'Historique';

  @override
  String get noMeasurementsYet => 'Aucune mesure enregistrée';

  @override
  String get startTrackingToSeeProgress =>
      'Commencez le suivi pour voir votre progression';

  @override
  String get doctorsReport => 'Rapport médical';

  @override
  String olderMeasurements(int count) {
    return '$count mesures antérieures';
  }

  @override
  String get unlockFullProgress => 'Débloquer pour voir tout l\'historique';

  @override
  String get settings => 'Paramètres';

  @override
  String get profiles => 'Profils';

  @override
  String get addProfile => 'Ajouter un profil';

  @override
  String get currentProfile => 'Profil actuel';

  @override
  String get age => 'Âge';

  @override
  String get years => 'ans';

  @override
  String ageYears(int age) {
    return '$age ans';
  }

  @override
  String get deleteProfile => 'Supprimer le profil';

  @override
  String deleteProfileConfirmation(String name) {
    return 'Supprimer « $name » et toutes ses mesures ? Cette action est irréversible.';
  }

  @override
  String get goals => 'Objectifs';

  @override
  String get vatGoal => 'Objectif VAT';

  @override
  String get notSet => 'Non défini';

  @override
  String get setVatGoal => 'Définir un objectif VAT';

  @override
  String get setVatGoalDescription =>
      'Définissez une cible de graisse viscérale à suivre sur votre graphique de progression.';

  @override
  String get goalHint => 'ex. : 100';

  @override
  String get goalTip =>
      'Conseil : en dessous de 100 cm², c\'est considéré comme sain';

  @override
  String get clear => 'Effacer';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get units => 'Unités';

  @override
  String get metric => 'Métrique';

  @override
  String get metricUnits => 'kg, cm';

  @override
  String get imperial => 'Impérial';

  @override
  String get imperialUnits => 'lbs, pouces';

  @override
  String get reminders => 'Rappels';

  @override
  String get measurementReminder => 'Rappel de mesure';

  @override
  String get frequency => 'Fréquence';

  @override
  String get off => 'Désactivé';

  @override
  String get weekly => 'Hebdomadaire';

  @override
  String get monthly => 'Mensuel';

  @override
  String get noRemindersScheduled => 'Aucun rappel programmé';

  @override
  String everyDayAt(String day, String time) {
    return 'Chaque $day à $time';
  }

  @override
  String everyOrdinalAt(String ordinal, String time) {
    return 'Le $ordinal de chaque mois à $time';
  }

  @override
  String get time => 'Heure';

  @override
  String get dayOfWeek => 'Jour de la semaine';

  @override
  String get dayOfMonth => 'Jour du mois';

  @override
  String get monday => 'Lundi';

  @override
  String get tuesday => 'Mardi';

  @override
  String get wednesday => 'Mercredi';

  @override
  String get thursday => 'Jeudi';

  @override
  String get friday => 'Vendredi';

  @override
  String get saturday => 'Samedi';

  @override
  String get sunday => 'Dimanche';

  @override
  String get appearance => 'Apparence';

  @override
  String get system => 'Système';

  @override
  String get followSystemSettings => 'Suivre les paramètres système';

  @override
  String get light => 'Clair';

  @override
  String get alwaysLightTheme => 'Toujours utiliser le thème clair';

  @override
  String get dark => 'Sombre';

  @override
  String get alwaysDarkTheme => 'Toujours utiliser le thème sombre';

  @override
  String get data => 'Données';

  @override
  String get resetAllData => 'Réinitialiser toutes les données';

  @override
  String get deleteAllProfilesAndMeasurements =>
      'Supprimer tous les profils et mesures';

  @override
  String get resetAllDataConfirmation =>
      'Cela supprimera TOUS les profils et mesures. Vous devrez créer un nouveau profil. Cette action est irréversible.';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get delete => 'Supprimer';

  @override
  String get developerOptions => 'Options développeur';

  @override
  String get premiumStatusOverride => 'Forcer le statut Premium';

  @override
  String get simulatingPremium => 'Simulation Premium';

  @override
  String get simulatingFree => 'Simulation gratuite';

  @override
  String get usingRealStatus => 'Utilisation du statut réel';

  @override
  String get actual => 'réel';

  @override
  String get premium => 'Premium';

  @override
  String get free => 'Gratuit';

  @override
  String get real => 'Réel';

  @override
  String get pro => 'PRO';

  @override
  String get multipleProfiles => 'Profils multiples';

  @override
  String get unlimitedHistory => 'Historique illimité';

  @override
  String get help => 'Aide';

  @override
  String get aboutVisqo => 'À propos de Visqo';

  @override
  String get aboutVisqoDescription =>
      'Visqo vous aide à estimer votre graisse viscérale à partir de mesures corporelles simples. La graisse viscérale est stockée autour de vos organes internes et est liée à des risques accrus pour la santé. En suivant vos mesures au fil du temps, vous pouvez surveiller votre progression vers une meilleure composition corporelle.';

  @override
  String get howToMeasureWaist => 'Comment mesurer le tour de taille';

  @override
  String get instructions => 'Instructions';

  @override
  String get waistStep1 =>
      'Tenez-vous debout, pieds joints et bras détendus le long du corps.';

  @override
  String get waistStep2 =>
      'Repérez le bas de vos côtes et le haut de vos os iliaques (crête iliaque).';

  @override
  String get waistStep3 =>
      'Placez le mètre ruban à mi-chemin entre ces deux points, environ au niveau du nombril.';

  @override
  String get waistStep4 =>
      'Enroulez le ruban autour de votre taille en le maintenant parallèle au sol.';

  @override
  String get waistStep5 =>
      'Expirez normalement et relevez la mesure sans trop serrer le ruban.';

  @override
  String get waistTip =>
      'Mesurez directement sur la peau ou sur des vêtements légers pour plus de précision.';

  @override
  String get howToMeasureThigh => 'Comment mesurer le tour de cuisse';

  @override
  String get thighStep1 =>
      'Tenez-vous debout, le poids réparti uniformément sur les deux jambes.';

  @override
  String get thighStep2 =>
      'Identifiez le pli fessier (là où la fesse rejoint la cuisse).';

  @override
  String get thighStep3 =>
      'Placez le mètre ruban juste en dessous du pli fessier.';

  @override
  String get thighStep4 =>
      'Enroulez le ruban horizontalement autour de la cuisse, perpendiculairement à l\'axe de la jambe.';

  @override
  String get thighStep5 =>
      'Gardez vos muscles détendus et relevez la mesure sans comprimer la peau.';

  @override
  String get thighTip =>
      'Mesurez les deux cuisses et utilisez la moyenne si elles diffèrent significativement.';

  @override
  String get settingGoalTitle => 'Définir un objectif';

  @override
  String get settingGoalStep1 =>
      'Accédez aux Paramètres depuis l\'écran du calculateur.';

  @override
  String get settingGoalStep2 =>
      'Appuyez sur « Définir un objectif VAT » dans la section Objectifs.';

  @override
  String get settingGoalStep3 =>
      'Entrez votre valeur cible de VAT et enregistrez.';

  @override
  String get settingGoalDescription =>
      'Vous pouvez définir un objectif VAT personnel pour suivre votre progression vers une meilleure composition corporelle.';

  @override
  String get goalChartDescription =>
      'Une fois défini, votre objectif apparaîtra sous forme de ligne verte pointillée sur le graphique de progression, vous aidant à visualiser votre proximité par rapport à la cible.';

  @override
  String get goalHealthTip =>
      'Une VAT inférieure à 100 cm² est généralement considérée comme saine. Consultez un professionnel de santé pour des conseils personnalisés.';

  @override
  String get trendIndicatorTitle => 'Comprendre l\'indicateur de tendance';

  @override
  String get trendIndicatorDescription =>
      'L\'indicateur de tendance montre comment votre VAT a évolué par rapport à votre mesure précédente.';

  @override
  String get trendDecreasing => 'En baisse';

  @override
  String get trendDecreasingDesc =>
      'Votre VAT est inférieure à avant. Excellente progression vers la réduction de la graisse viscérale.';

  @override
  String get trendIncreasing => 'En hausse';

  @override
  String get trendIncreasingDesc =>
      'Votre VAT est supérieure à avant. Pensez à revoir votre alimentation et votre activité physique.';

  @override
  String get trendStable => 'Stable';

  @override
  String get trendStableDesc =>
      'Votre VAT a varié de moins de 1 cm². Vos niveaux restent constants.';

  @override
  String get trendMagnitudeNote =>
      'L\'indicateur de tendance affiche également la variation exacte de VAT (ex. : -5,2) pour vous montrer l\'ampleur du changement.';

  @override
  String get calculationTitle =>
      'Comment la graisse viscérale est-elle calculée ?';

  @override
  String get calculationDescription =>
      'Visqo utilise le modèle anthropométrique de Samouda pour estimer la surface de tissu adipeux viscéral (VAT) sans recourir à des examens coûteux comme le scanner ou l\'IRM.';

  @override
  String get calculationModelDescription =>
      'Le modèle utilise des mesures corporelles simples combinées à votre âge et votre IMC pour prédire la VAT avec une grande précision :';

  @override
  String get formulaForMen => 'Pour les hommes';

  @override
  String get formulaMen =>
      'VAT = 6 x Taille - 4,41 x Cuisse + 1,19 x Âge - 213,65';

  @override
  String get accuracyMen => 'Explique 80,3 % de la variance de la VAT';

  @override
  String get formulaForWomen => 'Pour les femmes';

  @override
  String get formulaWomen =>
      'VAT = 2,15 x Taille - 3,63 x Cuisse + 1,46 x Âge + 6,22 x IMC - 92,713';

  @override
  String get accuracyWomen => 'Explique 83,6 % de la variance de la VAT';

  @override
  String get resultUnit =>
      'Le résultat est exprimé en cm², représentant la surface transversale estimée du tissu adipeux viscéral.';

  @override
  String get understandingResultsTitle => 'Comprendre vos résultats';

  @override
  String get resultsIntro =>
      'Votre résultat VAT est classé en trois niveaux de risque :';

  @override
  String get riskHealthy => 'Sain';

  @override
  String get riskHealthyRange => 'Moins de 100 cm²';

  @override
  String get riskHealthyDesc =>
      'Niveaux normaux de graisse viscérale associés à des risques moindres pour la santé.';

  @override
  String get riskElevated => 'Élevé';

  @override
  String get riskElevatedRange => '100 - 130 cm²';

  @override
  String get riskElevatedDesc =>
      'Niveaux modérément élevés. Des changements de mode de vie sont recommandés.';

  @override
  String get riskHighRisk => 'Risque élevé';

  @override
  String get riskHighRiskRange => 'Plus de 130 cm²';

  @override
  String get riskHighRiskDesc =>
      'Graisse viscérale élevée associée à des risques métaboliques accrus.';

  @override
  String get learnMoreHealthRisks =>
      'En savoir plus sur les risques et conseils santé';

  @override
  String get learnMoreHealthRisksDesc =>
      'Découvrez les implications pour la santé et les moyens fondés sur des preuves pour réduire la graisse viscérale.';

  @override
  String get scientificReference => 'Référence scientifique';

  @override
  String get referenceIntro =>
      'La méthode de calcul utilisée dans cette application est basée sur des recherches publiées :';

  @override
  String get referenceAuthors =>
      'Samouda, H., Dutour, A., Chaumoitre, K., Panuel, M., Dutour, O., & Dadoun, F.';

  @override
  String get referenceTitle =>
      'VAT=TAAT-SAAT: innovative anthropometric model to predict visceral adipose tissue without resort to CT-Scan or DXA.';

  @override
  String get referenceJournal => 'Obesity (2013), 21(1), E41-E50.';

  @override
  String get healthInsights => 'Conseils santé';

  @override
  String get aboutVisceralFat => 'À propos de la graisse viscérale';

  @override
  String get aboutVisceralFatDescription =>
      'La graisse viscérale est stockée en profondeur dans la cavité abdominale, autour des organes internes. Contrairement à la graisse sous-cutanée, elle joue un rôle hormonalement actif et est liée à des risques accrus pour la santé. Découvrez les risques et les moyens fondés sur des preuves pour la réduire.';

  @override
  String get healthRisksOfElevatedVat =>
      'Risques liés à une graisse viscérale élevée';

  @override
  String get healthRisksSubtitle =>
      'Comprendre les risques peut vous aider à vous motiver';

  @override
  String get evidenceBasedTips => 'Conseils fondés sur des preuves';

  @override
  String get evidenceBasedTipsSubtitle =>
      'Actions simples pour aider à réduire la graisse viscérale';

  @override
  String get recommendedForYou => 'Recommandé pour vous';

  @override
  String get maintainYourHealth => 'Préservez votre santé';

  @override
  String get additionalTips => 'Conseils supplémentaires';

  @override
  String get disclaimer =>
      'Ces informations sont à titre éducatif uniquement et ne remplacent pas un avis médical professionnel. Veuillez consulter un professionnel de santé pour des conseils personnalisés.';

  @override
  String get riskCardiometabolic => 'Maladies cardiométaboliques';

  @override
  String get riskCardiometabolicDesc =>
      'Une graisse viscérale élevée augmente significativement le risque de développer des maladies cardiovasculaires et métaboliques graves.';

  @override
  String get riskCardiometabolicDetail1 =>
      'Risque accru de diabète de type 2 par insulinorésistance';

  @override
  String get riskCardiometabolicDetail2 =>
      'Probabilité plus élevée d\'hypertension artérielle';

  @override
  String get riskCardiometabolicDetail3 =>
      'Profil lipidique défavorable (dyslipidémie)';

  @override
  String get riskCardiometabolicDetail4 =>
      'Risque accru de maladie coronarienne et d\'insuffisance cardiaque';

  @override
  String get riskStrokeMortality => 'AVC et mortalité';

  @override
  String get riskStrokeMortalityDesc =>
      'Des niveaux élevés de graisse viscérale sont associés à un risque accru d\'AVC et peuvent contribuer à une mortalité toutes causes plus élevée.';

  @override
  String get riskStrokeMortalityDetail1 => 'Risque élevé d\'AVC ischémique';

  @override
  String get riskStrokeMortalityDetail2 =>
      'Association avec des taux de mortalité toutes causes plus élevés';

  @override
  String get riskStrokeMortalityDetail3 =>
      'Le risque persiste même avec un IMC normal';

  @override
  String get riskInflammation => 'Inflammation chronique';

  @override
  String get riskInflammationDesc =>
      'Le tissu adipeux viscéral sécrète activement des molécules inflammatoires qui favorisent l\'inflammation systémique dans tout le corps.';

  @override
  String get riskInflammationDetail1 =>
      'Sécrète des cytokines inflammatoires (IL-6, TNF-alpha)';

  @override
  String get riskInflammationDetail2 =>
      'Perturbe la signalisation hormonale normale';

  @override
  String get riskInflammationDetail3 =>
      'Crée une inflammation chronique de bas grade';

  @override
  String get riskInflammationDetail4 =>
      'L\'inflammation est un facteur de risque pour de nombreuses maladies chroniques';

  @override
  String get riskLiver => 'Stéatose hépatique non alcoolique';

  @override
  String get riskLiverDesc =>
      'L\'accumulation de graisse viscérale est fortement corrélée à l\'infiltration graisseuse du foie et à l\'élévation des enzymes hépatiques.';

  @override
  String get riskLiverDetail1 =>
      'Dépôts de graisse dans le tissu hépatique (stéatose hépatique)';

  @override
  String get riskLiverDetail2 =>
      'Élévation des enzymes hépatiques (ALAT, ASAT)';

  @override
  String get riskLiverDetail3 =>
      'Peut évoluer vers des affections hépatiques plus graves';

  @override
  String get riskLiverDetail4 =>
      'Souvent réversible avec des changements de mode de vie';

  @override
  String get riskMetabolicSyndrome => 'Syndrome métabolique';

  @override
  String get riskMetabolicSyndromeDesc =>
      'L\'adiposité viscérale est un facteur central du syndrome métabolique, un ensemble de conditions qui augmentent le risque de maladie.';

  @override
  String get riskMetabolicSyndromeDetail1 => 'Glycémie élevée';

  @override
  String get riskMetabolicSyndromeDetail2 => 'Hypertension artérielle';

  @override
  String get riskMetabolicSyndromeDetail3 => 'Taux de cholestérol anormaux';

  @override
  String get riskMetabolicSyndromeDetail4 =>
      'Obésité centrale (excès de graisse abdominale)';

  @override
  String get riskMetabolicSyndromeDetail5 =>
      'Augmente significativement le risque de maladies cardiaques et de diabète';

  @override
  String get riskCancer => 'Associations avec le cancer';

  @override
  String get riskCancerDesc =>
      'Des preuves émergentes associent la graisse viscérale à une dérégulation métabolique et à un risque accru de certains cancers.';

  @override
  String get riskCancerDetail1 =>
      'Une signalisation hormonale altérée peut favoriser la croissance cancéreuse';

  @override
  String get riskCancerDetail2 =>
      'L\'inflammation chronique crée un environnement favorable au cancer';

  @override
  String get riskCancerDetail3 => 'Associée à certaines tumeurs malignes';

  @override
  String get riskCancerDetail4 =>
      'La recherche continue pour comprendre les mécanismes';

  @override
  String get tipActivity => 'Activité physique régulière';

  @override
  String get tipActivityDesc =>
      'L\'exercice aérobique régulier et la musculation sont parmi les moyens les plus efficaces pour réduire la graisse viscérale.';

  @override
  String get tipActivityAction1 =>
      'Visez 150+ minutes par semaine d\'activité aérobique d\'intensité modérée';

  @override
  String get tipActivityAction2 =>
      'Incluez 2 jours ou plus par semaine de musculation';

  @override
  String get tipActivityAction3 =>
      'Marche, vélo, natation et jogging sont d\'excellents choix';

  @override
  String get tipActivityAction4 =>
      'La musculation aide à maintenir la masse musculaire maigre';

  @override
  String get tipDiet => 'Alimentation équilibrée et nutritive';

  @override
  String get tipDietDesc =>
      'Privilégiez les aliments complets et limitez les aliments transformés pour aider à réduire l\'accumulation de graisse viscérale.';

  @override
  String get tipDietAction1 =>
      'Mettez l\'accent sur les légumes, les fruits et les céréales complètes';

  @override
  String get tipDietAction2 =>
      'Choisissez des protéines maigres (poisson, volaille, légumineuses)';

  @override
  String get tipDietAction3 =>
      'Limitez les sucres ajoutés et les glucides raffinés';

  @override
  String get tipDietAction4 =>
      'Réduisez la consommation d\'aliments ultra-transformés';

  @override
  String get tipDietAction5 =>
      'Optez pour des graisses saines (huile d\'olive, noix, avocat)';

  @override
  String get tipWeight => 'Gestion du poids';

  @override
  String get tipWeightDesc =>
      'Maintenir un poids santé grâce à un contrôle calorique durable aide à réduire les réserves de graisse viscérale.';

  @override
  String get tipWeightAction1 =>
      'Créez un déficit calorique modeste pour une perte de poids progressive';

  @override
  String get tipWeightAction2 =>
      'Suivez votre tour de taille comme indicateur de progression';

  @override
  String get tipWeightAction3 =>
      'Surveillez le ratio taille/hauteur (visez < 0,5)';

  @override
  String get tipWeightAction4 =>
      'Concentrez-vous sur des changements durables, pas les régimes draconiens';

  @override
  String get tipSedentary => 'Réduire la sédentarité';

  @override
  String get tipSedentaryDesc =>
      'Interrompre la position assise prolongée par des mouvements légers contribue à la dépense énergétique globale.';

  @override
  String get tipSedentaryAction1 =>
      'Levez-vous et bougez toutes les 30 à 60 minutes';

  @override
  String get tipSedentaryAction2 =>
      'Faites des pauses marche pendant le travail';

  @override
  String get tipSedentaryAction3 => 'Utilisez un bureau debout si possible';

  @override
  String get tipSedentaryAction4 => 'Préférez les escaliers aux ascenseurs';

  @override
  String get tipSedentaryAction5 =>
      'Même une activité légère aide à réduire la graisse viscérale';

  @override
  String get tipSleepStress => 'Sommeil de qualité et gestion du stress';

  @override
  String get tipSleepStressDesc =>
      'Un mauvais sommeil et le stress chronique augmentent le cortisol, une hormone liée à l\'accumulation de graisse abdominale.';

  @override
  String get tipSleepStressAction1 =>
      'Visez 7 à 9 heures de sommeil de qualité par nuit';

  @override
  String get tipSleepStressAction2 =>
      'Maintenez un horaire de sommeil régulier';

  @override
  String get tipSleepStressAction3 =>
      'Pratiquez des activités anti-stress (méditation, yoga)';

  @override
  String get tipSleepStressAction4 =>
      'Limitez le temps d\'écran avant le coucher';

  @override
  String get tipSleepStressAction5 => 'Traitez les sources de stress chronique';

  @override
  String get tipAlcohol => 'Limiter la consommation d\'alcool';

  @override
  String get tipAlcoholDesc =>
      'L\'alcool apporte des calories et peut favoriser l\'accumulation de graisse viscérale en cas de consommation régulière excessive.';

  @override
  String get tipAlcoholAction1 =>
      'Limitez à une consommation modérée (1 verre/jour femmes, 2/jour hommes)';

  @override
  String get tipAlcoholAction2 => 'Choisissez des options moins caloriques';

  @override
  String get tipAlcoholAction3 =>
      'Évitez les épisodes de consommation excessive';

  @override
  String get tipAlcoholAction4 =>
      'Envisagez des jours sans alcool chaque semaine';

  @override
  String get tipSmoking => 'Arrêt du tabac';

  @override
  String get tipSmokingDesc =>
      'Le tabagisme est associé à l\'accumulation de graisse centrale et amplifie le risque cardiométabolique.';

  @override
  String get tipSmokingAction1 =>
      'Arrêtez de fumer pour réduire l\'accumulation de graisse viscérale';

  @override
  String get tipSmokingAction2 =>
      'Consultez des programmes d\'aide ou des médicaments si nécessaire';

  @override
  String get tipSmokingAction3 =>
      'Les bénéfices commencent dès les premiers jours d\'arrêt';

  @override
  String get tipSmokingAction4 =>
      'Réduit significativement le risque cardiovasculaire global';

  @override
  String get waist => 'Taille';

  @override
  String get proximalThigh => 'Cuisse proximale';

  @override
  String get lowerRib => 'Côte inférieure';

  @override
  String get hipBone => 'Os de la hanche';

  @override
  String get midpoint => 'Point médian';

  @override
  String get glutealCrease => 'Pli fessier';

  @override
  String get justBelowCrease => 'Juste sous le pli';

  @override
  String errorStartingApp(String error) {
    return 'Erreur au démarrage de l\'application : $error\n\nVeuillez réinstaller l\'application.';
  }

  @override
  String get language => 'Langue';

  @override
  String get english => 'Anglais';

  @override
  String get german => 'Allemand';

  @override
  String get french => 'Français';

  @override
  String get howToMeasureWaistShort => 'Mesurer le tour de taille';

  @override
  String get howToMeasureThighShort => 'Mesurer le tour de cuisse';

  @override
  String get guideWaistStep1 => 'Tenez-vous détendu, pieds joints';

  @override
  String get guideWaistStep2 =>
      'Placez le ruban horizontalement au niveau du nombril';

  @override
  String get guideWaistStep3 => 'Gardez le ruban ajusté mais pas serré';

  @override
  String get guideWaistStep4 => 'Mesurez en fin d\'expiration normale';

  @override
  String get guideThighStep1 =>
      'Tenez-vous droit, pieds écartés à la largeur des épaules';

  @override
  String get guideThighStep2 =>
      'Mesurez à la cuisse proximale (juste sous le pli fessier)';

  @override
  String get guideThighStep3 =>
      'Enroulez le ruban horizontalement autour de la cuisse';

  @override
  String get guideThighStep4 => 'Gardez le ruban ajusté mais sans comprimer';

  @override
  String get gotIt => 'Compris';

  @override
  String get healthTrajectory => 'Trajectoire santé';

  @override
  String get directionDecreasing => 'en baisse';

  @override
  String get directionIncreasing => 'en hausse';

  @override
  String goalEtaMessage(String eta) {
    return 'À ce rythme, vous atteindrez votre objectif dans ~$eta';
  }

  @override
  String get unlockProjection =>
      'Débloquer pour voir votre projection sur 12 mois';

  @override
  String get noDataToDisplay => 'Aucune donnée à afficher';

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
    return 'Votre graisse viscérale est $level';
  }

  @override
  String get yourVisceralFatIsPrefix => 'Votre graisse viscérale est ';

  @override
  String get actionItems => 'Actions recommandées';

  @override
  String get riskHigh => 'Risque élevé';

  @override
  String get riskElevatedRisk => 'Risque accru';

  @override
  String get riskModerate => 'Risque modéré';

  @override
  String get bmiUnderweight => 'Insuffisance pondérale';

  @override
  String get bmiNormal => 'Normal';

  @override
  String get bmiOverweight => 'Surpoids';

  @override
  String get bmiObese => 'Obésité';

  @override
  String get bodyMassIndex => 'Indice de masse corporelle';

  @override
  String get visceralObesity => 'Obésité viscérale';

  @override
  String get visceralFatArea => 'Surface de graisse viscérale';

  @override
  String get measurementsUsed => 'Mesures utilisées';

  @override
  String heightWithUnit(String unit) {
    return 'Taille ($unit)';
  }

  @override
  String get riskScaleHealthy => 'Sain';

  @override
  String get riskScaleElevated => 'Élevé';

  @override
  String get riskScaleObesity => 'Obésité';

  @override
  String yourVatValue(String value) {
    return 'Vous : $value cm²';
  }

  @override
  String get vatSummaryHealthyTitle => 'Votre graisse viscerale est saine';

  @override
  String get vatSummaryHealthyDescImproving =>
      'Excellente progression ! Votre graisse viscerale est dans une plage saine et continue de s\'ameliorer. Continuez vos bonnes habitudes.';

  @override
  String get vatSummaryHealthyDesc =>
      'Votre graisse viscerale est dans une plage saine. Maintenez votre mode de vie actuel pour la garder ainsi.';

  @override
  String get vatSummaryElevatedTitle => 'Votre graisse viscerale est elevee';

  @override
  String get vatSummaryElevatedDescImproving =>
      'Vous progressez ! Bien que votre graisse viscerale soit encore elevee, la tendance s\'ameliore. Continuez a suivre les conseils ci-dessous.';

  @override
  String get vatSummaryElevatedDesc =>
      'Votre graisse viscerale est moderement elevee, ce qui peut augmenter les risques pour la sante. Consultez les conseils fondes sur des preuves ci-dessous pour la reduire.';

  @override
  String get vatSummaryHighTitle => 'Votre graisse viscerale est elevee';

  @override
  String get vatSummaryHighDescImproving =>
      'Vous etes sur la bonne voie ! Votre graisse viscerale est elevee mais s\'ameliore. Poursuivez vos efforts et consultez un professionnel de sante pour des conseils personnalises.';

  @override
  String get vatSummaryHighDesc =>
      'Votre niveau de graisse viscerale indique des risques accrus pour la sante. Nous vous recommandons de consulter les informations ci-dessous et de consulter un professionnel de sante.';

  @override
  String get vatSummaryNoMeasurementTitle => 'Aucune mesure disponible';

  @override
  String get vatSummaryNoMeasurementDesc =>
      'Effectuez une mesure VAT pour voir des conseils de sante personnalises.';

  @override
  String get improving => 'En amelioration';

  @override
  String get whatIfCalculator => 'Calculateur hypothetique';

  @override
  String get createProfileFirst => 'Creez d\'abord un profil';

  @override
  String get whatIfNeedsProfile =>
      'Le calculateur hypothetique necessite vos informations de profil pour simuler les resultats. Veuillez d\'abord creer un profil.';

  @override
  String get simulateInstructions =>
      'Simulez differents scenarios pour planifier vos objectifs. Les resultats ne sont pas enregistres.';

  @override
  String get enterMeasurements => 'Entrez les mesures';

  @override
  String get targetWeight => 'Poids';

  @override
  String get enterTargetWeight => 'Entrez le poids cible';

  @override
  String get targetWaist => 'Tour de taille';

  @override
  String get enterTargetWaist => 'Entrez le tour de taille cible';

  @override
  String get targetThigh => 'Tour de cuisse';

  @override
  String get enterTargetThigh => 'Entrez le tour de cuisse cible';

  @override
  String get simulate => 'Simuler';

  @override
  String get simulatedResult => 'Resultat simule';

  @override
  String get wouldAchieveGoal => 'Cela atteindrait votre objectif !';

  @override
  String aboveGoal(String value) {
    return '$value cm² au-dessus de l\'objectif';
  }

  @override
  String yourGoalValue(String value) {
    return 'Votre objectif : $value cm²';
  }

  @override
  String get whatIfTip =>
      'Ajustez le poids ou le tour de taille pour voir comment cela affecte votre VAT';

  @override
  String waistWithValue(String value) {
    return 'Taille : $value cm';
  }

  @override
  String get categoryCardiometabolic => 'Cardiometabolique';

  @override
  String get categoryStrokeMortality => 'AVC et mortalite';

  @override
  String get categoryInflammation => 'Inflammation';

  @override
  String get categoryLiverDisease => 'Maladie hepatique';

  @override
  String get categoryMetabolicSyndrome => 'Syndrome metabolique';

  @override
  String get categoryCancer => 'Cancer';

  @override
  String get categoryPhysicalActivity => 'Activite physique';

  @override
  String get categoryDiet => 'Alimentation';

  @override
  String get categoryWeightManagement => 'Gestion du poids';

  @override
  String get categoryLifestyle => 'Mode de vie';

  @override
  String get categorySleepStress => 'Sommeil et stress';

  @override
  String get categoryAlcohol => 'Alcool';

  @override
  String get categorySmoking => 'Tabac';
}
