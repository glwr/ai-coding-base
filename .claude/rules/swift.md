---
paths:
  - "**/*.swift"
  - "Sources/**/*"
  - "Tests/**/*"
---

# Swift & SwiftUI Development Rules

## Code Style
- Follow Swift API Design Guidelines (clarity at the point of use)
- Use `let` over `var` whenever possible (prefer immutability)
- Use Swift's type inference — don't annotate types the compiler can infer
- Use trailing closure syntax for the last closure parameter
- Use guard for early exits, not nested if-else
- Use `async/await` over completion handlers for new code

## SwiftUI Standards
- Use `@State` for view-local state, `@Binding` for parent-owned state
- Use `@Observable` (Observation framework) for shared state (iOS 17+) — prefer over `ObservableObject`
- Use `@Environment` for dependency injection and system values
- Keep views small — extract subviews when a view body exceeds ~30 lines
- Use `ViewModifier` for reusable style combinations
- Use `PreviewProvider` or `#Preview` macro for all views
- Prefer `NavigationStack` over deprecated `NavigationView`

## Architecture
- Follow the architecture pattern defined in `docs/architecture.md` (MVVM, TCA, or as specified)
- Keep business logic out of views — use ViewModels or dedicated model types
- Use Swift's `Codable` for all data serialization
- Use `Result` type or `async throws` for error handling — no force unwraps in production code
- Group files by feature, not by type (e.g., `Features/Profile/` not `ViewModels/ProfileVM`)

## Data & Networking
- Use `URLSession` with `async/await` for networking
- Use SwiftData or Core Data as specified in `docs/architecture.md`
- Never store secrets in code — use Keychain for sensitive data
- Validate all external data before use (API responses, user input)

## Testing
- Write unit tests for all business logic (ViewModels, services, utilities)
- Use Swift Testing framework (`@Test`, `#expect`) for new tests (preferred over XCTest)
- Use `@MainActor` annotation where needed for UI-bound code
- Mock dependencies using protocols — don't test against live services

## Performance
- Use `LazyVStack` / `LazyHGrid` for large scrollable lists
- Avoid unnecessary state changes that trigger view redraws
- Use `.task` modifier for async work tied to view lifecycle
- Profile with Instruments before optimizing

## Accessibility
- Add `.accessibilityLabel()` to all interactive elements without visible text
- Support Dynamic Type — never use fixed font sizes
- Support VoiceOver navigation order with `.accessibilityElement(children:)`
- Test with VoiceOver enabled in Simulator
