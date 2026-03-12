---
name: hig-review
description: Review Apple app for Human Interface Guidelines compliance. Checks accessibility, navigation, layout, and platform conventions.
argument-hint: [feature-spec-path or "all" for full review]
user-invocable: true
context: fork
agent: swift-reviewer
model: opus
---

# HIG Compliance Review

Run a Human Interface Guidelines compliance review of the app's UI.

## Before Starting
1. Read `features/INDEX.md` for project context
2. Read `context/patterns.md` for established UI patterns
3. Read `context/learnings.md` for known HIG issues
4. Read `CLAUDE.md` for platform and minimum deployment target

## Determine Scope

If arguments specify a feature (e.g., `features/PROJ-X-name.md`):
- Read the feature spec
- Focus review on views related to that feature
- Use `git log --oneline --grep="PROJ-X" --name-only` to find relevant files

If arguments say "all" or no arguments:
- Review all Swift view files: `git ls-files | grep -E '\.swift$'`
- Focus on recently changed files: `git diff HEAD~5 --name-only | grep -E '\.swift$'`

## Review Phases

### Phase 1: Accessibility
1. Check for missing accessibility labels:
   ```bash
   # Find interactive elements without accessibility modifiers
   grep -rn "Button\|Toggle\|Slider\|Picker\|TextField\|Link" --include="*.swift" | grep -v "accessibilityLabel\|accessibilityHint\|// Preview"
   ```
2. Check for fixed font sizes (should use Dynamic Type):
   ```bash
   grep -rn '\.font(.system(size:' --include="*.swift"
   grep -rn 'UIFont.systemFont(ofSize:' --include="*.swift"
   ```
3. Check for hardcoded colors (should support Dark Mode):
   ```bash
   grep -rn 'Color(.sRGB\|UIColor(red:\|NSColor(red:' --include="*.swift" | grep -v "Assets\|Color("
   ```
4. Verify VoiceOver support:
   - Check for `.accessibilityElement(children:)` on complex views
   - Check for `.accessibilityValue` on stateful elements
   - Check for `.accessibilityAction` where gestures are used

### Phase 2: Navigation & Layout
1. Check navigation patterns:
   - `NavigationStack` used (not deprecated `NavigationView`)
   - Back button behavior is standard
   - Tab bar items have both icon and label
   - Sheet/modal dismiss is accessible
2. Check layout:
   - Safe area respected (no content under notch/home indicator)
   - Scroll views used for content that may exceed screen
   - Minimum touch target size of 44x44 points
3. Check platform conventions:
   - iOS: Tab bar at bottom, navigation bar at top
   - macOS: Menu bar, sidebar navigation, toolbar
   - iPad: Split view or sidebar for master-detail

### Phase 3: Visual Design
1. Check for platform consistency:
   - System SF Symbols used (not custom icons for standard actions)
   - System colors used where appropriate (`.primary`, `.secondary`, `.accent`)
   - Standard spacing and padding values
2. Check for loading/error/empty states:
   - `ProgressView` for loading states
   - Error views with retry action
   - Empty state views with guidance
3. Check for proper use of system components:
   - `Alert` for destructive confirmations
   - `Sheet` for modal content
   - `Menu` for contextual actions

### Phase 4: Platform-Specific
1. **iOS:**
   - Supports portrait and landscape (or explicitly locked with reason)
   - Pull-to-refresh for refreshable content
   - Swipe actions on list items (where appropriate)
2. **macOS:**
   - Keyboard shortcuts for common actions
   - Menu bar integration
   - Window resizing handled gracefully
3. **iPad:**
   - Multitasking (Split View, Slide Over) supported
   - Pointer/trackpad interaction supported
   - Sidebar navigation for content hierarchy

### Phase 5: Content & Typography
1. System fonts used (SF Pro, SF Mono, New York) unless brand requires custom
2. Text styles use semantic sizing (`.title`, `.body`, `.caption`)
3. Sufficient color contrast ratios (4.5:1 for normal text, 3:1 for large text)
4. Truncation handled gracefully (no clipped text)

## Output

### Step 1: Write Report
Write findings using this format for each issue:

```
**[SEVERITY]** [Title]
- **File:** path/to/file:line
- **HIG Section:** [Accessibility | Navigation | Layout | Visual Design | Platform]
- **Issue:** What's wrong
- **Guideline:** What HIG recommends
- **Fix:** How to fix it
- **Example:** Code snippet showing the fix (if applicable)
```

Severity levels:
- **CRITICAL**: App Store rejection risk (missing accessibility, broken navigation)
- **HIGH**: Significant UX issue, major HIG violation
- **MEDIUM**: Should fix, non-standard pattern
- **LOW**: Polish item, minor improvement

### Step 2: Update Feature Spec (if scoped to a feature)
Add a brief HIG Review section to the feature spec file:
```markdown
## HIG Review
**Date:** YYYY-MM-DD
**Result:** X findings (Y critical, Z high)
**Recommendation:** Fix critical/high findings | Ready for submission
```

### Step 3: Create Bug Entries for ALL Findings
For EVERY finding (all severities — Critical, High, Medium, and Low):
1. Read `features/INDEX.md` to find the "Next Bug ID: BUG-X" counter
2. Read `.claude/skills/tracking-guide.md` for tracking operations (variant detection: File-based or GitHub Issues)
3. Create a bug file in `backlog/BUG-X-name.md` using `backlog/bug-template.md`
   - Set Source to `/hig-review` and link the related feature
4. If Tracking = GitHub Issues, create a GitHub Issue:
   ```bash
   gh issue create --title "BUG-X: [title]" --label "type:bug,priority:pX,status:open" --body "[description, HIG section, guideline reference, fix suggestion]"
   ```
5. Add the bug to the Backlog table in `features/INDEX.md` (include issue link if GitHub Issues)
6. Increment the "Next Bug ID" counter in `features/INDEX.md`
7. If a finding is immediately fixed in the same session, set status to Fixed/Done and close the GitHub Issue

**IMPORTANT:** Process findings sequentially — read the "Next Bug ID" counter fresh before each finding to avoid ID collisions.

### Step 4: Git Commit
```
docs(PROJ-X): Add HIG review results
```

### Step 5: Context Updates
If findings are relevant for future development, draft entries for `context/learnings.md`:
```markdown
### [HIG Finding Title]
- **Date:** YYYY-MM-DD
- **Feature:** PROJ-X (or "General")
- **Skill:** /hig-review
- **Learning:** [What was found and what to watch for]
- **Rationale:** Prevent this HIG violation in future features
```

Show context updates to the user for approval before writing.

## Handoff
After completion:
> "HIG review complete. [X findings: Y critical, Z high, ...]"
> If issues found: "Fix these issues, then run `/apple-build` to verify the build."
> If clear: "HIG compliance verified. Ready for `/apple-build` and `/appstore`."
