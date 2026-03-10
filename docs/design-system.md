# Design System

> Brand guidelines, design tokens, and component styling conventions. Fill in when establishing the visual identity.

## Aesthetic Direction

_Define the overall visual identity:_

- **Style:** _TBD_ _(modern/minimal, corporate, playful, brutalist, glassmorphism, etc.)_
- **Mood:** _TBD_ _(clean & professional, warm & friendly, bold & energetic, etc.)_
- **Reference:** _TBD_ _(URLs, app names, or screenshots for visual inspiration)_
- **Density:** _TBD_ _(compact, comfortable, spacious)_

## Brand Colors

_Define the core color palette:_

| Token | Hex | Usage |
|-------|-----|-------|
| `--color-primary` | _#3B82F6_ | _Buttons, links, active states_ |
| `--color-primary-dark` | _#2563EB_ | _Hover states_ |
| `--color-secondary` | _#64748B_ | _Secondary actions_ |
| `--color-accent` | _#F59E0B_ | _Highlights, badges_ |
| `--color-success` | _#22C55E_ | _Success states_ |
| `--color-warning` | _#F59E0B_ | _Warning states_ |
| `--color-error` | _#EF4444_ | _Error states, destructive actions_ |
| `--color-background` | _#FFFFFF_ | _Page background_ |
| `--color-surface` | _#F8FAFC_ | _Card backgrounds_ |
| `--color-text` | _#1E293B_ | _Body text_ |
| `--color-text-muted` | _#64748B_ | _Secondary text_ |

### Status / Badge Colors

_For status indicators, tags, or badges:_

| Status | Background | Text |
|--------|-----------|------|
| _New_ | _#E0F2FE_ | _#0369A1_ |
| _In Progress_ | _#FEF3C7_ | _#92400E_ |
| _Done_ | _#DCFCE7_ | _#166534_ |
| _Blocked_ | _#FEE2E2_ | _#991B1B_ |

## Typography

| Token | Value | Usage |
|-------|-------|-------|
| `--font-family` | _'Inter', sans-serif_ | _All text_ |
| `--font-size-xs` | _0.75rem (12px)_ | _Labels, captions_ |
| `--font-size-sm` | _0.875rem (14px)_ | _Body text, inputs_ |
| `--font-size-md` | _1rem (16px)_ | _Default body_ |
| `--font-size-lg` | _1.25rem (20px)_ | _Section headers_ |
| `--font-size-xl` | _1.5rem (24px)_ | _Page titles_ |
| `--font-size-2xl` | _2rem (32px)_ | _Hero headings_ |
| `--font-weight-normal` | _400_ | _Body text_ |
| `--font-weight-medium` | _500_ | _Labels, navigation_ |
| `--font-weight-semibold` | _600_ | _Headings_ |
| `--font-weight-bold` | _700_ | _Emphasis_ |

### Font Loading

_Describe how fonts are loaded (Google Fonts, self-hosted, framework optimization):_

```html
<!-- Example: Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
```

## Spacing

| Token | Value | Usage |
|-------|-------|-------|
| `--space-xs` | _0.25rem (4px)_ | _Tight gaps_ |
| `--space-sm` | _0.5rem (8px)_ | _Small gaps_ |
| `--space-md` | _1rem (16px)_ | _Default spacing_ |
| `--space-lg` | _1.5rem (24px)_ | _Section spacing_ |
| `--space-xl` | _2rem (32px)_ | _Large gaps_ |
| `--space-2xl` | _3rem (48px)_ | _Page-level spacing_ |

## Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `--radius-sm` | _0.25rem_ | _Small elements (badges, chips)_ |
| `--radius-md` | _0.5rem_ | _Buttons, inputs, cards_ |
| `--radius-lg` | _0.75rem_ | _Modals, panels_ |
| `--radius-full` | _9999px_ | _Avatars, circular elements_ |

## Shadows

