---
paths:
  - "*.xcodeproj/**"
  - "*.xcworkspace/**"
  - "*.xctestplan"
  - "*.entitlements"
  - "*.plist"
  - "Project.swift"
  - "Package.swift"
---

# Apple Project Configuration Rules

## Xcode Project
- Never manually edit `.pbxproj` files — use `xcodebuild` or Xcode commands
- Keep the project file minimal — prefer Swift Package Manager over manual framework embedding
- Use `.xcconfig` files for build settings instead of hardcoding in project settings
- Separate Debug and Release configurations clearly

## Swift Package Manager
- Use `Package.swift` for dependency management when possible
- Pin dependencies to exact versions or minor version ranges (not major)
- Prefer Apple-maintained packages and well-established community packages
- Document why each dependency is needed in `context/decisions.md`

## Signing & Capabilities
- Use automatic signing for development
- Use `.entitlements` files to declare capabilities
- Never commit provisioning profiles or certificates to git
- Document required capabilities in `docs/development.md`

## Info.plist & Privacy
- Add usage description strings for ALL requested permissions (camera, location, photos, etc.)
- Keep usage descriptions clear and specific — explain WHY the app needs access
- Include a Privacy Manifest (`PrivacyInfo.xcprivacy`) for required reason APIs
- Review Apple's required reason API list before using covered APIs

## Build Settings
- Set minimum deployment target in `CLAUDE.md` Tech Stack section
- Enable strict concurrency checking (`SWIFT_STRICT_CONCURRENCY = complete`)
- Enable all recommended warnings
- Use `DEVELOPMENT_TEAM` from xcconfig, not hardcoded in project
