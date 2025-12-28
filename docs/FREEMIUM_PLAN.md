# Visco Freemium Plan

## Overview

This document outlines the freemium monetization strategy for Visco, balancing user acquisition with revenue generation.

## Free Tier (Basic)

Core features available to all users:

- Single profile
- Manual measurements (weight, waist, thigh)
- VAT calculation with risk category
- BMI calculation and display
- Basic result display with trend indicator
- Limited history (last 10 measurements)
- Progress chart (limited to current time range)
- Measurement reminders
- Light/dark theme

## Premium Features

### 1. Advanced Analytics

- Detailed progress trends over time
- Predicted trajectory (estimated date to reach goal)
- Correlation insights (weight vs VAT relationship)
- Weekly/monthly summary reports
- Historical comparisons (month-over-month, year-over-year)

### 2. Unlimited Profiles

- Create unlimited profiles for family members
- Compare progress between profiles
- Family dashboard overview

### 3. Full History and Export

- Unlimited measurement history (free tier: 10)
- PDF export with detailed reports
- CSV export for spreadsheet analysis
- Cloud backup and sync across devices

### 4. Health App Integration

- Apple Health sync (read/write)
- Google Fit sync (read/write)
- Auto-import weight from smart scales
- Export VAT data to health platforms

### 5. Personalized Insights

- AI-powered recommendations based on trends
- Detailed risk assessment explanations
- Lifestyle tips based on progress patterns
- Goal adjustment suggestions

### 6. Customization

- Custom goal ranges and multiple targets
- Additional themes and color schemes
- Custom app icons
- Widget support for home screen

### 7. Achievements and Motivation

- Progress milestones and badges
- Measurement streaks tracking
- Personal records highlights
- Motivational notifications

## Pricing Model

### Option A: One-Time Purchase

| Tier | Price | Features |
|------|-------|----------|
| Free | $0 | Basic features |
| Premium | $9.99 | All premium features, lifetime |

### Option B: Subscription

| Tier | Price | Features |
|------|-------|----------|
| Free | $0 | Basic features |
| Premium Monthly | $1.99/month | All premium features |
| Premium Annual | $9.99/year | All premium features (save 58%) |

### Option C: Hybrid (Recommended)

| Tier | Price | Features |
|------|-------|----------|
| Free | $0 | Basic features |
| Premium Annual | $9.99/year | All premium features |
| Premium Lifetime | $24.99 | All premium features, one-time |

## Implementation Priority

### Phase 1 - Foundation

1. Implement paywall infrastructure
2. Add premium flag to user profile
3. Limit history to 10 measurements for free users
4. Lock multiple profiles behind premium

### Phase 2 - Core Premium Features

1. Unlimited history for premium
2. Full PDF/CSV export
3. Unlimited profiles
4. Cloud backup

### Phase 3 - Advanced Features

1. Health app integration
2. Advanced analytics
3. AI-powered insights
4. Widgets

## Feature Gating Strategy

| Feature | Free | Premium |
|---------|------|---------|
| Single profile | Yes | Yes |
| Multiple profiles | No | Yes |
| VAT calculation | Yes | Yes |
| BMI calculation | Yes | Yes |
| Trend indicator | Yes | Yes |
| History (10 entries) | Yes | Yes |
| Unlimited history | No | Yes |
| Progress chart | Yes | Yes |
| Advanced analytics | No | Yes |
| PDF export | No | Yes |
| CSV export | No | Yes |
| Cloud backup | No | Yes |
| Health app sync | No | Yes |
| Reminders | Yes | Yes |
| Themes | Basic | All |
| Widgets | No | Yes |

## User Acquisition Strategy

1. Keep core VAT calculation free to build trust
2. Allow users to experience value before paywall
3. Show premium features with "upgrade" prompts
4. Offer 7-day free trial for premium
5. Request reviews after positive interactions

## Revenue Projections

Assumptions:
- 10,000 downloads in first year
- 5% conversion rate to premium
- Average revenue per premium user: $12

Projected first year revenue: $6,000

## Technical Implementation Notes

- Use RevenueCat or in-app purchases directly
- Store premium status locally with server validation
- Graceful degradation if subscription lapses
- Restore purchases functionality required for App Store

## App Store Considerations

- Clearly communicate free vs premium features
- No paywalls before core functionality is demonstrated
- Subscription terms must be clear and visible
- Offer restore purchases option