| Token | Value | Usage |
|-------|-------|-------|
| `--shadow-sm` | _0 1px 2px rgba(0,0,0,0.05)_ | _Subtle elevation_ |
| `--shadow-md` | _0 4px 6px rgba(0,0,0,0.1)_ | _Cards, dropdowns_ |
| `--shadow-lg` | _0 10px 15px rgba(0,0,0,0.1)_ | _Modals, popovers_ |

## Dark Mode

_Define color overrides for dark mode (skip if using framework automatic dark mode):_

| Token | Light | Dark |
|-------|-------|------|
| `--color-background` | _#FFFFFF_ | _#0F172A_ |
| `--color-surface` | _#F8FAFC_ | _#1E293B_ |
| `--color-text` | _#1E293B_ | _#F1F5F9_ |
| `--color-text-muted` | _#64748B_ | _#94A3B8_ |
| `--color-border` | _#E2E8F0_ | _#334155_ |

## Breakpoints

| Name | Width | Target |
|------|-------|--------|
| `sm` | _640px_ | _Mobile landscape_ |
| `md` | _768px_ | _Tablet_ |
| `lg` | _1024px_ | _Desktop_ |
| `xl` | _1280px_ | _Wide desktop_ |

## Layout Conventions

_Define structural layout patterns:_

- **Navigation:** _TBD_ _(sidebar, top-nav, bottom-tab, hamburger)_
- **Content Width:** _TBD_ _(full-bleed, max-width container, centered)_
- **Grid:** _TBD_ _(CSS Grid columns, gap sizes, or auto-layout)_
- **Card vs List:** _TBD_ _(when to use cards vs flat lists)_
- **Modal vs Page:** _TBD_ _(when to use modal vs full-page transition)_

## Design Do's & Don'ts

### Do
- _Use consistent spacing from the token scale_
- _Group related actions (max 3 primary actions per view)_
- _Use progressive disclosure for complex forms_
- _Maintain clear visual hierarchy (one primary CTA per section)_

### Don't
- _Mix rounded and sharp corners in the same context_
- _Use more than 2 font weights per component_
- _Hardcode color, spacing, or font-size values instead of tokens_
- _Create custom UI components when the component library has one_

## Component Tokens

_Document component-specific design decisions:_

### Buttons
- **Height:** _40px (default), 32px (small), 48px (large)_
- **Padding:** _0 16px_
- **Border radius:** _var(--radius-md)_
- **Font weight:** _500_

### Cards
- **Background:** _var(--color-surface)_
- **Border:** _1px solid var(--color-border, #E2E8F0)_
- **Border radius:** _var(--radius-lg)_
- **Padding:** _var(--space-lg)_

### Inputs
- **Height:** _40px_
- **Border:** _1px solid #CBD5E1_
- **Border radius:** _var(--radius-md)_
- **Focus ring:** _2px solid var(--color-primary)_

## CSS Implementation

_How are design tokens implemented in code?_

### Option A: CSS Custom Properties
```css
:root {
  --color-primary: #3B82F6;
  --radius-md: 0.5rem;
  /* ... */
}
```

### Option B: Tailwind Theme
```javascript
// tailwind.config.js
theme: {
  extend: {
    colors: {
      primary: '#3B82F6',
    },
  },
}
```

### Option C: Design Token File
```typescript
// src/design-tokens.ts
export const colors = {
  primary: '#3B82F6',
  // ...
} as const;
```

## Apple-Specific Tokens

_Fill in when Platform = Apple:_

| Token | Value | Usage |
|-------|-------|-------|
| `accent-color` | _AccentColor asset_ | _Tint color for controls_ |
| `min-touch-target` | _44x44pt_ | _Minimum tap area (HIG requirement)_ |
| `corner-style` | _continuous_ | _iOS continuous corners vs circular_ |
| `default-padding` | _16pt_ | _Standard content padding_ |
| `list-row-height` | _44pt_ | _Minimum list row height_ |

---

_Last updated: YYYY-MM-DD_
