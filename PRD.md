# Product Requirements Document

## Visceral Fat Calculator

**App Name**: Visco
**Version**: 1.0
**Platform**: iOS & Android (Flutter)
**Last Updated**: December 26, 2025

---

## Table of Contents

1. [Overview](#overview)
2. [Problem Statement](#problem-statement)
3. [Goals & Objectives](#goals--objectives)
4. [Target Users](#target-users)
5. [Core Features](#core-features)
6. [Calculation Method](#calculation-method)
7. [Design System](#design-system)
8. [User Interface](#user-interface)
9. [Technical Requirements](#technical-requirements)
10. [Success Metrics](#success-metrics)
11. [Future Considerations](#future-considerations)

---

## Overview

**Visco** is a minimalist mobile application that calculates visceral adipose tissue (VAT) using the clinically validated Samouda anthropometric model. The app provides users with an accessible way to monitor their visceral fat levels without expensive medical imaging (CT-Scan or DXA).

### Value Proposition

- **Accessible**: No medical equipment required, only a measuring tape
- **Scientific**: Based on peer-reviewed research (Samouda et al., 2013)
- **Actionable**: Clear health thresholds and progress tracking
- **Private**: All data stored locally on device

---

## Problem Statement

Visceral fat (fat stored around internal organs) is a critical health indicator linked to cardiovascular disease, type 2 diabetes, and cancer. However:

1. **Medical imaging is expensive** - CT scans and DXA cost $100-500+ per scan
2. **BMI is insufficient** - It doesn't distinguish between visceral and subcutaneous fat
3. **Waist circumference alone is imprecise** - It doesn't account for body composition variations
4. **Existing apps are cluttered** - Most health apps are overloaded with features

### Opportunity

The Samouda formula provides a validated method to estimate visceral fat using simple body measurements, achieving R² = 0.80 correlation with CT-scan results.

---

## Goals & Objectives

### Primary Goals

| Goal | Metric | Target |
|------|--------|--------|
| Accurate VAT calculation | Formula implementation | 100% match with LIH calculator |
| User adoption | Monthly active users | 1,000 in 6 months |
| User retention | Weekly measurement rate | 40% of users |

### User Objectives

1. Calculate visceral fat quickly (< 30 seconds)
2. Understand health risk category
3. Track progress over time
4. Set and monitor reduction goals

---

## Target Users

### Primary Persona

**Health-Conscious Adult (35-60 years)**

- Concerned about metabolic health
- Wants to reduce visceral fat
- Prefers simple, no-nonsense tools
- Values privacy (doesn't want data in the cloud)

### Secondary Persona

**Fitness Enthusiast**

- Tracks body composition regularly
- Wants more than just weight/BMI
- Appreciates scientific backing

---

## Core Features

### MVP (Version 1.0)

| Feature | Priority | Description |
|---------|----------|-------------|
| VAT Calculator | P0 | Calculate visceral fat from measurements |
| Risk Assessment | P0 | Display health risk category |
| Measurement Guide | P0 | Visual instructions for accurate measurements |
| History Log | P1 | Store and view past measurements |
| Progress Chart | P1 | Visualize VAT trend over time |
| Goal Setting | P2 | Set target VAT and track progress |
| Reminders | P2 | Weekly measurement reminders |

### Feature Details

#### 1. VAT Calculator (P0)

**Inputs:**
- Sex (Male/Female)
- Age (years)
- Waist circumference (cm)
- Thigh circumference (cm)
- BMI (auto-calculated from height/weight) - *only for female formula*

**Outputs:**
- Visceral fat area (cm²)
- Health risk category
- Percentile ranking (if data available)

#### 2. Risk Assessment (P0)

| Category | Threshold | Visual Indicator |
|----------|-----------|------------------|
| Healthy | VAT < 100 cm² | Green |
| Elevated | 100 ≤ VAT < 130 cm² | Yellow |
| Visceral Obesity | VAT ≥ 130 cm² | Red |

#### 3. Measurement Guide (P0)

Interactive visual guide showing:
- Where to measure waist (narrowest point or navel level)
- Where to measure thigh (proximal, just below gluteal fold)
- Tips for consistent measurements

#### 4. History Log (P1)

- List of past measurements with date/time
- Swipe to delete entries
- Export to CSV option

#### 5. Progress Chart (P1)

- Line chart showing VAT over time
- Secondary line for waist circumference
- Goal line overlay
- Time range selector (1M, 3M, 6M, 1Y, All)

---

## Calculation Method

### Scientific Basis

The app implements the **Samouda Anthropometric Model** (2013), validated against CT-scan measurements with high accuracy.

**Reference:**
> Samouda, H., et al. (2013). VAT=TAAT-SAAT: Innovative anthropometric model to predict visceral adipose tissue without resort to CT-Scan or DXA. *Obesity*, 21, E41–E50.
> [PMC3618381](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3618381/)

### Formulas

#### Male Formula

```
VAT = (6 × Waist) − (4.41 × Thigh) + (1.19 × Age) − 213.65
```

**Accuracy:** R² = 0.803 | Sensitivity: 100%

#### Female Formula

```
VAT = (2.15 × Waist) − (3.63 × Thigh) + (1.46 × Age) + (6.22 × BMI) − 92.713
```

**Accuracy:** R² = 0.836 | Sensitivity: 97.7%

### Variables

| Variable | Unit | Description | Measurement Method |
|----------|------|-------------|-------------------|
| Waist | cm | Waist circumference | Horizontal at umbilicus level |
| Thigh | cm | Proximal thigh circumference | Just below gluteal fold |
| Age | years | User's age | User input |
| BMI | kg/m² | Body Mass Index | Weight(kg) / Height(m)² |

### Implementation Notes

```dart
double calculateVAT({
  required bool isMale,
  required double waist,
  required double thigh,
  required int age,
  double? bmi, // Required for females
}) {
  if (isMale) {
    return (6 * waist) - (4.41 * thigh) + (1.19 * age) - 213.65;
  } else {
    if (bmi == null) throw ArgumentError('BMI required for female calculation');
    return (2.15 * waist) - (3.63 * thigh) + (1.46 * age) + (6.22 * bmi) - 92.713;
  }
}
```

### Validation

| Check | Rule | Action |
|-------|------|--------|
| Waist range | 50-200 cm | Warn if outside range |
| Thigh range | 30-100 cm | Warn if outside range |
| Age range | 18-80 years | Warn if outside validated range |
| Negative result | VAT < 0 | Display 0 with note |

---

## Design System

### Design Philosophy

Inspired by **Notion** and **Linear** - clean, minimal, focused on content with subtle depth and purposeful whitespace.

### Color Palette

#### Light Mode

| Token | Hex | Usage |
|-------|-----|-------|
| `background` | `#FFFFFF` | Main background |
| `surface` | `#F7F7F5` | Cards, input fields |
| `border` | `#E8E8E6` | Dividers, borders |
| `text-primary` | `#191919` | Headlines, values |
| `text-secondary` | `#6B6B6B` | Labels, descriptions |
| `text-tertiary` | `#9B9B9B` | Placeholders, hints |
| `accent` | `#2383E2` | Interactive elements |
| `success` | `#0F7B6C` | Healthy range |
| `warning` | `#C77D00` | Elevated range |
| `danger` | `#E03E3E` | Obesity range |

#### Dark Mode

| Token | Hex | Usage |
|-------|-----|-------|
| `background` | `#191919` | Main background |
| `surface` | `#252525` | Cards, input fields |
| `border` | `#333333` | Dividers, borders |
| `text-primary` | `#FFFFFF` | Headlines, values |
| `text-secondary` | `#9B9B9B` | Labels, descriptions |
| `text-tertiary` | `#6B6B6B` | Placeholders, hints |
| `accent` | `#529CCA` | Interactive elements |
| `success` | `#4DAB9A` | Healthy range |
| `warning` | `#DFAB4F` | Elevated range |
| `danger` | `#E06C6C` | Obesity range |

### Typography

| Style | Font | Size | Weight | Line Height |
|-------|------|------|--------|-------------|
| Display | Inter | 48px | 600 | 1.1 |
| Headline | Inter | 24px | 600 | 1.2 |
| Title | Inter | 18px | 600 | 1.3 |
| Body | Inter | 16px | 400 | 1.5 |
| Caption | Inter | 14px | 400 | 1.4 |
| Label | Inter | 12px | 500 | 1.3 |

### Spacing Scale

```
4px  - xs (tight gaps)
8px  - sm (related elements)
16px - md (section padding)
24px - lg (card padding)
32px - xl (section gaps)
48px - 2xl (major sections)
```

### Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `sm` | 4px | Small buttons, chips |
| `md` | 8px | Input fields, cards |
| `lg` | 12px | Modal, sheets |
| `full` | 9999px | Circular elements |

### Shadows

```css
/* Card shadow */
box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04),
            0 1px 3px rgba(0, 0, 0, 0.06);

/* Elevated shadow */
box-shadow: 0 4px 6px rgba(0, 0, 0, 0.04),
            0 10px 20px rgba(0, 0, 0, 0.06);
```

### Components

#### Input Field

```
┌─────────────────────────────────────┐
│ Label                          (cm) │
│ ┌─────────────────────────────────┐ │
│ │ 89                              │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘

- Background: surface
- Border: 1px solid border
- Border radius: md
- Padding: 12px 16px
- Focus: 2px accent ring
```

#### Result Card

```
┌─────────────────────────────────────┐
│                                     │
│            131.70 cm²               │  ← Display, text-primary
│         Visceral Fat Area           │  ← Caption, text-secondary
│                                     │
│   ┌─────────────────────────────┐   │
│   │    ● Visceral Obesity       │   │  ← Status chip (danger bg)
│   └─────────────────────────────┘   │
│                                     │
└─────────────────────────────────────┘

- Background: surface
- Border radius: lg
- Padding: 24px
- Shadow: card
```

#### Progress Indicator

```
Healthy        Elevated        Obesity
   ├──────────────┼──────────────┤
   0            100            130        →
                              ▲
                         You: 131.70

- Track: border color, 8px height
- Segments: success | warning | danger
- Marker: 16px circle with shadow
```

---

## User Interface

### Screen Flow

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Onboard   │────▶│  Calculate  │────▶│   Result    │
│  (Profile)  │     │   (Input)   │     │  (Output)   │
└─────────────┘     └─────────────┘     └─────────────┘
                           │                   │
                           │                   ▼
                           │            ┌─────────────┐
                           │            │   History   │
                           │            │  (Log/Chart)│
                           └───────────▶└─────────────┘
```

### Screen Specifications

#### 1. Onboarding / Profile Setup

**Purpose**: Collect static user data (sex, birthdate, height)

```
┌─────────────────────────────────────┐
│                                     │
│             Visco                   │
│    Visceral Fat Calculator          │
│                                     │
├─────────────────────────────────────┤
│                                     │
│  Let's set up your profile          │
│                                     │
│  ┌─────────────────────────────────┐│
│  │  Sex                            ││
│  │  ○ Male    ● Female             ││
│  └─────────────────────────────────┘│
│                                     │
│  ┌─────────────────────────────────┐│
│  │  Date of Birth                  ││
│  │  15 / 03 / 1976                 ││
│  └─────────────────────────────────┘│
│                                     │
│  ┌─────────────────────────────────┐│
│  │  Height (cm)                    ││
│  │  173                            ││
│  └─────────────────────────────────┘│
│                                     │
│  ┌─────────────────────────────────┐│
│  │         Continue →              ││
│  └─────────────────────────────────┘│
│                                     │
└─────────────────────────────────────┘
```

#### 2. Calculate (Main Screen)

**Purpose**: Input current measurements and calculate VAT

```
┌─────────────────────────────────────┐
│ ←  Calculate               ⚙️  📊   │
├─────────────────────────────────────┤
│                                     │
│  Today's Measurements               │
│  December 26, 2025                  │
│                                     │
│  ┌─────────────────────────────────┐│
│  │  Weight (kg)                    ││
│  │  71                             ││
│  └─────────────────────────────────┘│
│                                     │
│  ┌─────────────────────────────────┐│
│  │  Waist Circumference (cm)    ⓘ ││
│  │  89                             ││
│  └─────────────────────────────────┘│
│                                     │
│  ┌─────────────────────────────────┐│
│  │  Thigh Circumference (cm)    ⓘ ││
│  │  56                             ││
│  └─────────────────────────────────┘│
│                                     │
│  ┌─────────────────────────────────┐│
│  │       Calculate VAT             ││
│  └─────────────────────────────────┘│
│                                     │
│  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │
│                                     │
│  Last Result: 131.70 cm²            │
│  Measured: Today                    │
│                                     │
└─────────────────────────────────────┘
```

#### 3. Result Screen

**Purpose**: Display calculated VAT with context

```
┌─────────────────────────────────────┐
│ ←  Result                     Save  │
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────────────────────────┐│
│  │                                 ││
│  │         131.70 cm²              ││
│  │       Visceral Fat Area         ││
│  │                                 ││
│  │    ┌───────────────────┐        ││
│  │    │ Visceral Obesity  │        ││
│  │    └───────────────────┘        ││
│  │                                 ││
│  └─────────────────────────────────┘│
│                                     │
│  Risk Scale                         │
│  ├────────┬────────┬────────────┤  │
│  Healthy  Elevated  Obesity         │
│  < 100    100-130   ≥ 130           │
│                           ▲         │
│                                     │
├─────────────────────────────────────┤
│                                     │
│  Measurements Used                  │
│  ┌─────────────────────────────────┐│
│  │ Waist      89 cm                ││
│  │ Thigh      56 cm                ││
│  │ Weight     71 kg                ││
│  │ BMI        23.72                ││
│  │ Age        49 years             ││
│  └─────────────────────────────────┘│
│                                     │
│  ┌─────────────────────────────────┐│
│  │     View Progress Chart →       ││
│  └─────────────────────────────────┘│
│                                     │
└─────────────────────────────────────┘
```

#### 4. History / Progress Screen

**Purpose**: View trends and past measurements

```
┌─────────────────────────────────────┐
│ ←  Progress                         │
├─────────────────────────────────────┤
│                                     │
│  Visceral Fat Trend                 │
│  ┌─────────────────────────────────┐│
│  │                                 ││
│  │  140 ┤      ●                   ││
│  │      │     /                    ││
│  │  120 ┤    ●                     ││
│  │      │   /                      ││
│  │  100 ┤  ●                       ││
│  │      │                          ││
│  │   80 ┤─ ─ ─ ─ ─ ─ ─ ─ Goal: 66  ││
│  │      └───┬───┬───┬───┬───┬───  ││
│  │        Dec Jan Feb Mar Apr      ││
│  │                                 ││
│  └─────────────────────────────────┘│
│                                     │
│  [1M] [3M] [6M] [1Y] [All]          │
│                                     │
├─────────────────────────────────────┤
│                                     │
│  History                            │
│                                     │
│  ┌─────────────────────────────────┐│
│  │ Dec 26, 2025            131.70  ││
│  │ Waist: 89 cm                    ││
│  └─────────────────────────────────┘│
│                                     │
│  ┌─────────────────────────────────┐│
│  │ Dec 19, 2025            133.20  ││
│  │ Waist: 90 cm                    ││
│  └─────────────────────────────────┘│
│                                     │
└─────────────────────────────────────┘
```

#### 5. Measurement Guide (Modal)

**Purpose**: Teach correct measurement technique

```
┌─────────────────────────────────────┐
│                               ✕     │
├─────────────────────────────────────┤
│                                     │
│  How to Measure Waist               │
│                                     │
│  ┌─────────────────────────────────┐│
│  │                                 ││
│  │         [ Illustration ]        ││
│  │                                 ││
│  └─────────────────────────────────┘│
│                                     │
│  1. Stand relaxed, feet together    │
│                                     │
│  2. Wrap tape horizontally at       │
│     navel (belly button) level      │
│                                     │
│  3. Keep tape snug but not tight    │
│                                     │
│  4. Measure at end of normal        │
│     exhale                          │
│                                     │
│  ┌─────────────────────────────────┐│
│  │          Got it                 ││
│  └─────────────────────────────────┘│
│                                     │
└─────────────────────────────────────┘
```

---

## Technical Requirements

### Platform & Framework

| Requirement | Specification |
|-------------|---------------|
| Framework | Flutter 3.x |
| Min iOS | 14.0 |
| Min Android | API 26 (Android 8.0) |
| State Management | Riverpod 2.x |
| Local Storage | Hive or Isar |
| Charts | fl_chart |

### Data Model

```dart
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required Sex sex,
    required DateTime birthDate,
    required double heightCm,
  }) = _UserProfile;
}

@freezed
class Measurement with _$Measurement {
  const factory Measurement({
    required String id,
    required DateTime timestamp,
    required double waistCm,
    required double thighCm,
    required double weightKg,
    required double bmi,
    required double vatCm2,
    required RiskCategory risk,
  }) = _Measurement;
}

enum Sex { male, female }

enum RiskCategory { healthy, elevated, obesity }
```

### Storage Requirements

- All data stored locally (no cloud sync in v1)
- Profile: single record
- Measurements: append-only log (estimated 52 records/year)
- Export capability: JSON or CSV

### Performance Targets

| Metric | Target |
|--------|--------|
| Cold start | < 2 seconds |
| Calculation | < 100ms |
| Chart render | < 500ms |
| App size | < 20MB |

---

## Success Metrics

### Key Performance Indicators

| KPI | Target (6 months) | Measurement |
|-----|-------------------|-------------|
| Downloads | 5,000 | App store analytics |
| Monthly Active Users | 1,000 | In-app analytics |
| Measurement Frequency | 4x/month average | Local tracking |
| App Rating | 4.5+ stars | App store reviews |
| Crash-free rate | 99.5% | Crashlytics |

### User Satisfaction

- Task completion rate: > 95% for first calculation
- Time to first result: < 2 minutes (including profile setup)
- NPS score: > 50

---

## Future Considerations

### Version 1.1

- [ ] Apple Health / Google Fit integration
- [ ] Widget for quick logging
- [ ] Multiple user profiles (family mode)

### Version 2.0

- [ ] AI-powered recommendations based on trends
- [ ] Integration with smart scales
- [ ] Cloud sync (optional, privacy-first)
- [ ] Social features (anonymous comparison)

### Research Opportunities

- Partner with research institutions for formula validation
- Collect anonymized aggregate data for population studies
- Explore additional anthropometric models

---

## Appendix

### A. Research References

1. Samouda, H., Dutour, A., Chaumoitre, K., Panuel, M., Dutour, O., & Dadoun, F. (2013). VAT=TAAT-SAAT: innovative anthropometric model to predict visceral adipose tissue without resort to CT-Scan or DXA. *Obesity*, 21(1), E41-E50. [PMC3618381](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3618381/)

2. Luxembourg Institute of Health. Visceral Fat Calculator. [https://www.lih.lu/en/visceral-fat-calculator/](https://www.lih.lu/en/visceral-fat-calculator/)

### B. Competitor Analysis

| App | Pros | Cons |
|-----|------|------|
| Body Measurement Tracker | Comprehensive | Cluttered UI, no VAT focus |
| Waist Tracker | Simple | No scientific backing |
| Health apps (Apple/Google) | Integrated | No VAT calculation |

### C. Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Formula accuracy concerns | Medium | High | Clear scientific citations, disclaimer |
| Low user retention | Medium | Medium | Reminders, progress visualization |
| App store rejection | Low | High | Follow guidelines, clear health disclaimers |

---

*Document version: 1.0*
*Author: Claude Code*
*Created: December 26, 2025*
