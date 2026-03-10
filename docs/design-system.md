# Design System

> Brand guidelines and design tokens extracted from [glueckkanja.com](https://www.glueckkanja.com). Source of truth for all visual decisions.

## Aesthetic Direction

- **Style:** Corporate-modern with bold geometric accents — clean layouts, flat colors, strong visual hierarchy
- **Mood:** Professional, confident, and technical — trustworthy enterprise IT partner
- **Reference:** [glueckkanja.com](https://www.glueckkanja.com/en/)
- **Density:** Spacious — generous whitespace, large typography, breathing room between sections
- **Visual Identity:** Colorful geometric shape animations (triangles, circles) in brand colors; no gradients, no shadows on content; sharp corners throughout

## Brand Colors

### Primary Palette

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `--color-primary` | `#5CBBFF` | `rgb(92, 187, 255)` | Primary brand blue — buttons, links, active states, hero backgrounds |
| `--color-primary-accent` | `#4083B3` | `rgb(64, 131, 179)` | Hover states for primary elements |
| `--color-blue-dark` | `#000520` | `rgb(0, 5, 32)` | Headlines, body copy, dark backgrounds |
| `--color-blue-medium` | `#0072C6` | `rgb(0, 114, 198)` | Footer background, pagination active, checkbox fills |
| `--color-blue-jeans` | `#24A1FA` | `rgb(36, 161, 250)` | Testimonials accent, alternate blue |
| `--color-blue-light` | `#5CBBFF` | `rgb(92, 187, 255)` | Same as primary — hero sections, large backgrounds |
| `--color-blue-lighter` | `#77C6FF` | `rgb(119, 198, 255)` | Lighter blue variant |

### Accent Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `--color-yellow` | `#FCD116` | `rgb(252, 209, 22)` | Primary accent — highlights, shape animations, badges, step markers, table marks |
| `--color-orange` | `#F8842C` | `rgb(248, 132, 44)` | Secondary accent — emergency CTA ("Under Attack?"), overlines, scroll arrows, card highlights |
| `--color-red` | `#E44418` | `rgb(228, 68, 24)` | Error states, form validation |
| `--color-green-blue` | `#008187` | `rgb(0, 129, 135)` | Teal — event teaser backgrounds, form success |
| `--color-deep-sea` | `#008774` | `rgb(0, 135, 116)` | Alternate teal for success states |

### Purple Palette (used in geometric shapes)

| Token | Hex | Usage |
|-------|-----|-------|
| `--color-gigas` | `#543B9C` | Deep purple — geometric accents |
| `--color-butterfly-bush` | `#524FA3` | Purple variant |
| `--color-cold-purple` | `#A09EDB` | Light purple |
| `--color-lavender` | `#AD76E5` | Lavender accent |
| `--color-biloba-flower` | `#BD90EA` | Soft purple |
| `--color-perfume` | `#DDC3F7` | Very light purple |

### Green Palette

| Token | Hex | Usage |
|-------|-----|-------|
| `--color-conifer` / `--color-green` | `#ACD653` | Lime green — loading animation, geometric shapes |
| `--color-celery` | `#9FC54F` | Green variant |
| `--color-sushi` | `#809F3E` | Dark green |
| `--color-mint-green` | `#80F785` | Bright mint |

### Neutral Palette

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `--color-white` | `#FFFFFF` | `rgb(255, 255, 255)` | Page background, text on dark |
| `--color-black-4` / surface | `#F5F5F5` | `rgb(245, 245, 245)` | Surface background, cards, event teasers |
| `--color-porcelain` | `#F3F5F6` | `rgb(243, 245, 246)` | Form backgrounds, grey sections |
| `--color-polar` | `#F6F9FD` | `rgb(246, 249, 253)` | Header contact background, subtle grey |
| `--color-black-15` | `#D9D9D9` | | Light borders |
| `--color-ghost` | `#CCCDD2` | | Header border, link list border |
| `--color-athens-gray` | `#E5E6E9` | | Header container border |
| `--color-black-30` | `#B2B2B2` | | Default borders, copy lowlight |
| `--color-bombay` | `#B3B4BC` | `rgb(179, 180, 188)` | Input placeholder text, link list icons |
| `--color-manatee` | `#999BA6` | | Pricing borders, event timing |
| `--color-black-50` | `#7F7F7F` | `rgb(127, 127, 127)` | Reduced copy |
| `--color-trout` | `#4C5062` | `rgb(76, 80, 98)` | Service labels, FAQ borders |
| `--color-shuttle-gray` | `#666979` | `rgb(102, 105, 121)` | Header product subtitles |
| `--color-black-85` | `#262626` | | Page detail copy, dark text variant |
| `--color-black` | `#000000` | | Pure black (rarely used) |

### Semantic Color Aliases

| Token | Resolves To | Usage |
|-------|-------------|-------|
| `--color-headlines` | `--color-blue-dark` (#000520) | All headings |
| `--color-copy` | `--color-blue-dark` (#000520) | Body text |
| `--color-copy-light` | `--color-white` (#FFF) | Text on dark backgrounds |
| `--color-background` | `--color-white` (#FFF) | Page background |
| `--color-surface-background` | `--color-black-4` (#F5F5F5) | Card/section surfaces |
| `--color-link` | `--color-primary` (#5CBBFF) | Link text |
| `--color-link-hover` | `--color-primary-accent` (#4083B3) | Link hover |
| `--color-active` | `--color-primary` (#5CBBFF) | Active/selected states |
| `--color-highlight` | `--color-primary-accent` (#4083B3) | Text highlights |
| `--color-highlight-second` | `#FCD116` (yellow) | Underline/animated highlights |
| `--color-emergency` | `--color-orange` (#F8842C) | Emergency banner |

### Status / Badge Colors

| Status | Background | Text |
|--------|-----------|------|
| Badge default | `--color-orange` (#F8842C) | `--color-white` (#FFF) |
| Form error | `--color-red` (#E44418) | — |
| Form success | `--color-deep-sea` (#008774) | — |
| Emergency | `--color-orange` (#F8842C) | `--color-white` (#FFF) |

## Typography

### Font Family

| Token | Value | Usage |
|-------|-------|-------|
| `--font-family` | `"Lato", sans-serif` | All text — headings, body, buttons, navigation |

**Single font family** — Lato covers all weights from Thin (100) to Bold (700). No secondary/display font.

### Font Loading

```html
<!-- Google Fonts — Lato with required weights -->
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@100;300;400;700&display=swap" rel="stylesheet">
```

### Heading Scale

| Level | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| H1 | `60px` (3.75rem) | `700` (Bold) | `72px` (1.2) | Hero headlines, page titles |
| H2 | `28.8px` (~1.8rem) | `400` (Regular) | `42px` (1.46) | Section headings |
| H3 | `60px` (3.75rem) | `100` (Thin) | `72px` (1.2) | Large thin display text (e.g. "Our Focus Areas") |
| H4 | `28.8px` (~1.8rem) | `400` (Regular) | `42px` (1.46) | Card titles, article headings |

**Note:** H3 uses Thin weight (100) for dramatic contrast against bold H1. This is a distinctive brand pattern.

### Body Text

| Context | Size | Weight | Line Height |
|---------|------|--------|-------------|
| Hero subtitle | `24px` (1.5rem) | `400` | `40.8px` (1.7) |
| Article body (case studies) | `25px` (~1.56rem) | `400` | `40px` (1.6) |
| Default body | `16px` (1rem) | `400` | `1.6` |
| Navigation | `16px` (1rem) | `400` | — |
| Buttons | `16px` (1rem) | `700` | — |
| Labels / Overlines | `12-14px` | `400-700` | — |
| Captions / Meta | `12px` (0.75rem) | `400` | — |

### Default Line Height

| Token | Value |
|-------|-------|
| `--type-default-line-height` | `1.6` |

### Text Colors

| Context | Color | Hex |
|---------|-------|-----|
| Headings | `--color-blue-dark` | `#000520` |
| Body copy | `--color-blue-dark` | `#000520` |
| Text on dark/blue backgrounds | `--color-white` | `#FFFFFF` |
| Muted/secondary text | `--color-black-50` | `#7F7F7F` |
| Link text | `--color-primary` | `#5CBBFF` |
| Link hover | `--color-primary-accent` | `#4083B3` |
| Overline text (hero) | `--color-orange` | `#F8842C` |

## Spacing

| Token | Value | Usage |
|-------|-------|-------|
| `--spacing-base` | `16px` (1rem) | Base unit, paragraph margins |
| `--spacing-medium` | `2.5rem` (40px) | Medium section padding |
| `--spacing-medium-large` | `3.75rem` (60px) | Between content blocks |
| `--spacing-large` | `5rem` (80px) | Large section spacing, footer top padding |
| Section gap | `56px` (3.5rem) | Gap between content blocks in articles |
| Content margin-top | `64px` (4rem) | Padding-top for content sections |
| Section margin-top | `80px` (5rem) | Top margin for major sections |

### Spacing Patterns (observed)

- **Button padding:** `12px 16px` (standard), `12px 64px 12px 16px` (with icon/arrow)
- **Paragraph margin-bottom:** `16px`
- **Article body margin-bottom:** `24px`
- **Footer padding-top:** `80px`
- **Content section gap:** `56px`

## Border Radius

| Element | Value | Notes |
|---------|-------|-------|
| Buttons | `0px` | **Sharp corners** — no rounding on any buttons |
| Cards | `0px` | Sharp corners throughout |
| Inputs | `0px` | Sharp form fields |
| Pagination dots | `50%` (circle) | Only circular element |
| Everything else | `0px` | The entire site uses sharp corners as a design principle |

**Key principle:** glueckkanja uses **zero border-radius everywhere** except pagination indicators. This gives the site a sharp, technical, corporate feel.

## Shadows

The site uses **no box-shadows** on cards, buttons, or content elements. Elevation is achieved through background color contrast instead.

| Context | Approach |
|---------|----------|
| Cards | Background color change (`#F5F5F5` on `#FFF`) |
| Hover states | Color/opacity transitions |
| Modals | Overlay with semi-transparent background |
| Focus states | Border color change |

## Dark Mode

The glueckkanja website does **not** implement a dark mode. The design is light-mode only with dark sections achieved through colored backgrounds:

| Section Type | Background | Text |
|-------------|-----------|------|
| Default page | `#FFFFFF` | `#000520` |
| Surface/card | `#F5F5F5` | `#000520` |
| Blue hero | `#5CBBFF` | `#000520` / `#FFF` |
| Teal section | `#008187` | `#FFFFFF` |
| Footer | `#0072C6` | `#FFFFFF` |
| Dark section | `#000520` | `#FFFFFF` |

## Breakpoints

| Name | Width | Target |
|------|-------|--------|
| Mobile | `< 768px` | Phones |
| Tablet | `768px` | Tablets |
| Desktop | `1024px` | Standard desktop |
| Wide | `1200px+` | Large screens |

## Layout Conventions

- **Navigation:** Fixed top-nav with transparent-to-white background on scroll. Mega-menu dropdowns for Workplace, Azure, Security, Products, Company. Language switcher (en/de/es) on far right
- **Content Width:** Full-bleed hero sections, constrained content width for articles/text. Max content width ~900-1000px for readable text
- **Grid:** Sections alternate between full-width (hero, image+text, logos) and centered content columns
- **Card vs List:** Article teasers use horizontal card layout (image left, text right). Event teasers use vertical stacked layout with calendar date accent. Social feed uses uniform card grid
- **Modal vs Page:** Content pages (case studies, articles) are full-page transitions. Product/service navigation uses mega-menu overlays
- **Section Pattern:** Alternating white and grey (`#F5F5F5`) backgrounds to visually separate content blocks. Featured sections use brand colors (blue, teal) as full-width backgrounds

### Header

| Property | Value |
|----------|-------|
| Height | ~82px |
| Position | `fixed` (sticky on scroll) |
| Background | `rgba(255, 255, 255, 0.3)` (transparent, becomes solid on scroll) |
| Border | `--color-ghost` (#CCCDD2) bottom |
| Logo | "glueck**kanja**" wordmark (left-aligned) |

### Footer

| Property | Value |
|----------|-------|
| Background | `--color-blue-medium` (#0072C6) |
| Text color | White |
| Padding-top | `80px` |
| Content | Logo, locations, contact, partner badges, certifications, social links |
| Bottom bar | Separator line, legal links (Privacy, Imprint, No Cookies), social icons |

## Geometric Shape System

The glueckkanja brand uses a distinctive **animated geometric shape system** in hero sections:

### Shapes Used
- **Triangles** (chevron-like) — in yellow (`#FCD116`), orange (`#F8842C`)
- **Circles** (ring/donut) — in yellow (`#FCD116`)
- **Rectangles** — in purple (`#543B9C`), green (`#ACD653`), orange (`#F8842C`), blue (`#5CBBFF`)

### Shape Colors (4-color system)
1. `--color-primary` / Blue: `#5CBBFF`
2. `--color-yellow`: `#FCD116`
3. `--color-orange`: `#F8842C`
4. `--color-conifer` / Green: `#ACD653`
5. `--color-gigas` / Purple: `#543B9C` (supplementary)

These shapes appear as background decorations in hero sections, creating a vibrant, dynamic visual identity while maintaining a clean content area.

## Design Do's & Don'ts

### Do
- Use `#000520` (blue-dark) for all text — never pure black `#000`
- Use `#5CBBFF` (primary blue) for all interactive elements (links, buttons, CTAs)
- Use `#FCD116` (yellow) for highlights, accents, and emphasis markers
- Use `#F8842C` (orange) for urgency and emergency elements
- Use sharp corners (0px border-radius) on all rectangular elements
- Use generous spacing between sections (56-80px)
- Use large, readable font sizes (25px body text in articles)
- Use Lato Thin (100) for dramatic display text contrast
- Alternate section backgrounds between white and `#F5F5F5`
- Use full-bleed color sections (blue, teal) for featured content

### Don't
- Use border-radius on buttons, cards, or inputs — the brand is sharp-cornered
- Use box-shadows for elevation — use background color contrast instead
- Use fonts other than Lato
- Use pure black (`#000`) for text — always use `#000520`
- Use gradients — the brand uses flat, solid colors
- Mix more than 2-3 brand colors in one section
- Use thin borders on cards — use background color to define boundaries
- Add decorative elements that compete with the geometric shape system

## Component Tokens

### Buttons

| Variant | Background | Text | Border | Padding |
|---------|-----------|------|--------|---------|
| Primary | `#5CBBFF` | `#FFF` | `2px solid #5CBBFF` | `12px 16px` |
| Emergency/CTA | `#F8842C` | `#FFF` | `2px solid #F8842C` | `12px 64px 12px 16px` |
| All buttons | — | — | `border-radius: 0` | `font-weight: 700` |

**Button characteristics:**
- Font size: `16px`
- Font weight: `700` (Bold)
- Border radius: `0px` (sharp corners)
- Text transform: `none` (sentence case)
- Always has a matching border (2px solid, same color as background)

### Cards (Article Teasers)

- **Background:** `--color-surface-background` (#F5F5F5)
- **Border:** None (defined by background contrast)
- **Border radius:** `0px`
- **Layout:** Image + text side-by-side (horizontal) or stacked (vertical)
- **Card highlight accent:** `--color-orange` (#F8842C)

### Event Teasers

- **Background:** `--color-black-2` (#FBFBFB)
- **Calendar date block:** Day number prominently displayed with month below
- **Timing text color:** `--color-manatee` (#999BA6)
- **Highlight timing:** `--color-orange` (#F8842C)
- **Teaser banner background:** `--color-green-blue` (#008187)

### Form Inputs

- **Background:** `--color-porcelain` (#F3F5F6)
- **Border:** `--color-bon-jour` (#E5E2E2)
- **Border hover:** `--color-black-30` (#B2B2B2)
- **Border radius:** `0px`
- **Error color:** `--color-red` (#E44418)
- **Success color:** `--color-deep-sea` (#008774)

### Links

| State | Color | Decoration |
|-------|-------|------------|
| Default | `#5CBBFF` | None |
| Hover | `#4083B3` | None |
| On dark background | `#5CBBFF` | None |

### Tags / Service Buttons

- **Style:** Inline text with arrow icon
- **Border radius:** `0px`
- **Behavior:** Expand/navigate on click
- **Icon:** Chevron/arrow right

### Pagination

- **Active indicator:** `#0072C6` filled circle
- **Inactive indicator:** `#999` filled circle
- **Shape:** `border-radius: 50%` (only circular element in the design)

## Loading Animation

| Token | Color |
|-------|-------|
| `--color-loading--1` | `#5CBBFF` (primary blue) |
| `--color-loading--2` | `#FCD116` (yellow) |
| `--color-loading--3` | `#ACD653` (green) |
| `--color-loading--4` | `#F8842C` (orange) |

The loading animation cycles through the 4 brand accent colors.

## CSS Implementation

Design tokens are implemented as **CSS Custom Properties** on `:root`. The site is built with **Nuxt.js** (Vue.js SSR framework).

```css
:root {
  /* Site identifier */
  --site: "gk";

  /* Primary */
  --color-primary: #5CBBFF;
  --color-primary-accent: #4083B3;
  --color-primary-on-surface: #fff;

  /* Secondary (same as primary for gk) */
  --color-secondary: #5CBBFF;
  --color-secondary-accent: #4083B3;

  /* Brand accents */
  --color-yellow: #FCD116;
  --color-orange: #F8842C;
  --color-green: #ACD653;
  --color-red: #E44418;

  /* Text */
  --color-blue-dark: #000520;
  --color-headlines: var(--color-blue-dark);
  --color-copy: var(--color-blue-dark);
  --color-copy-light: #fff;

  /* Backgrounds */
  --color-background: #fff;
  --color-surface-background: #F5F5F5;
  --color-blue-medium: #0072C6;
  --color-green-blue: #008187;

  /* Typography */
  --font-family: "Lato", sans-serif;
  --type-default-line-height: 1.6;

  /* Spacing */
  --spacing-medium: 2.5rem;
  --spacing-medium-large: 3.75rem;
  --spacing-large: 5rem;
}
```

## Social Media Presence

| Platform | URL |
|----------|-----|
| Twitter/X | https://twitter.com/glueckkanja_ |
| YouTube | https://www.youtube.com/user/glueckkanja |
| LinkedIn | https://www.linkedin.com/company/glueckkanja |
| GitHub | https://github.com/glueckkanja |

## Brand Assets

- **Logo:** "glueck**kanja**" wordmark — "glueck" in regular weight, "kanja" in bold, with a small colored square between the two words
- **404 Page:** Features a meerkat photo with friendly error message
- **No Cookies Policy:** The site explicitly operates without tracking cookies

---

_Last updated: 2026-03-10_
_Source: Automated extraction from glueckkanja.com via Playwright + CSS analysis_
