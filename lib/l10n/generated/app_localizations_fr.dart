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
  String get navProgress => 'Progres';

  @override
  String get navSettings => 'Parametres';

  @override
  String get welcomeTitle => 'Bienvenue sur Visqo';

  @override
  String get welcomeSubtitle => 'Votre tracker personnel de graisse viscerale';

  @override
  String get getStarted => 'Commencer';

  @override
  String get skipAndExplore => 'Passer et explorer';

  @override
  String get whatIsVatTitle => 'Qu\'est-ce que la graisse viscerale ?';

  @override
  String get hiddenFatTitle => 'Graisse cachee';

  @override
  String get hiddenFatDesc =>
      'La graisse viscerale est stockee profondement dans votre abdomen, entourant les organes vitaux comme le foie, l\'estomac et les intestins.';

  @override
  String get healthRisksTitle => 'Risques pour la sante';

  @override
  String get healthRisksDesc =>
      'Des niveaux eleves sont lies a un risque accru de maladies cardiaques, de diabete de type 2 et de syndrome metabolique.';

  @override
  String get notVisibleTitle => 'Pas toujours visible';

  @override
  String get notVisibleDesc =>
      'Contrairement a la graisse sous-cutanee (sous la peau), la graisse viscerale peut etre elevee meme chez les personnes qui semblent minces.';

  @override
  String get continueButton => 'Continuer';

  @override
  String get howItWorksTitle => 'Comment fonctionne Visqo';

  @override
  String get stepMeasure => 'Mesurer';

  @override
  String get stepMeasureDesc =>
      'Prenez des mesures corporelles simples : tour de taille et de cuisse.';

  @override
  String get stepCalculate => 'Calculer';

  @override
  String get stepCalculateDesc =>
      'Visqo utilise une formule scientifiquement validee pour estimer votre surface de graisse viscerale.';

  @override
  String get stepTrack => 'Suivre';

  @override
  String get stepTrackDesc =>
      'Surveillez votre progres dans le temps avec des graphiques et des tendances.';

  @override
  String get scientificNote =>
      'Base sur des recherches evaluees par des pairs avec une precision de 80-84% par rapport aux scanners CT.';

  @override
  String get setUpProfile => 'Configurer le profil';

  @override
  String get profileSetupTitle => 'Configurons votre profil';

  @override
  String get profileSetupSubtitle =>
      'Ces informations sont utilisees pour calculer votre graisse viscerale avec precision.';

  @override
  String get newProfileTitle => 'Nouveau profil';

  @override
  String get createNewProfile => 'Creer un nouveau profil';

  @override
  String get profileName => 'Nom du profil';

  @override
  String get profileNameHint => 'ex. Jean, Maman, Papa';

  @override
  String get pleaseEnterProfileName => 'Veuillez entrer un nom de profil';

  @override
  String get createProfile => 'Creer le profil';

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
  String get createProfileToStart => 'Creez un profil pour commencer';

  @override
  String get createProfileExplanation =>
      'Pour calculer votre graisse viscerale, nous avons besoin de quelques informations de base comme votre sexe, age et taille.';

  @override
  String get todaysMeasurements => 'Mesures du jour';

  @override
  String get weight => 'Poids';

  @override
  String get enterWeight => 'Entrer le poids';

  @override
  String get waistCircumference => 'Tour de taille';

  @override
  String get enterWaist => 'Entrer la taille';

  @override
  String get thighCircumference => 'Tour de cuisse';

  @override
  String get enterThigh => 'Entrer la cuisse';

  @override
  String get calculateAndSave => 'Calculer et sauvegarder';

  @override
  String get noPreviousMeasurements => 'Pas de mesures precedentes';

  @override
  String get measured => 'Mesure';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get result => 'Resultat';

  @override
  String get viewHealthInsights => 'Voir les conseils sante';

  @override
  String get viewProgressChart => 'Voir le graphique de progres';

  @override
  String get shareResult => 'Partager le resultat';

  @override
  String get visceralFatTrend => 'Tendance de la graisse viscerale';

  @override
  String get history => 'Historique';

  @override
  String get noMeasurementsYet => 'Pas encore de mesures';

  @override
  String get startTrackingToSeeProgress =>
      'Commencez le suivi pour voir votre progres';

  @override
  String get doctorsReport => 'Rapport medical';

  @override
  String olderMeasurements(int count) {
    return '$count mesures plus anciennes';
  }

  @override
  String get unlockFullProgress => 'Debloquer pour voir tout le progres';

  @override
  String get settings => 'Parametres';

  @override
  String get profiles => 'Profils';

  @override
  String get addProfile => 'Ajouter un profil';

  @override
  String get currentProfile => 'Profil actuel';

  @override
  String get age => 'Age';

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
    return 'Supprimer \"$name\" et toutes ses mesures ? Cette action est irreversible.';
  }

  @override
  String get goals => 'Objectifs';

  @override
  String get vatGoal => 'Objectif VAT';

  @override
  String get notSet => 'Non defini';

  @override
  String get setVatGoal => 'Definir l\'objectif VAT';

  @override
  String get setVatGoalDescription =>
      'Definissez une surface de graisse viscerale cible a suivre sur votre graphique de progres.';

  @override
  String get goalHint => 'ex. 100';

  @override
  String get goalTip =>
      'Conseil : En dessous de 100 cm² est considere comme sain';

  @override
  String get clear => 'Effacer';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Sauvegarder';

  @override
  String get units => 'Unites';

  @override
  String get metric => 'Metrique';

  @override
  String get metricUnits => 'kg, cm';

  @override
  String get imperial => 'Imperial';

  @override
  String get imperialUnits => 'lbs, pouces';

  @override
  String get reminders => 'Rappels';

  @override
  String get measurementReminder => 'Rappel de mesure';

  @override
  String get frequency => 'Frequence';

  @override
  String get off => 'Desactive';

  @override
  String get weekly => 'Hebdomadaire';

  @override
  String get monthly => 'Mensuel';

  @override
  String get noRemindersScheduled => 'Aucun rappel programme';

  @override
  String everyDayAt(String day, String time) {
    return 'Chaque $day a $time';
  }

  @override
  String everyOrdinalAt(String ordinal, String time) {
    return 'Chaque $ordinal a $time';
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
  String get system => 'Systeme';

  @override
  String get followSystemSettings => 'Suivre les parametres systeme';

  @override
  String get light => 'Clair';

  @override
  String get alwaysLightTheme => 'Toujours utiliser le theme clair';

  @override
  String get dark => 'Sombre';

  @override
  String get alwaysDarkTheme => 'Toujours utiliser le theme sombre';

  @override
  String get data => 'Donnees';

  @override
  String get resetAllData => 'Reinitialiser toutes les donnees';

  @override
  String get deleteAllProfilesAndMeasurements =>
      'Supprimer tous les profils et mesures';

  @override
  String get resetAllDataConfirmation =>
      'Cela supprimera TOUS les profils et mesures. Vous devrez configurer un nouveau profil. Cette action est irreversible.';

  @override
  String get reset => 'Reinitialiser';

  @override
  String get delete => 'Supprimer';

  @override
  String get developerOptions => 'Options developpeur';

  @override
  String get premiumStatusOverride => 'Remplacer le statut premium';

  @override
  String get simulatingPremium => 'Simulation Premium';

  @override
  String get simulatingFree => 'Simulation Gratuit';

  @override
  String get usingRealStatus => 'Utilisation du statut reel';

  @override
  String get actual => 'reel';

  @override
  String get premium => 'Premium';

  @override
  String get free => 'Gratuit';

  @override
  String get real => 'Reel';

  @override
  String get pro => 'PRO';

  @override
  String get multipleProfiles => 'Profils multiples';

  @override
  String get unlimitedHistory => 'Historique illimite';

  @override
  String get help => 'Aide';

  @override
  String get aboutVisqo => 'A propos de Visqo';

  @override
  String get aboutVisqoDescription =>
      'Visqo vous aide a estimer votre graisse viscerale a l\'aide de simples mesures corporelles. La graisse viscerale est la graisse stockee autour de vos organes internes et est liee a des risques accrus pour la sante. En suivant vos mesures dans le temps, vous pouvez surveiller votre progres vers une meilleure composition corporelle.';

  @override
  String get howToMeasureWaist => 'Comment mesurer le tour de taille';

  @override
  String get instructions => 'Instructions';

  @override
  String get waistStep1 =>
      'Tenez-vous debout, pieds joints et bras detendus le long du corps.';

  @override
  String get waistStep2 =>
      'Localisez le bas de vos cotes et le haut de vos os iliaques (crete iliaque).';

  @override
  String get waistStep3 =>
      'Placez le metre ruban a mi-chemin entre ces deux points, approximativement au niveau du nombril.';

  @override
  String get waistStep4 =>
      'Enroulez le ruban autour de votre taille en le gardant parallele au sol.';

  @override
  String get waistStep5 =>
      'Expirez normalement et prenez la mesure sans trop serrer le ruban.';

  @override
  String get waistTip =>
      'Mesurez directement sur la peau ou sur des vetements legers pour plus de precision.';

  @override
  String get howToMeasureThigh => 'Comment mesurer le tour de cuisse';

  @override
  String get thighStep1 =>
      'Tenez-vous debout avec le poids reparti uniformement sur les deux jambes.';

  @override
  String get thighStep2 =>
      'Identifiez le pli fessier (le pli ou vos fesses rejoignent votre cuisse).';

  @override
  String get thighStep3 =>
      'Positionnez le metre ruban juste en dessous (distal) du pli fessier.';

  @override
  String get thighStep4 =>
      'Enroulez le ruban horizontalement autour de votre cuisse, perpendiculairement a l\'axe de la cuisse.';

  @override
  String get thighStep5 =>
      'Gardez vos muscles detendus et lisez la mesure sans comprimer la peau.';

  @override
  String get thighTip =>
      'Mesurez les deux cuisses et utilisez la moyenne si elles different significativement.';

  @override
  String get settingGoalTitle => 'Definir un objectif';

  @override
  String get settingGoalStep1 =>
      'Allez dans les Parametres depuis l\'ecran de calcul.';

  @override
  String get settingGoalStep2 =>
      'Appuyez sur \"Definir l\'objectif VAT\" dans la section Objectifs.';

  @override
  String get settingGoalStep3 =>
      'Entrez votre valeur VAT cible et sauvegardez.';

  @override
  String get settingGoalDescription =>
      'Vous pouvez definir un objectif VAT personnel pour suivre votre progres vers une meilleure composition corporelle.';

  @override
  String get goalChartDescription =>
      'Une fois defini, votre objectif apparaitra comme une ligne pointillee verte sur le graphique de progres, vous aidant a visualiser a quel point vous etes proche de votre cible.';

  @override
  String get goalHealthTip =>
      'Un VAT inferieur a 100 cm² est generalement considere comme sain. Consultez un professionnel de sante pour des conseils personnalises.';

  @override
  String get trendIndicatorTitle => 'Comprendre l\'indicateur de tendance';

  @override
  String get trendIndicatorDescription =>
      'L\'indicateur de tendance montre comment votre VAT a change par rapport a votre mesure precedente.';

  @override
  String get trendDecreasing => 'En baisse';

  @override
  String get trendDecreasingDesc =>
      'Votre VAT est plus bas qu\'avant. Excellent progres dans la reduction de la graisse viscerale.';

  @override
  String get trendIncreasing => 'En hausse';

  @override
  String get trendIncreasingDesc =>
      'Votre VAT est plus eleve qu\'avant. Envisagez de revoir votre alimentation et votre routine d\'exercice.';

  @override
  String get trendStable => 'Stable';

  @override
  String get trendStableDesc =>
      'Votre VAT a change de moins de 1 cm². Vos niveaux restent stables.';

  @override
  String get trendMagnitudeNote =>
      'L\'indicateur de tendance affiche egalement le changement exact en VAT (ex. -5,2) pour que vous puissiez voir l\'ampleur de la difference.';

  @override
  String get calculationTitle =>
      'Comment la graisse viscerale est-elle calculee ?';

  @override
  String get calculationDescription =>
      'Visqo utilise le modele anthropometrique de Samouda pour estimer la surface du tissu adipeux visceral (VAT) sans necessiter d\'imagerie couteuse comme les scanners CT ou l\'IRM.';

  @override
  String get calculationModelDescription =>
      'Le modele utilise des mesures corporelles simples combinees avec votre age et IMC pour predire le VAT avec une grande precision :';

  @override
  String get formulaForMen => 'Pour les hommes';

  @override
  String get formulaMen =>
      'VAT = 6 x Taille - 4,41 x Cuisse + 1,19 x Age - 213,65';

  @override
  String get accuracyMen => 'Explique 80,3% de la variance du VAT';

  @override
  String get formulaForWomen => 'Pour les femmes';

  @override
  String get formulaWomen =>
      'VAT = 2,15 x Taille - 3,63 x Cuisse + 1,46 x Age + 6,22 x IMC - 92,713';

  @override
  String get accuracyWomen => 'Explique 83,6% de la variance du VAT';

  @override
  String get resultUnit =>
      'Le resultat est exprime en cm², representant la surface transversale estimee du tissu adipeux visceral.';

  @override
  String get understandingResultsTitle => 'Comprendre vos resultats';

  @override
  String get resultsIntro =>
      'Votre resultat VAT est categorise en trois niveaux de risque :';

  @override
  String get riskHealthy => 'Sain';

  @override
  String get riskHealthyRange => 'Moins de 100 cm²';

  @override
  String get riskHealthyDesc =>
      'Niveaux normaux de graisse viscerale associes a des risques de sante plus faibles.';

  @override
  String get riskElevated => 'Eleve';

  @override
  String get riskElevatedRange => '100 - 130 cm²';

  @override
  String get riskElevatedDesc =>
      'Niveaux moderement eleves. Envisagez des changements de mode de vie.';

  @override
  String get riskHighRisk => 'Risque eleve';

  @override
  String get riskHighRiskRange => 'Plus de 130 cm²';

  @override
  String get riskHighRiskDesc =>
      'Graisse viscerale elevee associee a des risques accrus pour la sante metabolique.';

  @override
  String get learnMoreHealthRisks =>
      'En savoir plus sur les risques et conseils sante';

  @override
  String get learnMoreHealthRisksDesc =>
      'Comprenez les implications pour la sante et les moyens fondes sur des preuves pour reduire la graisse viscerale.';

  @override
  String get scientificReference => 'Reference scientifique';

  @override
  String get referenceIntro =>
      'La methode de calcul utilisee dans cette application est basee sur des recherches evaluees par des pairs :';

  @override
  String get referenceAuthors =>
      'Samouda, H., Dutour, A., Chaumoitre, K., Panuel, M., Dutour, O., & Dadoun, F.';

  @override
  String get referenceTitle =>
      'VAT=TAAT-SAAT : modele anthropometrique innovant pour predire le tissu adipeux visceral sans recourir au CT-Scan ou DXA.';

  @override
  String get referenceJournal => 'Obesity (2013), 21(1), E41-E50.';

  @override
  String get healthInsights => 'Conseils sante';

  @override
  String get aboutVisceralFat => 'A propos de la graisse viscerale';

  @override
  String get aboutVisceralFatDescription =>
      'La graisse viscerale est stockee profondement dans la cavite abdominale autour des organes internes. Contrairement a la graisse sous-cutanee, elle joue un role hormonalement actif et est liee a des risques accrus pour la sante. Decouvrez les risques et les moyens fondes sur des preuves pour la reduire.';

  @override
  String get healthRisksOfElevatedVat =>
      'Risques pour la sante d\'une graisse viscerale elevee';

  @override
  String get healthRisksSubtitle =>
      'Comprendre les risques peut aider a motiver des changements positifs';

  @override
  String get evidenceBasedTips => 'Conseils fondes sur des preuves';

  @override
  String get evidenceBasedTipsSubtitle =>
      'Actions simples pour aider a reduire la graisse viscerale';

  @override
  String get recommendedForYou => 'Recommande pour vous';

  @override
  String get maintainYourHealth => 'Maintenez votre sante';

  @override
  String get additionalTips => 'Conseils supplementaires';

  @override
  String get disclaimer =>
      'Ces informations sont a titre educatif uniquement et ne doivent pas remplacer un avis medical professionnel. Veuillez consulter un professionnel de sante pour des conseils personnalises.';

  @override
  String get riskCardiometabolic => 'Maladie cardiometabolique';

  @override
  String get riskCardiometabolicDesc =>
      'Une graisse viscerale elevee augmente significativement le risque de developper des affections cardiovasculaires et metaboliques graves.';

  @override
  String get riskCardiometabolicDetail1 =>
      'Risque accru de diabete de type 2 par resistance a l\'insuline';

  @override
  String get riskCardiometabolicDetail2 =>
      'Probabilite plus elevee d\'hypertension arterielle';

  @override
  String get riskCardiometabolicDetail3 =>
      'Profil de cholesterol defavorable (dyslipidemie)';

  @override
  String get riskCardiometabolicDetail4 =>
      'Risque accru de maladie coronarienne et d\'insuffisance cardiaque';

  @override
  String get riskStrokeMortality => 'AVC et mortalite';

  @override
  String get riskStrokeMortalityDesc =>
      'Des niveaux plus eleves de graisse viscerale sont associes a un risque accru d\'AVC et peuvent contribuer a une mortalite toutes causes plus elevee.';

  @override
  String get riskStrokeMortalityDetail1 => 'Risque eleve d\'AVC ischemique';

  @override
  String get riskStrokeMortalityDetail2 =>
      'Association avec des taux de mortalite toutes causes plus eleves';

  @override
  String get riskStrokeMortalityDetail3 =>
      'Le risque persiste meme avec un IMC normal';

  @override
  String get riskInflammation => 'Inflammation chronique';

  @override
  String get riskInflammationDesc =>
      'Le tissu adipeux visceral secrete activement des molecules inflammatoires qui favorisent l\'inflammation systemique dans tout le corps.';

  @override
  String get riskInflammationDetail1 =>
      'Secrete des cytokines inflammatoires (IL-6, TNF-alpha)';

  @override
  String get riskInflammationDetail2 =>
      'Perturbe la signalisation hormonale normale';

  @override
  String get riskInflammationDetail3 =>
      'Cree une inflammation chronique de bas grade';

  @override
  String get riskInflammationDetail4 =>
      'L\'inflammation est un facteur de risque pour de nombreuses maladies chroniques';

  @override
  String get riskLiver => 'Steatose hepatique non alcoolique';

  @override
  String get riskLiverDesc =>
      'L\'accumulation de graisse viscerale est fortement correlee avec l\'infiltration graisseuse dans le foie et des enzymes hepatiques elevees.';

  @override
  String get riskLiverDetail1 =>
      'Depots graisseux dans le tissu hepatique (steatose hepatique)';

  @override
  String get riskLiverDetail2 =>
      'Niveaux eleves d\'enzymes hepatiques (ALT, AST)';

  @override
  String get riskLiverDetail3 =>
      'Peut evoluer vers des affections hepatiques plus graves';

  @override
  String get riskLiverDetail4 =>
      'Souvent reversible avec des changements de mode de vie';

  @override
  String get riskMetabolicSyndrome => 'Syndrome metabolique';

  @override
  String get riskMetabolicSyndromeDesc =>
      'L\'adiposite viscerale est un facteur central du syndrome metabolique, un ensemble d\'affections qui augmentent le risque de maladie.';

  @override
  String get riskMetabolicSyndromeDetail1 => 'Niveaux de glycemie eleves';

  @override
  String get riskMetabolicSyndromeDetail2 => 'Hypertension arterielle';

  @override
  String get riskMetabolicSyndromeDetail3 => 'Niveaux de cholesterol anormaux';

  @override
  String get riskMetabolicSyndromeDetail4 =>
      'Obesite centrale (exces de graisse abdominale)';

  @override
  String get riskMetabolicSyndromeDetail5 =>
      'Augmente significativement le risque de maladie cardiaque et de diabete';

  @override
  String get riskCancer => 'Associations avec le cancer';

  @override
  String get riskCancerDesc =>
      'Des preuves emergentes lient la graisse viscerale a une dysregulation metabolique et a un risque plus eleve de certains cancers.';

  @override
  String get riskCancerDetail1 =>
      'Une signalisation hormonale alteree peut favoriser la croissance du cancer';

  @override
  String get riskCancerDetail2 =>
      'L\'inflammation chronique cree un environnement favorable au cancer';

  @override
  String get riskCancerDetail3 => 'Associe a certaines tumeurs malignes';

  @override
  String get riskCancerDetail4 =>
      'Recherche en cours pour comprendre les mecanismes';

  @override
  String get tipActivity => 'Activite physique reguliere';

  @override
  String get tipActivityDesc =>
      'L\'exercice aerobique regulier et l\'entrainement en force sont parmi les moyens les plus efficaces pour reduire la graisse viscerale.';

  @override
  String get tipActivityAction1 =>
      'Visez 150+ minutes par semaine d\'activite aerobique d\'intensite moderee';

  @override
  String get tipActivityAction2 =>
      'Incluez 2 jours ou plus par semaine d\'entrainement en force';

  @override
  String get tipActivityAction3 =>
      'La marche, le velo, la natation et le jogging sont d\'excellents choix';

  @override
  String get tipActivityAction4 =>
      'L\'entrainement en force aide a maintenir la masse musculaire maigre';

  @override
  String get tipDiet => 'Alimentation equilibree et riche en nutriments';

  @override
  String get tipDietDesc =>
      'Concentrez-vous sur les aliments complets et limitez les aliments transformes pour aider a reduire l\'accumulation de graisse viscerale.';

  @override
  String get tipDietAction1 =>
      'Privilegiez les legumes, fruits et cereales completes';

  @override
  String get tipDietAction2 =>
      'Choisissez des proteines maigres (poisson, volaille, legumineuses)';

  @override
  String get tipDietAction3 =>
      'Limitez les sucres ajoutes et les glucides raffines';

  @override
  String get tipDietAction4 =>
      'Reduisez la consommation d\'aliments ultra-transformes';

  @override
  String get tipDietAction5 =>
      'Choisissez des graisses saines (huile d\'olive, noix, avocat)';

  @override
  String get tipWeight => 'Gestion du poids';

  @override
  String get tipWeightDesc =>
      'Maintenir un poids sain grace a un controle calorique durable aide a reduire les reserves de graisse viscerale.';

  @override
  String get tipWeightAction1 =>
      'Creez un deficit calorique modeste pour une perte de poids progressive';

  @override
  String get tipWeightAction2 =>
      'Suivez le tour de taille comme indicateur de progres';

  @override
  String get tipWeightAction3 =>
      'Surveillez le ratio taille/hauteur (visez < 0,5)';

  @override
  String get tipWeightAction4 =>
      'Concentrez-vous sur des changements durables, pas sur les regimes drastiques';

  @override
  String get tipSedentary => 'Reduire le temps sedentaire';

  @override
  String get tipSedentaryDesc =>
      'Interrompre la position assise prolongee avec des mouvements legers contribue a la depense energetique globale.';

  @override
  String get tipSedentaryAction1 =>
      'Levez-vous et bougez toutes les 30-60 minutes';

  @override
  String get tipSedentaryAction2 =>
      'Faites des pauses marche pendant le travail';

  @override
  String get tipSedentaryAction3 => 'Utilisez un bureau debout si possible';

  @override
  String get tipSedentaryAction4 => 'Preferez les escaliers aux ascenseurs';

  @override
  String get tipSedentaryAction5 =>
      'Meme une activite legere aide a reduire la graisse viscerale';

  @override
  String get tipSleepStress => 'Sommeil de qualite et gestion du stress';

  @override
  String get tipSleepStressDesc =>
      'Un mauvais sommeil et le stress chronique augmentent le cortisol, une hormone liee a l\'accumulation de graisse abdominale.';

  @override
  String get tipSleepStressAction1 =>
      'Visez 7-9 heures de sommeil de qualite par nuit';

  @override
  String get tipSleepStressAction2 =>
      'Maintenez un horaire de sommeil regulier';

  @override
  String get tipSleepStressAction3 =>
      'Pratiquez des activites anti-stress (meditation, yoga)';

  @override
  String get tipSleepStressAction4 =>
      'Limitez le temps d\'ecran avant le coucher';

  @override
  String get tipSleepStressAction5 => 'Abordez les sources de stress chronique';

  @override
  String get tipAlcohol => 'Limiter la consommation d\'alcool';

  @override
  String get tipAlcoholDesc =>
      'L\'alcool ajoute des calories et peut favoriser l\'accumulation de graisse viscerale en cas de consommation reguliere excessive.';

  @override
  String get tipAlcoholAction1 =>
      'Limitez a une consommation moderee (1 verre/jour femmes, 2/jour hommes)';

  @override
  String get tipAlcoholAction2 =>
      'Choisissez des options moins caloriques en buvant';

  @override
  String get tipAlcoholAction3 =>
      'Evitez les episodes de consommation excessive';

  @override
  String get tipAlcoholAction4 =>
      'Envisagez des jours sans alcool chaque semaine';

  @override
  String get tipSmoking => 'Arret du tabac';

  @override
  String get tipSmokingDesc =>
      'Le tabagisme est associe a l\'accumulation de graisse centrale et amplifie le risque cardiometabolique.';

  @override
  String get tipSmokingAction1 =>
      'Arretez de fumer pour reduire l\'accumulation de graisse viscerale';

  @override
  String get tipSmokingAction2 =>
      'Cherchez des programmes de soutien ou des medicaments si necessaire';

  @override
  String get tipSmokingAction3 =>
      'Les benefices commencent dans les jours suivant l\'arret';

  @override
  String get tipSmokingAction4 =>
      'Reduit significativement le risque cardiovasculaire global';

  @override
  String get waist => 'Taille';

  @override
  String get proximalThigh => 'Cuisse proximale';

  @override
  String get lowerRib => 'Cote inferieure';

  @override
  String get hipBone => 'Os iliaque';

  @override
  String get midpoint => 'Point median';

  @override
  String get glutealCrease => 'Pli fessier';

  @override
  String get justBelowCrease => 'Juste sous le pli';

  @override
  String errorStartingApp(String error) {
    return 'Erreur au demarrage de l\'app : $error\n\nVeuillez reinstaller l\'application.';
  }

  @override
  String get language => 'Langue';

  @override
  String get english => 'Anglais';

  @override
  String get german => 'Allemand';

  @override
  String get french => 'Francais';
}
