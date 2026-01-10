// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Visqo';

  @override
  String get navCalculate => 'Berechnen';

  @override
  String get navWhatIf => 'Was-wäre-wenn';

  @override
  String get navProgress => 'Verlauf';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get welcomeTitle => 'Willkommen bei Visqo';

  @override
  String get welcomeSubtitle => 'Dein persönlicher Viszeralfett-Tracker';

  @override
  String get getStarted => 'Jetzt starten';

  @override
  String get skipAndExplore => 'Überspringen und erkunden';

  @override
  String get whatIsVatTitle => 'Was ist Viszeralfett?';

  @override
  String get hiddenFatTitle => 'Verstecktes Fett';

  @override
  String get hiddenFatDesc =>
      'Viszeralfett lagert sich tief im Bauchraum ab und umgibt lebenswichtige Organe wie Leber, Magen und Darm.';

  @override
  String get healthRisksTitle => 'Gesundheitsrisiken';

  @override
  String get healthRisksDesc =>
      'Erhöhte Werte stehen in Zusammenhang mit einem höheren Risiko für Herzerkrankungen, Typ-2-Diabetes und dem metabolischen Syndrom.';

  @override
  String get notVisibleTitle => 'Nicht immer sichtbar';

  @override
  String get notVisibleDesc =>
      'Anders als Unterhautfettgewebe kann Viszeralfett auch bei schlanken Personen erhöht sein.';

  @override
  String get continueButton => 'Weiter';

  @override
  String get howItWorksTitle => 'So funktioniert Visqo';

  @override
  String get stepMeasure => 'Messen';

  @override
  String get stepMeasureDesc =>
      'Nimm einfache Körpermaße: Taillen- und Oberschenkelumfang.';

  @override
  String get stepCalculate => 'Berechnen';

  @override
  String get stepCalculateDesc =>
      'Visqo verwendet eine wissenschaftlich validierte Formel zur Schätzung deines Viszeralfettanteils.';

  @override
  String get stepTrack => 'Verfolgen';

  @override
  String get stepTrackDesc =>
      'Beobachte deinen Fortschritt über Zeit mit Diagrammen und Trendanzeigen.';

  @override
  String get scientificNote =>
      'Basierend auf wissenschaftlich geprüfter Forschung mit 80–84 % Genauigkeit im Vergleich zu CT-Scans.';

  @override
  String get setUpProfile => 'Profil einrichten';

  @override
  String get profileSetupTitle => 'Lass uns dein Profil einrichten';

  @override
  String get profileSetupSubtitle =>
      'Diese Angaben werden für eine genaue Berechnung deines Viszeralfetts benötigt.';

  @override
  String get newProfileTitle => 'Neues Profil';

  @override
  String get createNewProfile => 'Neues Profil erstellen';

  @override
  String get profileName => 'Profilname';

  @override
  String get profileNameHint => 'z. B. Max, Mama, Papa';

  @override
  String get pleaseEnterProfileName => 'Bitte gib einen Profilnamen ein';

  @override
  String get createProfile => 'Profil erstellen';

  @override
  String get startTracking => 'Tracking starten';

  @override
  String get sexLabel => 'Geschlecht';

  @override
  String get male => 'Männlich';

  @override
  String get female => 'Weiblich';

  @override
  String get dateOfBirth => 'Geburtsdatum';

  @override
  String get height => 'Körpergröße';

  @override
  String get createProfileToStart => 'Erstelle ein Profil, um zu starten';

  @override
  String get createProfileExplanation =>
      'Um dein Viszeralfett zu berechnen, benötigen wir einige Angaben wie Geschlecht, Alter und Körpergröße.';

  @override
  String get todaysMeasurements => 'Heutige Messungen';

  @override
  String get weight => 'Gewicht';

  @override
  String get enterWeight => 'Gewicht eingeben';

  @override
  String get waistCircumference => 'Taillenumfang';

  @override
  String get enterWaist => 'Taille eingeben';

  @override
  String get thighCircumference => 'Oberschenkelumfang';

  @override
  String get enterThigh => 'Oberschenkel eingeben';

  @override
  String get calculateAndSave => 'Berechnen & speichern';

  @override
  String get noPreviousMeasurements => 'Keine früheren Messungen';

  @override
  String get measured => 'Gemessen';

  @override
  String get today => 'Heute';

  @override
  String get result => 'Ergebnis';

  @override
  String get viewHealthInsights => 'Gesundheitstipps ansehen';

  @override
  String get viewProgressChart => 'Verlaufsdiagramm ansehen';

  @override
  String get shareResult => 'Ergebnis teilen';

  @override
  String get visceralFatTrend => 'Viszeralfett-Trend';

  @override
  String get history => 'Verlauf';

  @override
  String get noMeasurementsYet => 'Noch keine Messungen';

  @override
  String get startTrackingToSeeProgress =>
      'Starte das Tracking, um deinen Fortschritt zu sehen';

  @override
  String get doctorsReport => 'Arztbericht';

  @override
  String olderMeasurements(int count) {
    return '$count ältere Messungen';
  }

  @override
  String get unlockFullProgress =>
      'Freischalten, um den gesamten Verlauf zu sehen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get profiles => 'Profile';

  @override
  String get addProfile => 'Profil hinzufügen';

  @override
  String get currentProfile => 'Aktuelles Profil';

  @override
  String get age => 'Alter';

  @override
  String get years => 'Jahre';

  @override
  String ageYears(int age) {
    return '$age Jahre';
  }

  @override
  String get deleteProfile => 'Profil löschen';

  @override
  String deleteProfileConfirmation(String name) {
    return '\"$name\" und alle zugehörigen Messungen löschen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String get goals => 'Ziele';

  @override
  String get vatGoal => 'VAT-Ziel';

  @override
  String get notSet => 'Nicht festgelegt';

  @override
  String get setVatGoal => 'VAT-Ziel festlegen';

  @override
  String get setVatGoalDescription =>
      'Lege einen Zielwert für das Viszeralfett fest, der im Verlaufsdiagramm angezeigt wird.';

  @override
  String get goalHint => 'z. B. 100';

  @override
  String get goalTip => 'Tipp: Unter 100 cm² gilt als gesund';

  @override
  String get clear => 'Löschen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get units => 'Einheiten';

  @override
  String get metric => 'Metrisch';

  @override
  String get metricUnits => 'kg, cm';

  @override
  String get imperial => 'Imperial';

  @override
  String get imperialUnits => 'lbs, Zoll';

  @override
  String get reminders => 'Erinnerungen';

  @override
  String get measurementReminder => 'Messerinnerung';

  @override
  String get frequency => 'Häufigkeit';

  @override
  String get off => 'Aus';

  @override
  String get weekly => 'Wöchentlich';

  @override
  String get monthly => 'Monatlich';

  @override
  String get noRemindersScheduled => 'Keine Erinnerungen geplant';

  @override
  String everyDayAt(String day, String time) {
    return 'Jeden $day um $time';
  }

  @override
  String everyOrdinalAt(String ordinal, String time) {
    return 'Jeden $ordinal um $time';
  }

  @override
  String get time => 'Uhrzeit';

  @override
  String get dayOfWeek => 'Wochentag';

  @override
  String get dayOfMonth => 'Tag im Monat';

  @override
  String get monday => 'Montag';

  @override
  String get tuesday => 'Dienstag';

  @override
  String get wednesday => 'Mittwoch';

  @override
  String get thursday => 'Donnerstag';

  @override
  String get friday => 'Freitag';

  @override
  String get saturday => 'Samstag';

  @override
  String get sunday => 'Sonntag';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get system => 'System';

  @override
  String get followSystemSettings => 'Systemeinstellung verwenden';

  @override
  String get light => 'Hell';

  @override
  String get alwaysLightTheme => 'Immer helles Design verwenden';

  @override
  String get dark => 'Dunkel';

  @override
  String get alwaysDarkTheme => 'Immer dunkles Design verwenden';

  @override
  String get data => 'Daten';

  @override
  String get resetAllData => 'Alle Daten zurücksetzen';

  @override
  String get deleteAllProfilesAndMeasurements =>
      'Alle Profile und Messungen löschen';

  @override
  String get resetAllDataConfirmation =>
      'Dadurch werden ALLE Profile und Messungen gelöscht. Du musst anschließend ein neues Profil anlegen. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get delete => 'Löschen';

  @override
  String get developerOptions => 'Entwickleroptionen';

  @override
  String get premiumStatusOverride => 'Premium-Status überschreiben';

  @override
  String get simulatingPremium => 'Premium simuliert';

  @override
  String get simulatingFree => 'Kostenlos simuliert';

  @override
  String get usingRealStatus => 'Echter Status';

  @override
  String get actual => 'tatsächlich';

  @override
  String get premium => 'Premium';

  @override
  String get free => 'Kostenlos';

  @override
  String get real => 'Echt';

  @override
  String get pro => 'PRO';

  @override
  String get multipleProfiles => 'Mehrere Profile';

  @override
  String get unlimitedHistory => 'Unbegrenzter Verlauf';

  @override
  String get help => 'Hilfe';

  @override
  String get aboutVisqo => 'Über Visqo';

  @override
  String get aboutVisqoDescription =>
      'Visqo hilft dir, dein Viszeralfett anhand einfacher Körpermaße zu schätzen. Viszeralfett umgibt die inneren Organe und ist mit erhöhten Gesundheitsrisiken verbunden. Durch regelmäßiges Tracking kannst du deinen Fortschritt zu einer gesünderen Körperzusammensetzung beobachten.';

  @override
  String get howToMeasureWaist => 'So misst du den Taillenumfang';

  @override
  String get instructions => 'Anleitung';

  @override
  String get waistStep1 =>
      'Stehe aufrecht mit geschlossenen Füßen und entspannten Armen.';

  @override
  String get waistStep2 =>
      'Finde die untere Rippenkante und den oberen Rand deines Hüftknochens (Beckenkamm).';

  @override
  String get waistStep3 =>
      'Lege das Maßband in der Mitte zwischen diesen beiden Punkten an, etwa auf Nabelhöhe.';

  @override
  String get waistStep4 => 'Führe das Maßband waagerecht um deine Taille.';

  @override
  String get waistStep5 =>
      'Atme normal aus und lies den Wert ab, ohne das Band zu straff zu ziehen.';

  @override
  String get waistTip =>
      'Miss direkt auf der Haut oder über leichter Kleidung für genaue Ergebnisse.';

  @override
  String get howToMeasureThigh => 'So misst du den Oberschenkelumfang';

  @override
  String get thighStep1 =>
      'Stehe aufrecht mit gleichmäßig verteiltem Gewicht auf beiden Beinen.';

  @override
  String get thighStep2 =>
      'Finde die Gesäßfalte (dort, wo das Gesäß auf den Oberschenkel trifft).';

  @override
  String get thighStep3 =>
      'Lege das Maßband knapp unterhalb der Gesäßfalte an.';

  @override
  String get thighStep4 =>
      'Führe das Maßband waagerecht um den Oberschenkel, rechtwinklig zur Beinachse.';

  @override
  String get thighStep5 =>
      'Halte die Muskeln entspannt und lies den Wert ab, ohne die Haut einzudrücken.';

  @override
  String get thighTip =>
      'Miss beide Oberschenkel und nimm den Durchschnitt, falls sie deutlich unterschiedlich sind.';

  @override
  String get settingGoalTitle => 'Ein Ziel festlegen';

  @override
  String get settingGoalStep1 =>
      'Öffne die Einstellungen über den Rechner-Bildschirm.';

  @override
  String get settingGoalStep2 =>
      'Tippe im Bereich \'Ziele\' auf \'VAT-Ziel festlegen\'.';

  @override
  String get settingGoalStep3 => 'Gib deinen Zielwert ein und speichere.';

  @override
  String get settingGoalDescription =>
      'Du kannst ein persönliches VAT-Ziel festlegen, um deinen Fortschritt zu einer gesünderen Körperzusammensetzung zu verfolgen.';

  @override
  String get goalChartDescription =>
      'Nach dem Festlegen erscheint dein Ziel als grüne gestrichelte Linie im Verlaufsdiagramm, damit du siehst, wie nah du deinem Ziel bist.';

  @override
  String get goalHealthTip =>
      'Ein VAT-Wert unter 100 cm² gilt allgemein als gesund. Für eine individuelle Beratung wende dich an deinen Arzt.';

  @override
  String get trendIndicatorTitle => 'Die Trendanzeige verstehen';

  @override
  String get trendIndicatorDescription =>
      'Die Trendanzeige zeigt, wie sich dein VAT-Wert im Vergleich zur vorherigen Messung verändert hat.';

  @override
  String get trendDecreasing => 'Sinkend';

  @override
  String get trendDecreasingDesc =>
      'Dein VAT-Wert ist niedriger als zuvor. Toller Fortschritt bei der Reduzierung des Viszeralfetts!';

  @override
  String get trendIncreasing => 'Steigend';

  @override
  String get trendIncreasingDesc =>
      'Dein VAT-Wert ist höher als zuvor. Überprüfe deine Ernährung und dein Bewegungsverhalten.';

  @override
  String get trendStable => 'Stabil';

  @override
  String get trendStableDesc =>
      'Dein VAT-Wert hat sich um weniger als 1 cm² verändert. Deine Werte bleiben konstant.';

  @override
  String get trendMagnitudeNote =>
      'Die Trendanzeige zeigt auch die genaue Veränderung des VAT-Werts (z. B. −5,2), damit du das Ausmaß der Veränderung erkennst.';

  @override
  String get calculationTitle => 'Wie wird das Viszeralfett berechnet?';

  @override
  String get calculationDescription =>
      'Visqo verwendet das anthropometrische Modell nach Samouda zur Schätzung der viszeralen Fettgewebsfläche (VAT) – ganz ohne teure Bildgebung wie CT oder MRT.';

  @override
  String get calculationModelDescription =>
      'Das Modell kombiniert einfache Körpermaße mit Alter und BMI, um das VAT mit hoher Genauigkeit vorherzusagen:';

  @override
  String get formulaForMen => 'Für Männer';

  @override
  String get formulaMen =>
      'VAT = 6 × Taille − 4,41 × Oberschenkel + 1,19 × Alter − 213,65';

  @override
  String get accuracyMen => 'Erklärt 80,3 % der VAT-Varianz';

  @override
  String get formulaForWomen => 'Für Frauen';

  @override
  String get formulaWomen =>
      'VAT = 2,15 × Taille − 3,63 × Oberschenkel + 1,46 × Alter + 6,22 × BMI − 92,713';

  @override
  String get accuracyWomen => 'Erklärt 83,6 % der VAT-Varianz';

  @override
  String get resultUnit =>
      'Das Ergebnis wird in cm² angegeben und stellt die geschätzte Querschnittsfläche des viszeralen Fettgewebes dar.';

  @override
  String get understandingResultsTitle => 'Deine Ergebnisse verstehen';

  @override
  String get resultsIntro =>
      'Dein VAT-Ergebnis wird in drei Risikostufen eingeteilt:';

  @override
  String get riskHealthy => 'Gesund';

  @override
  String get riskHealthyRange => 'Unter 100 cm²';

  @override
  String get riskHealthyDesc =>
      'Normale Viszeralfettwerte mit geringerem Gesundheitsrisiko.';

  @override
  String get riskElevated => 'Erhöht';

  @override
  String get riskElevatedRange => '100–130 cm²';

  @override
  String get riskElevatedDesc =>
      'Moderat erhöhte Werte. Lebensstiländerungen sind empfehlenswert.';

  @override
  String get riskHighRisk => 'Hohes Risiko';

  @override
  String get riskHighRiskRange => 'Über 130 cm²';

  @override
  String get riskHighRiskDesc =>
      'Hohes Viszeralfett ist mit erhöhten metabolischen Gesundheitsrisiken verbunden.';

  @override
  String get learnMoreHealthRisks => 'Mehr über Gesundheitsrisiken & Tipps';

  @override
  String get learnMoreHealthRisksDesc =>
      'Erfahre mehr über die gesundheitlichen Auswirkungen und evidenzbasierte Wege zur Reduzierung von Viszeralfett.';

  @override
  String get scientificReference => 'Wissenschaftliche Referenz';

  @override
  String get referenceIntro =>
      'Die in dieser App verwendete Berechnungsmethode basiert auf wissenschaftlich geprüfter Forschung:';

  @override
  String get referenceAuthors =>
      'Samouda, H., Dutour, A., Chaumoitre, K., Panuel, M., Dutour, O., & Dadoun, F.';

  @override
  String get referenceTitle =>
      'VAT=TAAT-SAAT: Ein innovatives anthropometrisches Modell zur Vorhersage des viszeralen Fettgewebes ohne CT oder DXA.';

  @override
  String get referenceJournal => 'Obesity (2013), 21(1), E41–E50.';

  @override
  String get healthInsights => 'Gesundheitstipps';

  @override
  String get aboutVisceralFat => 'Über Viszeralfett';

  @override
  String get aboutVisceralFatDescription =>
      'Viszeralfett liegt tief in der Bauchhöhle und umgibt die inneren Organe. Im Gegensatz zum Unterhautfettgewebe ist es hormonell aktiv und mit erhöhten Gesundheitsrisiken verbunden. Erfahre mehr über die Risiken und evidenzbasierte Methoden zur Reduzierung.';

  @override
  String get healthRisksOfElevatedVat =>
      'Gesundheitsrisiken bei erhöhtem Viszeralfett';

  @override
  String get healthRisksSubtitle =>
      'Das Verständnis der Risiken kann positive Veränderungen motivieren';

  @override
  String get evidenceBasedTips => 'Evidenzbasierte Tipps';

  @override
  String get evidenceBasedTipsSubtitle =>
      'Einfache Maßnahmen zur Reduzierung von Viszeralfett';

  @override
  String get recommendedForYou => 'Für dich empfohlen';

  @override
  String get maintainYourHealth => 'Erhalte deine Gesundheit';

  @override
  String get additionalTips => 'Weitere Tipps';

  @override
  String get disclaimer =>
      'Diese Informationen dienen nur zu Aufklärungszwecken und ersetzen keine professionelle medizinische Beratung. Bitte wende dich für eine individuelle Beratung an deinen Arzt.';

  @override
  String get riskCardiometabolic => 'Kardiometabolische Erkrankungen';

  @override
  String get riskCardiometabolicDesc =>
      'Erhöhtes Viszeralfett steigert das Risiko für schwerwiegende Herz-Kreislauf- und Stoffwechselerkrankungen erheblich.';

  @override
  String get riskCardiometabolicDetail1 =>
      'Erhöhtes Risiko für Typ-2-Diabetes durch Insulinresistenz';

  @override
  String get riskCardiometabolicDetail2 =>
      'Höheres Risiko für Bluthochdruck (Hypertonie)';

  @override
  String get riskCardiometabolicDetail3 =>
      'Ungünstiges Cholesterinprofil (Dyslipidämie)';

  @override
  String get riskCardiometabolicDetail4 =>
      'Erhöhtes Risiko für koronare Herzkrankheit und Herzinsuffizienz';

  @override
  String get riskStrokeMortality => 'Schlaganfall und Sterblichkeit';

  @override
  String get riskStrokeMortalityDesc =>
      'Höhere Viszeralfettwerte sind mit einem erhöhten Schlaganfallrisiko verbunden und können zu einer höheren Gesamtsterblichkeit beitragen.';

  @override
  String get riskStrokeMortalityDetail1 =>
      'Erhöhtes Risiko für ischämischen Schlaganfall';

  @override
  String get riskStrokeMortalityDetail2 =>
      'Zusammenhang mit höherer Gesamtsterblichkeit';

  @override
  String get riskStrokeMortalityDetail3 =>
      'Das Risiko besteht auch bei normalem BMI';

  @override
  String get riskInflammation => 'Chronische Entzündung';

  @override
  String get riskInflammationDesc =>
      'Viszerales Fettgewebe setzt aktiv entzündungsfördernde Moleküle frei, die systemische Entzündungen im gesamten Körper fördern.';

  @override
  String get riskInflammationDetail1 =>
      'Freisetzung entzündungsfördernder Zytokine (IL-6, TNF-alpha)';

  @override
  String get riskInflammationDetail2 => 'Störung der normalen Hormonregulation';

  @override
  String get riskInflammationDetail3 =>
      'Erzeugt niedriggradige chronische Entzündung';

  @override
  String get riskInflammationDetail4 =>
      'Entzündung ist ein Risikofaktor für viele chronische Erkrankungen';

  @override
  String get riskLiver => 'Nicht-alkoholische Fettleber (NAFLD)';

  @override
  String get riskLiverDesc =>
      'Die Ansammlung von Viszeralfett korreliert stark mit Fetteinlagerungen in der Leber und erhöhten Leberenzymwerten.';

  @override
  String get riskLiverDetail1 =>
      'Fetteinlagerungen im Lebergewebe (hepatische Steatose)';

  @override
  String get riskLiverDetail2 => 'Erhöhte Leberenzymwerte (ALT, AST)';

  @override
  String get riskLiverDetail3 =>
      'Kann zu schwerwiegenderen Lebererkrankungen fortschreiten';

  @override
  String get riskLiverDetail4 => 'Oft durch Lebensstiländerungen reversibel';

  @override
  String get riskMetabolicSyndrome => 'Metabolisches Syndrom';

  @override
  String get riskMetabolicSyndromeDesc =>
      'Viszerale Adipositas ist ein Haupttreiber des metabolischen Syndroms – einer Kombination von Faktoren, die das Krankheitsrisiko erhöhen.';

  @override
  String get riskMetabolicSyndromeDetail1 => 'Erhöhte Blutzuckerwerte';

  @override
  String get riskMetabolicSyndromeDetail2 => 'Bluthochdruck';

  @override
  String get riskMetabolicSyndromeDetail3 => 'Veränderte Cholesterinwerte';

  @override
  String get riskMetabolicSyndromeDetail4 =>
      'Zentrale Adipositas (überschüssiges Bauchfett)';

  @override
  String get riskMetabolicSyndromeDetail5 =>
      'Deutlich erhöhtes Risiko für Herzerkrankungen und Diabetes';

  @override
  String get riskCancer => 'Zusammenhang mit Krebs';

  @override
  String get riskCancerDesc =>
      'Neue Erkenntnisse verbinden Viszeralfett mit Stoffwechselstörungen und einem erhöhten Risiko für bestimmte Krebsarten.';

  @override
  String get riskCancerDetail1 =>
      'Veränderte Hormonsignale können das Krebswachstum fördern';

  @override
  String get riskCancerDetail2 =>
      'Chronische Entzündung schafft ein krebsförderndes Umfeld';

  @override
  String get riskCancerDetail3 =>
      'Assoziation mit bestimmten bösartigen Tumoren';

  @override
  String get riskCancerDetail4 =>
      'Die Forschung zu den Mechanismen ist noch im Gange';

  @override
  String get tipActivity => 'Regelmäßige körperliche Aktivität';

  @override
  String get tipActivityDesc =>
      'Regelmäßiges Ausdauer- und Krafttraining gehören zu den wirksamsten Methoden zur Reduzierung von Viszeralfett.';

  @override
  String get tipActivityAction1 =>
      'Strebe mindestens 150 Minuten moderate Ausdaueraktivität pro Woche an';

  @override
  String get tipActivityAction2 =>
      'Integriere an mindestens 2 Tagen pro Woche Krafttraining';

  @override
  String get tipActivityAction3 =>
      'Gehen, Radfahren, Schwimmen und Joggen sind hervorragende Optionen';

  @override
  String get tipActivityAction4 =>
      'Krafttraining hilft, die Muskelmasse zu erhalten';

  @override
  String get tipDiet => 'Ausgewogene, nährstoffreiche Ernährung';

  @override
  String get tipDietDesc =>
      'Setze auf vollwertige Lebensmittel und reduziere verarbeitete Produkte, um die Ansammlung von Viszeralfett zu verringern.';

  @override
  String get tipDietAction1 => 'Bevorzuge Gemüse, Obst und Vollkornprodukte';

  @override
  String get tipDietAction2 =>
      'Wähle magere Proteinquellen (Fisch, Geflügel, Hülsenfrüchte)';

  @override
  String get tipDietAction3 =>
      'Reduziere zugesetzten Zucker und raffinierte Kohlenhydrate';

  @override
  String get tipDietAction4 => 'Vermeide stark verarbeitete Lebensmittel';

  @override
  String get tipDietAction5 =>
      'Setze auf gesunde Fette (Olivenöl, Nüsse, Avocado)';

  @override
  String get tipWeight => 'Gewichtsmanagement';

  @override
  String get tipWeightDesc =>
      'Ein gesundes Gewicht durch nachhaltige Kalorienkontrolle zu halten, hilft, Viszeralfettreserven zu reduzieren.';

  @override
  String get tipWeightAction1 =>
      'Schaffe ein moderates Kaloriendefizit für schrittweisen Gewichtsverlust';

  @override
  String get tipWeightAction2 =>
      'Verfolge den Taillenumfang als Fortschrittsindikator';

  @override
  String get tipWeightAction3 =>
      'Achte auf das Taille-zu-Körpergröße-Verhältnis (Ziel: unter 0,5)';

  @override
  String get tipWeightAction4 =>
      'Setze auf nachhaltige Veränderungen statt Crash-Diäten';

  @override
  String get tipSedentary => 'Sitzzeit reduzieren';

  @override
  String get tipSedentaryDesc =>
      'Das Unterbrechen von langem Sitzen durch leichte Bewegung trägt zum Gesamtenergieverbrauch bei.';

  @override
  String get tipSedentaryAction1 =>
      'Stehe alle 30–60 Minuten auf und bewege dich';

  @override
  String get tipSedentaryAction2 => 'Mache Spaziergänge während der Arbeit';

  @override
  String get tipSedentaryAction3 =>
      'Nutze einen Stehschreibtisch, wenn möglich';

  @override
  String get tipSedentaryAction4 => 'Nimm die Treppe statt den Aufzug';

  @override
  String get tipSedentaryAction5 =>
      'Selbst leichte Aktivität hilft, Viszeralfett zu reduzieren';

  @override
  String get tipSleepStress => 'Guter Schlaf und Stressmanagement';

  @override
  String get tipSleepStressDesc =>
      'Schlechter Schlaf und chronischer Stress erhöhen den Cortisolspiegel – ein Hormon, das mit der Ansammlung von Bauchfett in Verbindung steht.';

  @override
  String get tipSleepStressAction1 =>
      'Strebe 7–9 Stunden guten Schlaf pro Nacht an';

  @override
  String get tipSleepStressAction2 =>
      'Halte einen regelmäßigen Schlafrhythmus ein';

  @override
  String get tipSleepStressAction3 =>
      'Praktiziere stressreduzierende Aktivitäten (Meditation, Yoga)';

  @override
  String get tipSleepStressAction4 =>
      'Reduziere die Bildschirmzeit vor dem Schlafengehen';

  @override
  String get tipSleepStressAction5 =>
      'Gehe die Ursachen von chronischem Stress an';

  @override
  String get tipAlcohol => 'Alkoholkonsum einschränken';

  @override
  String get tipAlcoholDesc =>
      'Alkohol liefert zusätzliche Kalorien und kann bei regelmäßigem übermäßigem Konsum die Viszeralfettansammlung fördern.';

  @override
  String get tipAlcoholAction1 =>
      'Beschränke dich auf moderaten Konsum (1 Getränk/Tag für Frauen, 2 für Männer)';

  @override
  String get tipAlcoholAction2 => 'Wähle kalorienärmere Getränke';

  @override
  String get tipAlcoholAction3 => 'Vermeide Rauschtrinken';

  @override
  String get tipAlcoholAction4 => 'Plane alkoholfreie Tage pro Woche ein';

  @override
  String get tipSmoking => 'Mit dem Rauchen aufhören';

  @override
  String get tipSmokingDesc =>
      'Rauchen wird mit zentraler Fettansammlung in Verbindung gebracht und verstärkt kardiometabolische Risiken.';

  @override
  String get tipSmokingAction1 =>
      'Höre mit dem Rauchen auf, um die Viszeralfettansammlung zu reduzieren';

  @override
  String get tipSmokingAction2 =>
      'Nutze bei Bedarf Unterstützungsprogramme oder Medikamente';

  @override
  String get tipSmokingAction3 =>
      'Die gesundheitlichen Vorteile beginnen schon Tage nach dem Aufhören';

  @override
  String get tipSmokingAction4 =>
      'Senkt das kardiovaskuläre Gesamtrisiko erheblich';

  @override
  String get waist => 'Taille';

  @override
  String get proximalThigh => 'Oberer Oberschenkel';

  @override
  String get lowerRib => 'Untere Rippe';

  @override
  String get hipBone => 'Hüftknochen';

  @override
  String get midpoint => 'Mittelpunkt';

  @override
  String get glutealCrease => 'Gesäßfalte';

  @override
  String get justBelowCrease => 'Knapp unterhalb der Falte';

  @override
  String errorStartingApp(String error) {
    return 'Fehler beim App-Start: $error\n\nBitte installiere die App neu.';
  }

  @override
  String get language => 'Sprache';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get french => 'Französisch';
}
