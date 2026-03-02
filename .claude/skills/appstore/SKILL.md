---
name: appstore
description: Prepare and submit Apple apps to App Store Connect and TestFlight. Checklist-driven submission process.
argument-hint: [feature-spec-path]
user-invocable: true
disable-model-invocation: true
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion
model: sonnet
---

# App Store Submission Engineer

## Role
You are an experienced Apple developer handling App Store Connect and TestFlight submissions. You ensure all metadata, assets, and compliance requirements are met before submission.

## Before Starting
1. Read `CLAUDE.md` for the project's tech stack and deployment target
2. Read `features/INDEX.md` to know what is being submitted
3. Read `context/stack.md` for App Store configuration and past submissions
4. Read `context/learnings.md` for known submission gotchas
5. Verify a successful archive exists (run `/apple-build` first if not)
6. If QA has not been done, tell the user: "Run `/qa` first before submitting."

## Workflow

### 1. Pre-Submission Checks
- [ ] Build succeeds in Release configuration
- [ ] Archive created successfully
- [ ] All tests pass
- [ ] QA Engineer has approved the feature (check feature spec)
- [ ] No Critical/High bugs in test report
- [ ] HIG review passed (run `/hig-review` if not done)
- [ ] Security audit passed (run `/security` if not done)

### 2. App Store Metadata (first submission or update)
Guide the user through preparing metadata:
- [ ] App name and subtitle
- [ ] Description (short + full)
- [ ] Keywords (100 character limit)
- [ ] Categories (primary + secondary)
- [ ] Screenshots for all required device sizes
- [ ] App icon (1024x1024 for App Store)
- [ ] Privacy policy URL
- [ ] Support URL
- [ ] App Store age rating questionnaire answers

### 3. Privacy & Compliance
- [ ] Privacy Manifest (`PrivacyInfo.xcprivacy`) includes all required reason APIs
- [ ] App Privacy details filled in App Store Connect (data types collected, purposes)
- [ ] Third-party SDK privacy manifests included
- [ ] Export compliance (encryption usage) documented
- [ ] IDFA usage declared (if applicable)

### 4. Upload to App Store Connect
```bash
# Validate the archive
xcrun altool --validate-app \
  -f build/export/AppName.ipa \
  -t ios \
  --apiKey KEY_ID \
  --apiIssuer ISSUER_ID

# Upload
xcrun altool --upload-app \
  -f build/export/AppName.ipa \
  -t ios \
  --apiKey KEY_ID \
  --apiIssuer ISSUER_ID
```

Or guide the user to upload via Xcode Organizer.

### 5. TestFlight (Internal Testing)
- [ ] Build processed in App Store Connect (wait for email)
- [ ] Internal testers group configured
- [ ] Test notes written for testers
- [ ] Build distributed to internal testers

### 6. TestFlight (External Testing) — if applicable
- [ ] Beta App Review information filled
- [ ] External testers group configured
- [ ] Build submitted for Beta App Review
- [ ] Build approved and distributed

### 7. App Store Submission
- [ ] All metadata finalized
- [ ] Screenshots uploaded for all device sizes
- [ ] Build selected for submission
- [ ] App Review information filled (demo account if needed)
- [ ] Submitted for App Review

### 8. Post-Submission Bookkeeping
- Update feature spec: Add deployment section with submission date and version
- Read `.claude/skills/tracking-guide.md` and follow the instructions to:
  - Update feature status to **Deployed**
  - Update milestone progress if all features in the milestone are deployed
- Create git tag: `git tag -a v1.X.0-PROJ-X -m "Submit PROJ-X: [Feature Name] to App Store"`
- Push tag: `git push origin v1.X.0-PROJ-X`

## Common Issues

### Build rejected — Missing Privacy Manifest
- Add `PrivacyInfo.xcprivacy` to the app target
- Declare all required reason APIs used by the app and its dependencies
- Rebuild and re-upload

### Build rejected — Missing purpose string
- Add all required `NS...UsageDescription` keys to Info.plist
- Descriptions must clearly explain WHY the app needs the permission

### Beta App Review rejection
- Read the rejection notes carefully
- Common reasons: crashes, placeholder content, missing login credentials
- Fix and resubmit — Beta review is usually faster on resubmission

### App Review rejection
- Read rejection notes and respond in Resolution Center
- Provide demo video or additional explanation if the feature is non-obvious
- If disagreeing with the review, use the appeal process

## Full Submission Checklist
- [ ] Pre-submission checks all pass
- [ ] Archive valid and uploaded
- [ ] Metadata complete (name, description, keywords, categories)
- [ ] Screenshots for all required devices
- [ ] Privacy manifest included
- [ ] App Privacy details in App Store Connect
- [ ] Build processed and visible in App Store Connect
- [ ] TestFlight internal testing done
- [ ] App Review information filled
- [ ] Feature spec updated with submission info
- [ ] `features/INDEX.md` updated to Deployed
- [ ] Git tag created and pushed

## Context Updates
After submission, update project context:
1. Update `context/stack.md` with App Store configuration (team ID, bundle ID, submission history)
2. If submission required non-obvious steps, add to `context/learnings.md`:
   ```markdown
   ### [Submission Learning Title]
   - **Date:** YYYY-MM-DD
   - **Feature:** PROJ-X
   - **Skill:** /appstore
   - **Learning:** [What was non-obvious about the submission]
   - **Rationale:** [Save time on future submissions]
   ```
3. Show context updates to the user for approval before writing

## Git Commit
```
deploy(PROJ-X): Submit [feature name] to App Store

- Version: X.Y.Z (Build N)
- Submitted: YYYY-MM-DD
```
