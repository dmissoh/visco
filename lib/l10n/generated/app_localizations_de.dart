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
  String get navWhatIf => 'Was-Wenn';

  @override
  String get navProgress => 'Fortschritt';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get welcomeTitle => 'Willkommen bei Visqo';

  @override
  String get welcomeSubtitle => 'Dein persoenlicher Viszeralfett-Tracker';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get skipAndExplore => 'Ueberspringen und erkunden';

  @override
  String get whatIsVatTitle => 'Was ist Viszeralfett?';

  @override
  String get hiddenFatTitle => 'Verstecktes Fett';

  @override
  String get hiddenFatDesc =>
      'Viszeralfett wird tief im Bauchraum gespeichert und umgibt lebenswichtige Organe wie Leber, Magen und Darm.';

  @override
  String get healthRisksTitle => 'Gesundheitsrisiken';

  @override
  String get healthRisksDesc =>
      'Hohe Werte sind mit einem erhoehten Risiko fuer Herzerkrankungen, Typ-2-Diabetes und metabolischem Syndrom verbunden.';

  @override
  String get notVisibleTitle => 'Nicht immer sichtbar';

  @override
  String get notVisibleDesc =>
      'Im Gegensatz zum Unterhautfett kann Viszeralfett auch bei schlank wirkenden Menschen hoch sein.';

  @override
  String get continueButton => 'Weiter';

  @override
  String get howItWorksTitle => 'So funktioniert Visqo';

  @override
  String get stepMeasure => 'Messen';

  @override
  String get stepMeasureDesc =>
      'Nimm einfache Koerpermasse: Taillen- und Oberschenkelumfang.';

  @override
  String get stepCalculate => 'Berechnen';

  @override
  String get stepCalculateDesc =>
      'Visqo verwendet eine wissenschaftlich validierte Formel zur Schaetzung deiner Viszeralfettflaeche.';

  @override
  String get stepTrack => 'Verfolgen';

  @override
  String get stepTrackDesc =>
      'Ueberwache deinen Fortschritt ueber die Zeit mit Diagrammen und Trends.';

  @override
  String get scientificNote =>
      'Basierend auf begutachteter Forschung mit 80-84% Genauigkeit im Vergleich zu CT-Scans.';

  @override
  String get setUpProfile => 'Profil einrichten';

  @override
  String get profileSetupTitle => 'Lass uns dein Profil einrichten';

  @override
  String get profileSetupSubtitle =>
      'Diese Informationen werden verwendet, um dein Viszeralfett genau zu berechnen.';

  @override
  String get newProfileTitle => 'Neues Profil';

  @override
  String get createNewProfile => 'Neues Profil erstellen';

  @override
  String get profileName => 'Profilname';

  @override
  String get profileNameHint => 'z.B. Max, Mama, Papa';

  @override
  String get pleaseEnterProfileName => 'Bitte gib einen Profilnamen ein';

  @override
  String get createProfile => 'Profil erstellen';

  @override
  String get startTracking => 'Tracking starten';

  @override
  String get sexLabel => 'Geschlecht';

  @override
  String get male => 'Maennlich';

  @override
  String get female => 'Weiblich';

  @override
  String get dateOfBirth => 'Geburtsdatum';

  @override
  String get height => 'Groesse';

  @override
  String get createProfileToStart => 'Erstelle ein Profil zum Starten';

  @override
  String get createProfileExplanation =>
      'Um dein Viszeralfett zu berechnen, benoetigen wir einige grundlegende Informationen wie dein Geschlecht, Alter und deine Groesse.';

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
  String get calculateAndSave => 'Berechnen & Speichern';

  @override
  String get noPreviousMeasurements => 'Keine frueheren Messungen';

  @override
  String get measured => 'Gemessen';

  @override
  String get today => 'Heute';

  @override
  String get result => 'Ergebnis';

  @override
  String get viewHealthInsights => 'Gesundheitsinfos anzeigen';

  @override
  String get viewProgressChart => 'Fortschrittsdiagramm anzeigen';

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
    return '$count aeltere Messungen';
  }

  @override
  String get unlockFullProgress =>
      'Freischalten, um den gesamten Fortschritt zu sehen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get profiles => 'Profile';

  @override
  String get addProfile => 'Profil hinzufuegen';

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
  String get deleteProfile => 'Profil loeschen';

  @override
  String deleteProfileConfirmation(String name) {
    return '\"$name\" und alle zugehoerigen Messungen loeschen? Dies kann nicht rueckgaengig gemacht werden.';
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
      'Lege ein Ziel fuer die Viszeralfettflaeche fest, das in deinem Fortschrittsdiagramm angezeigt wird.';

  @override
  String get goalHint => 'z.B. 100';

  @override
  String get goalTip => 'Tipp: Unter 100 cm² gilt als gesund';

  @override
  String get clear => 'Loeschen';

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
  String get frequency => 'Haeufigkeit';

  @override
  String get off => 'Aus';

  @override
  String get weekly => 'Woechentlich';

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
  String get dayOfMonth => 'Tag des Monats';

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
  String get followSystemSettings => 'Systemeinstellungen folgen';

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
  String get resetAllData => 'Alle Daten zuruecksetzen';

  @override
  String get deleteAllProfilesAndMeasurements =>
      'Alle Profile und Messungen loeschen';

  @override
  String get resetAllDataConfirmation =>
      'Dies loescht ALLE Profile und Messungen. Du musst ein neues Profil einrichten. Dies kann nicht rueckgaengig gemacht werden.';

  @override
  String get reset => 'Zuruecksetzen';

  @override
  String get delete => 'Loeschen';

  @override
  String get developerOptions => 'Entwickleroptionen';

  @override
  String get premiumStatusOverride => 'Premium-Status ueberschreiben';

  @override
  String get simulatingPremium => 'Premium simulieren';

  @override
  String get simulatingFree => 'Kostenlos simulieren';

  @override
  String get usingRealStatus => 'Echten Status verwenden';

  @override
  String get actual => 'tatsaechlich';

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
  String get aboutVisqo => 'Ueber Visqo';

  @override
  String get aboutVisqoDescription =>
      'Visqo hilft dir, dein Viszeralfett mit einfachen Koerpermessungen zu schaetzen. Viszeralfett ist das Fett, das um deine inneren Organe gespeichert ist und mit erhoehten Gesundheitsrisiken verbunden ist. Durch die Verfolgung deiner Messungen ueber die Zeit kannst du deinen Fortschritt zu einer gesunderen Koerperzusammensetzung ueberwachen.';

  @override
  String get howToMeasureWaist => 'Wie man den Taillenumfang misst';

  @override
  String get instructions => 'Anleitung';

  @override
  String get waistStep1 =>
      'Stehe aufrecht mit zusammenstehenden Fuessen und entspannten Armen an der Seite.';

  @override
  String get waistStep2 =>
      'Finde die Unterkante deiner Rippen und die Oberkante deiner Hueftknochen (Beckenkamm).';

  @override
  String get waistStep3 =>
      'Lege das Massband in der Mitte zwischen diesen beiden Punkten an, etwa auf Nabelhoe.';

  @override
  String get waistStep4 =>
      'Wickle das Band um deine Taille und halte es parallel zum Boden.';

  @override
  String get waistStep5 =>
      'Atme normal aus und lies den Wert ab, ohne das Band zu fest zu ziehen.';

  @override
  String get waistTip =>
      'Miss direkt auf der Haut oder ueber leichter Kleidung fuer genaue Ergebnisse.';

  @override
  String get howToMeasureThigh => 'Wie man den Oberschenkelumfang misst';

  @override
  String get thighStep1 =>
      'Stehe aufrecht mit gleichmaessig auf beide Beine verteiltem Gewicht.';

  @override
  String get thighStep2 =>
      'Identifiziere die Gesaessfalte (die Falte, wo dein Gesaess auf den Oberschenkel trifft).';

  @override
  String get thighStep3 =>
      'Positioniere das Massband knapp unterhalb (distal) der Gesaessfalte.';

  @override
  String get thighStep4 =>
      'Wickle das Band horizontal um deinen Oberschenkel, senkrecht zur Oberschenkelachse.';

  @override
  String get thighStep5 =>
      'Halte deine Muskeln entspannt und lies die Messung ab, ohne die Haut zusammenzudruecken.';

  @override
  String get thighTip =>
      'Miss beide Oberschenkel und verwende den Durchschnitt, wenn sie deutlich unterschiedlich sind.';

  @override
  String get settingGoalTitle => 'Ein Ziel setzen';

  @override
  String get settingGoalStep1 =>
      'Gehe zu den Einstellungen vom Rechner-Bildschirm aus.';

  @override
  String get settingGoalStep2 =>
      'Tippe auf \"VAT-Ziel festlegen\" im Bereich Ziele.';

  @override
  String get settingGoalStep3 => 'Gib deinen Ziel-VAT-Wert ein und speichere.';

  @override
  String get settingGoalDescription =>
      'Du kannst ein persoenliches VAT-Ziel setzen, um deinen Fortschritt zu einer gesunderen Koerperzusammensetzung zu verfolgen.';

  @override
  String get goalChartDescription =>
      'Nach dem Festlegen erscheint dein Ziel als gruene gestrichelte Linie im Fortschrittsdiagramm, damit du sehen kannst, wie nah du deinem Ziel bist.';

  @override
  String get goalHealthTip =>
      'Ein VAT unter 100 cm² gilt allgemein als gesund. Konsultiere einen Arzt fuer eine persoenliche Beratung.';

  @override
  String get trendIndicatorTitle => 'Den Trendindikator verstehen';

  @override
  String get trendIndicatorDescription =>
      'Der Trendindikator zeigt, wie sich dein VAT im Vergleich zu deiner vorherigen Messung veraendert hat.';

  @override
  String get trendDecreasing => 'Sinkend';

  @override
  String get trendDecreasingDesc =>
      'Dein VAT ist niedriger als zuvor. Toller Fortschritt bei der Reduzierung des Viszeralfetts.';

  @override
  String get trendIncreasing => 'Steigend';

  @override
  String get trendIncreasingDesc =>
      'Dein VAT ist hoeher als zuvor. Ueberdenke deine Ernaehrung und dein Bewegungsprogramm.';

  @override
  String get trendStable => 'Stabil';

  @override
  String get trendStableDesc =>
      'Dein VAT hat sich um weniger als 1 cm² veraendert. Deine Werte bleiben stabil.';

  @override
  String get trendMagnitudeNote =>
      'Der Trendindikator zeigt auch die genaue VAT-Aenderung (z.B. -5,2), damit du das Ausmass des Unterschieds sehen kannst.';

  @override
  String get calculationTitle => 'Wie wird Viszeralfett berechnet?';

  @override
  String get calculationDescription =>
      'Visqo verwendet das anthropometrische Samouda-Modell zur Schaetzung der Viszeralfettflaeche (VAT), ohne teure Bildgebung wie CT-Scans oder MRT zu benoetigen.';

  @override
  String get calculationModelDescription =>
      'Das Modell verwendet einfache Koerpermasse in Kombination mit deinem Alter und BMI, um VAT mit hoher Genauigkeit vorherzusagen:';

  @override
  String get formulaForMen => 'Fuer Maenner';

  @override
  String get formulaMen =>
      'VAT = 6 x Taille - 4,41 x Oberschenkel + 1,19 x Alter - 213,65';

  @override
  String get accuracyMen => 'Erklaert 80,3% der VAT-Varianz';

  @override
  String get formulaForWomen => 'Fuer Frauen';

  @override
  String get formulaWomen =>
      'VAT = 2,15 x Taille - 3,63 x Oberschenkel + 1,46 x Alter + 6,22 x BMI - 92,713';

  @override
  String get accuracyWomen => 'Erklaert 83,6% der VAT-Varianz';

  @override
  String get resultUnit =>
      'Das Ergebnis wird in cm² angegeben und repraesentiert die geschaetzte Querschnittsflaeche des Viszeralfettgewebes.';

  @override
  String get understandingResultsTitle => 'Deine Ergebnisse verstehen';

  @override
  String get resultsIntro =>
      'Dein VAT-Ergebnis wird in drei Risikostufen eingeteilt:';

  @override
  String get riskHealthy => 'Gesund';

  @override
  String get riskHealthyRange => 'Weniger als 100 cm²';

  @override
  String get riskHealthyDesc =>
      'Normale Viszeralfettwerte mit niedrigeren Gesundheitsrisiken.';

  @override
  String get riskElevated => 'Erhoeht';

  @override
  String get riskElevatedRange => '100 - 130 cm²';

  @override
  String get riskElevatedDesc =>
      'Maessig erhoehte Werte. Lebensstilaenderungen erwaegen.';

  @override
  String get riskHighRisk => 'Hohes Risiko';

  @override
  String get riskHighRiskRange => 'Mehr als 130 cm²';

  @override
  String get riskHighRiskDesc =>
      'Hohes Viszeralfett verbunden mit erhoehten metabolischen Gesundheitsrisiken.';

  @override
  String get learnMoreHealthRisks =>
      'Mehr ueber Gesundheitsrisiken & Tipps erfahren';

  @override
  String get learnMoreHealthRisksDesc =>
      'Verstehe die gesundheitlichen Auswirkungen und evidenzbasierte Wege zur Reduzierung von Viszeralfett.';

  @override
  String get scientificReference => 'Wissenschaftliche Referenz';

  @override
  String get referenceIntro =>
      'Die in dieser App verwendete Berechnungsmethode basiert auf begutachteter Forschung:';

  @override
  String get referenceAuthors =>
      'Samouda, H., Dutour, A., Chaumoitre, K., Panuel, M., Dutour, O., & Dadoun, F.';

  @override
  String get referenceTitle =>
      'VAT=TAAT-SAAT: innovatives anthropometrisches Modell zur Vorhersage von viszeralem Fettgewebe ohne CT-Scan oder DXA.';

  @override
  String get referenceJournal => 'Obesity (2013), 21(1), E41-E50.';

  @override
  String get healthInsights => 'Gesundheitsinfos';

  @override
  String get aboutVisceralFat => 'Ueber Viszeralfett';

  @override
  String get aboutVisceralFatDescription =>
      'Viszeralfett wird tief in der Bauchhoehle um die inneren Organe gespeichert. Im Gegensatz zu Unterhautfett spielt es eine hormonell aktive Rolle und ist mit erhoehten Gesundheitsrisiken verbunden. Erfahre mehr ueber die Risiken und evidenzbasierte Wege zur Reduzierung.';

  @override
  String get healthRisksOfElevatedVat =>
      'Gesundheitsrisiken bei erhoehtem Viszeralfett';

  @override
  String get healthRisksSubtitle =>
      'Das Verstehen der Risiken kann positive Veraenderungen motivieren';

  @override
  String get evidenceBasedTips => 'Evidenzbasierte Tipps';

  @override
  String get evidenceBasedTipsSubtitle =>
      'Einfache Massnahmen zur Reduzierung von Viszeralfett';

  @override
  String get recommendedForYou => 'Fuer dich empfohlen';

  @override
  String get maintainYourHealth => 'Erhalte deine Gesundheit';

  @override
  String get additionalTips => 'Zusaetzliche Tipps';

  @override
  String get disclaimer =>
      'Diese Informationen dienen nur zu Bildungszwecken und sollten keine professionelle medizinische Beratung ersetzen. Bitte konsultiere einen Arzt fuer eine persoenliche Beratung.';

  @override
  String get riskCardiometabolic => 'Kardiometabolische Erkrankung';

  @override
  String get riskCardiometabolicDesc =>
      'Erhoehtes Viszeralfett steigert das Risiko fuer schwere Herz-Kreislauf- und Stoffwechselerkrankungen erheblich.';

  @override
  String get riskCardiometabolicDetail1 =>
      'Erhoehtes Risiko fuer Typ-2-Diabetes durch Insulinresistenz';

  @override
  String get riskCardiometabolicDetail2 =>
      'Hoehere Wahrscheinlichkeit fuer Bluthochdruck';

  @override
  String get riskCardiometabolicDetail3 =>
      'Unguenstiges Cholesterinprofil (Dyslipidaemie)';

  @override
  String get riskCardiometabolicDetail4 =>
      'Groesseres Risiko fuer koronare Herzkrankheit und Herzinsuffizienz';

  @override
  String get riskStrokeMortality => 'Schlaganfall und Sterblichkeit';

  @override
  String get riskStrokeMortalityDesc =>
      'Hoeheres Viszeralfett ist mit erhoehtem Schlaganfallrisiko verbunden und kann zu hoeherer Gesamtsterblichkeit beitragen.';

  @override
  String get riskStrokeMortalityDetail1 =>
      'Erhoehtes Risiko fuer ischaemischen Schlaganfall';

  @override
  String get riskStrokeMortalityDetail2 =>
      'Zusammenhang mit hoeherer Gesamtsterblichkeit';

  @override
  String get riskStrokeMortalityDetail3 =>
      'Risiko besteht auch bei normalem BMI';

  @override
  String get riskInflammation => 'Chronische Entzuendung';

  @override
  String get riskInflammationDesc =>
      'Viszerales Fettgewebe sondert aktiv entzuendungsfoerdernde Molekuele ab, die systemische Entzuendungen im ganzen Koerper foerdern.';

  @override
  String get riskInflammationDetail1 =>
      'Sondert entzuendliche Zytokine ab (IL-6, TNF-alpha)';

  @override
  String get riskInflammationDetail2 => 'Stoert normale Hormonsignale';

  @override
  String get riskInflammationDetail3 =>
      'Erzeugt chronische niedriggradige Entzuendung';

  @override
  String get riskInflammationDetail4 =>
      'Entzuendung ist Risikofaktor fuer viele chronische Krankheiten';

  @override
  String get riskLiver => 'Nicht-alkoholische Fettleber';

  @override
  String get riskLiverDesc =>
      'Viszeralfettansammlung korreliert stark mit Fetteinlagerung in der Leber und erhoehten Leberenzymen.';

  @override
  String get riskLiverDetail1 =>
      'Fettablagerungen im Lebergewebe (hepatische Steatose)';

  @override
  String get riskLiverDetail2 => 'Erhoehte Leberenzymwerte (ALT, AST)';

  @override
  String get riskLiverDetail3 =>
      'Kann zu schwerwiegenderen Lebererkrankungen fortschreiten';

  @override
  String get riskLiverDetail4 => 'Oft reversibel durch Lebensstilaenderungen';

  @override
  String get riskMetabolicSyndrome => 'Metabolisches Syndrom';

  @override
  String get riskMetabolicSyndromeDesc =>
      'Viszerale Adipositas ist ein Haupttreiber des metabolischen Syndroms, einer Ansammlung von Erkrankungen, die das Krankheitsrisiko erhoehen.';

  @override
  String get riskMetabolicSyndromeDetail1 => 'Erhoehte Blutzuckerwerte';

  @override
  String get riskMetabolicSyndromeDetail2 => 'Hoher Blutdruck';

  @override
  String get riskMetabolicSyndromeDetail3 => 'Abnormale Cholesterinwerte';

  @override
  String get riskMetabolicSyndromeDetail4 =>
      'Zentrale Adipositas (ueberschuessiges Bauchfett)';

  @override
  String get riskMetabolicSyndromeDetail5 =>
      'Erhoeht das Risiko fuer Herzerkrankungen und Diabetes erheblich';

  @override
  String get riskCancer => 'Krebszusammenhaenge';

  @override
  String get riskCancerDesc =>
      'Neue Erkenntnisse verbinden Viszeralfett mit metabolischer Dysregulation und erhoehtem Risiko fuer bestimmte Krebsarten.';

  @override
  String get riskCancerDetail1 =>
      'Veraenderte Hormonsignale koennen Krebswachstum foerdern';

  @override
  String get riskCancerDetail2 =>
      'Chronische Entzuendung schafft guenstige Umgebung fuer Krebs';

  @override
  String get riskCancerDetail3 =>
      'Mit bestimmten boesartigen Tumoren verbunden';

  @override
  String get riskCancerDetail4 =>
      'Forschung zum Verstaendnis der Mechanismen laeuft';

  @override
  String get tipActivity => 'Regelmaessige koerperliche Aktivitaet';

  @override
  String get tipActivityDesc =>
      'Konsequentes Ausdauertraining und Krafttraining gehoeren zu den effektivsten Wegen, Viszeralfett zu reduzieren.';

  @override
  String get tipActivityAction1 =>
      'Strebe 150+ Minuten pro Woche maessig intensive Ausdaueraktivitaet an';

  @override
  String get tipActivityAction2 =>
      'Integriere 2 oder mehr Tage pro Woche Krafttraining';

  @override
  String get tipActivityAction3 =>
      'Gehen, Radfahren, Schwimmen und Joggen sind ausgezeichnete Optionen';

  @override
  String get tipActivityAction4 =>
      'Krafttraining hilft, Muskelmasse zu erhalten';

  @override
  String get tipDiet => 'Ausgewogene, naehrstoffreiche Ernaehrung';

  @override
  String get tipDietDesc =>
      'Konzentriere dich auf vollwertige Lebensmittel und reduziere verarbeitete Lebensmittel, um Viszeralfettansammlung zu verringern.';

  @override
  String get tipDietAction1 => 'Betone Gemuese, Obst und Vollkornprodukte';

  @override
  String get tipDietAction2 =>
      'Waehle magere Proteine (Fisch, Gefluegel, Huelsenfruechte)';

  @override
  String get tipDietAction3 =>
      'Begrenze zugesetzten Zucker und raffinierte Kohlenhydrate';

  @override
  String get tipDietAction4 =>
      'Reduziere den Verzehr stark verarbeiteter Lebensmittel';

  @override
  String get tipDietAction5 =>
      'Waehle gesunde Fette (Olivenoel, Nuesse, Avocado)';

  @override
  String get tipWeight => 'Gewichtsmanagement';

  @override
  String get tipWeightDesc =>
      'Ein gesundes Gewicht durch nachhaltige Kalorienkontrolle zu halten, hilft, Viszeralfettspeicher zu reduzieren.';

  @override
  String get tipWeightAction1 =>
      'Schaffe ein moderates Kaloriendefizit fuer schrittweisen Gewichtsverlust';

  @override
  String get tipWeightAction2 =>
      'Verfolge den Taillenumfang als Fortschrittsindikator';

  @override
  String get tipWeightAction3 =>
      'Ueberwache das Taille-zu-Groesse-Verhaeltnis (Ziel: < 0,5)';

  @override
  String get tipWeightAction4 =>
      'Konzentriere dich auf nachhaltige Aenderungen, nicht auf Crash-Diaeten';

  @override
  String get tipSedentary => 'Sitzzeit reduzieren';

  @override
  String get tipSedentaryDesc =>
      'Langes Sitzen mit leichter Bewegung zu unterbrechen, traegt zum Gesamtenergieverbrauch bei.';

  @override
  String get tipSedentaryAction1 =>
      'Stehe alle 30-60 Minuten auf und bewege dich';

  @override
  String get tipSedentaryAction2 =>
      'Mache Spaziergangpausen waehrend der Arbeit';

  @override
  String get tipSedentaryAction3 =>
      'Nutze wenn moeglich einen Stehschreibtisch';

  @override
  String get tipSedentaryAction4 => 'Waehle Treppen statt Aufzuege';

  @override
  String get tipSedentaryAction5 =>
      'Selbst leichte Aktivitaet hilft, Viszeralfett zu reduzieren';

  @override
  String get tipSleepStress => 'Qualitaetsschlaf und Stressbewaeltigung';

  @override
  String get tipSleepStressDesc =>
      'Schlechter Schlaf und chronischer Stress erhoehen Cortisol, ein Hormon, das mit Bauchfettansammlung verbunden ist.';

  @override
  String get tipSleepStressAction1 =>
      'Strebe 7-9 Stunden Qualitaetsschlaf pro Nacht an';

  @override
  String get tipSleepStressAction2 =>
      'Halte einen konstanten Schlafrhythmus ein';

  @override
  String get tipSleepStressAction3 =>
      'Praktiziere stressreduzierende Aktivitaeten (Meditation, Yoga)';

  @override
  String get tipSleepStressAction4 =>
      'Begrenze Bildschirmzeit vor dem Schlafengehen';

  @override
  String get tipSleepStressAction5 =>
      'Gehe die Quellen chronischen Stresses an';

  @override
  String get tipAlcohol => 'Alkoholkonsum begrenzen';

  @override
  String get tipAlcoholDesc =>
      'Alkohol fuegt Kalorien hinzu und kann bei regelmaessigem uebermassigem Konsum Viszeralfettansammlung foerdern.';

  @override
  String get tipAlcoholAction1 =>
      'Begrenze auf maessigen Konsum (1 Getraenk/Tag Frauen, 2/Tag Maenner)';

  @override
  String get tipAlcoholAction2 =>
      'Waehle kalorienaeremere Optionen beim Trinken';

  @override
  String get tipAlcoholAction3 => 'Vermeide Episoden von Rauschtrinken';

  @override
  String get tipAlcoholAction4 => 'Erwaege alkoholfreie Tage jede Woche';

  @override
  String get tipSmoking => 'Rauchentwohnung';

  @override
  String get tipSmokingDesc =>
      'Rauchen ist mit zentraler Fettansammlung verbunden und verstaerkt das kardiometabolische Risiko.';

  @override
  String get tipSmokingAction1 =>
      'Hoere auf zu rauchen, um Viszeralfettansammlung zu reduzieren';

  @override
  String get tipSmokingAction2 =>
      'Suche bei Bedarf Unterstuetzungsprogramme oder Medikamente';

  @override
  String get tipSmokingAction3 =>
      'Vorteile beginnen innerhalb von Tagen nach dem Aufhoeren';

  @override
  String get tipSmokingAction4 =>
      'Reduziert das kardiovaskulaere Gesamtrisiko erheblich';

  @override
  String get waist => 'Taille';

  @override
  String get proximalThigh => 'Proximaler Oberschenkel';

  @override
  String get lowerRib => 'Untere Rippe';

  @override
  String get hipBone => 'Hueftknochen';

  @override
  String get midpoint => 'Mittelpunkt';

  @override
  String get glutealCrease => 'Gesaessfalte';

  @override
  String get justBelowCrease => 'Knapp unter der Falte';

  @override
  String errorStartingApp(String error) {
    return 'Fehler beim Starten der App: $error\n\nBitte installiere die App neu.';
  }

  @override
  String get language => 'Sprache';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get french => 'Franzoesisch';
}
