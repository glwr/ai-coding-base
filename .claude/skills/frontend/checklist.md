# Frontend Implementation Checklist

Before marking frontend as complete:

## Component Library
- [ ] Checked the project's component library for EVERY UI component needed
- [ ] No custom duplicates of library components created
- [ ] Missing components installed via the library's CLI or copy-paste method

## Existing Code
- [ ] Checked existing project components via git
- [ ] Reused existing components where possible

## Design
- [ ] Design preferences clarified with user (if no mockups)
- [ ] Component architecture from Solution Architect followed

## Implementation
- [ ] All planned components implemented
- [ ] All components use the project's CSS approach (no mixing of styling methods)
- [ ] Loading states implemented (spinner/skeleton during data fetches)
- [ ] Error states implemented (user-friendly error messages)
- [ ] Empty states implemented ("No data yet" messages)

## Design System Compliance
- [ ] All colors reference design tokens (no hardcoded hex values)
- [ ] All spacing uses token scale (no arbitrary px/rem values)
- [ ] Typography uses defined font sizes and weights
- [ ] Border radius uses token values
- [ ] Dark mode works correctly (if design-system.md defines dark tokens)
- [ ] Layout follows conventions from design-system.md (navigation, grid, density)
- [ ] Aesthetic direction matches the defined style/mood

## Quality
- [ ] Responsive: Mobile, Tablet, Desktop
- [ ] Accessibility: Semantic HTML, ARIA labels, keyboard navigation
- [ ] TypeScript: No errors (build passes)
- [ ] Linting: No warnings (lint passes)

## Verification (run before marking complete)
- [ ] Build passes without errors
- [ ] All acceptance criteria from feature spec addressed in UI
- [ ] `features/INDEX.md` status updated to "In Progress"

## Completion
- [ ] User has reviewed and approved the UI in browser
- [ ] Code committed to git
