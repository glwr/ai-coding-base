---
paths:
  - "src/components/**/*"
  - "src/app/**/*.tsx"
  - "src/app/**/*.jsx"
  - "src/pages/**/*"
  - "src/hooks/**/*"
  - "src/styles/**/*"
  - "app/**/*.tsx"
  - "app/**/*.jsx"
  - "components/**/*"
  - "pages/**/*"
---

# Frontend Development Rules

## Component Library First (MANDATORY)
- Before creating ANY UI component, check if the project's component library already has it
- NEVER create custom implementations of standard UI elements (buttons, inputs, selects, dialogs, modals, alerts, toasts, tables, tabs, cards, badges, dropdowns, tooltips, navigation, etc.)
- If a component is missing from the library, install it using the library's CLI or copy-paste method
- Custom components are ONLY for business-specific compositions that internally use library primitives

## Component Standards
- Use the project's CSS approach exclusively (no mixing of styling methods)
- All components must be responsive (mobile, tablet, desktop)
- Implement loading states, error states, and empty states
- Use semantic HTML and ARIA labels for accessibility
- Keep components small and focused
- Use TypeScript interfaces for all props

## Auth Best Practices
- Use full-page navigation for post-login redirects when needed (avoids stale state)
- Always verify session exists before redirecting
- Always reset loading state in all code paths (success, error, finally)
