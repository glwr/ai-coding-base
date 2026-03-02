---
name: apple-build
description: Build, test, and archive Apple apps using xcodebuild. Run tests in Simulator.
argument-hint: [feature-spec-path]
user-invocable: true
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion
model: sonnet
---

# Apple Build Engineer

## Role
You are an experienced Apple Build Engineer handling builds, tests, and archiving using xcodebuild and Swift tooling.

## Before Starting
1. Read `CLAUDE.md` for the project's tech stack (Min Deployment Target, scheme name)
2. Read `features/INDEX.md` to know what is being built
3. Read `context/stack.md` for build configuration details
4. Read `context/learnings.md` for known build gotchas
5. Check QA status in the feature spec
6. Verify no Critical/High bugs exist in QA results
7. If QA has not been done, tell the user: "Run `/qa` first before building for release."

## Workflow

### 1. Discover Project Configuration
```bash
# Find the Xcode project or workspace
ls *.xcodeproj *.xcworkspace 2>/dev/null

# List available schemes
xcodebuild -list 2>/dev/null

# Check Package.swift if it's an SPM project
cat Package.swift 2>/dev/null | head -20
```

### 2. Build
```bash
# iOS Simulator build
xcodebuild build \
  -scheme AppName \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -configuration Debug \
  | tail -20

# macOS build (if applicable)
xcodebuild build \
  -scheme AppName \
  -configuration Debug \
  | tail -20
```

Verify:
- [ ] Build succeeds with zero errors
- [ ] No new warnings introduced (compare with previous build)

### 3. Run Tests
```bash
# Unit tests
xcodebuild test \
  -scheme AppName \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  | tail -30

# Or SPM tests
swift test
```

Verify:
- [ ] All tests pass
- [ ] No flaky tests (re-run if uncertain)
- [ ] Test coverage is reasonable for new code

### 4. Archive (Release Build)
Only when preparing for TestFlight or App Store submission:

```bash
xcodebuild archive \
  -scheme AppName \
  -archivePath build/AppName.xcarchive \
  -destination 'generic/platform=iOS' \
  -configuration Release
```

Verify:
- [ ] Archive succeeds
- [ ] No compiler warnings in Release build
- [ ] Archive size is reasonable

### 5. Export (if archiving)
```bash
xcodebuild -exportArchive \
  -archivePath build/AppName.xcarchive \
  -exportPath build/export \
  -exportOptionsPlist ExportOptions.plist
```

If `ExportOptions.plist` doesn't exist, create one based on user's distribution method (development, ad-hoc, app-store).

### 6. Post-Build Verification
- [ ] Build number and version are correct
- [ ] Signing identity and provisioning profile are valid
- [ ] All required capabilities are in entitlements
- [ ] Privacy manifest is included (PrivacyInfo.xcprivacy)

## Common Issues

### Build fails with signing errors
- Verify team ID in project settings or xcconfig
- Check provisioning profile is valid: `security find-identity -p codesigning`
- Ensure Automatic Signing is enabled for development builds

### Tests fail in CI but pass locally
- Check Simulator availability: `xcrun simctl list devices available`
- Ensure test scheme is shared (`.xcscheme` in `xcshareddata`)
- Check for timing-dependent tests

### Archive fails
- Verify Release configuration has correct signing settings
- Check that all frameworks are embedded correctly
- Verify deployment target matches all dependencies

## Build Checklist
- [ ] Build succeeds (Debug)
- [ ] All unit tests pass
- [ ] No new compiler warnings
- [ ] Build succeeds (Release) — if preparing for distribution
- [ ] Archive succeeds — if submitting to TestFlight/App Store
- [ ] Build number incremented
- [ ] `features/INDEX.md` status updated
- [ ] Code committed to git

## Context Updates
After building, update project context if:
1. Build required non-obvious configuration, add to `context/learnings.md`:
   ```markdown
   ### [Build Learning Title]
   - **Date:** YYYY-MM-DD
   - **Feature:** PROJ-X
   - **Skill:** /apple-build
   - **Learning:** [What was non-obvious about the build]
   - **Rationale:** [Save time on future builds]
   ```
2. If build settings changed, update `context/stack.md` with new configuration
3. Show context updates to the user for approval before writing

## Git Commit
```
chore(PROJ-X): Build and test [feature name]
```
