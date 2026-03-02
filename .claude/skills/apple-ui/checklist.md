# SwiftUI Implementation Checklist

Before marking UI implementation as complete:

## Existing Code
- [ ] Checked existing views and components via git
- [ ] Reused existing shared components where possible
- [ ] Followed established patterns from `context/patterns.md`

## Design
- [ ] Design preferences clarified with user (if no mockups)
- [ ] View hierarchy from Solution Architect followed

## Implementation
- [ ] All planned views implemented
- [ ] Architecture pattern followed (MVVM / TCA / as specified)
- [ ] Business logic kept out of views (in ViewModels or models)
- [ ] Subviews extracted when body exceeds ~30 lines
- [ ] `#Preview` macro added for all views
- [ ] Navigation flows implemented (NavigationStack, sheets, alerts)

## State Management
- [ ] `@State` used only for view-local state
- [ ] `@Observable` / `@Binding` used for shared state
- [ ] No unnecessary state changes causing redraws
- [ ] `@MainActor` applied where needed

## Quality
- [ ] Dynamic Type supported (no fixed font sizes)
- [ ] Dark Mode supported (no hardcoded colors — use semantic/asset colors)
- [ ] Accessibility labels on all interactive elements
- [ ] VoiceOver navigation order is logical
- [ ] Touch targets are at least 44x44 points
- [ ] Loading states implemented (ProgressView during data fetches)
- [ ] Error states implemented (user-friendly error views)
- [ ] Empty states implemented ("No data yet" views)

## Platform
- [ ] iPad layout considered (if applicable — sidebar, split view)
- [ ] Landscape orientation handled (if applicable)
- [ ] Safe area insets respected

## Verification (run before marking complete)
- [ ] Project builds without errors: `xcodebuild build -scheme AppName ...`
- [ ] No SwiftUI preview crashes
- [ ] All acceptance criteria from feature spec addressed in UI
- [ ] `features/INDEX.md` status updated to "In Progress"

## Completion
- [ ] User has reviewed and approved the UI in Simulator
- [ ] Code committed to git
