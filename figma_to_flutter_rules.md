# Antigravity Rules: Figma to Flutter (Clean Architecture)

These rules define the standard operating procedure for Antigravity when translating Figma designs into Flutter code within this project.

## 1. Figma Integration Workflow (MCP)
- **Get the Design:** ALWAYS use the `mcp_figma-dev-mode-mcp-server_get_design_context` tool with the Figma `nodeId` provided by the USER. Provide `clientFrameworks: "flutter"` and `clientLanguages: "dart"`.
- **Analyze Metadata:** Pay attention to colors, typography, sizing, shadow, and corner radius metadata returned by the tool.
- **Visual Validation:** If you need a visual reference, use the `get_screenshot` tool from the MCP server to see exactly what the node looks like.
- **Image Assets:** Can download/export images from the design if necessary and save them to an `assets/images/` or `assets/vectors/` resource folder in the app.
- **Accuracy First:** The Flutter design implementation MUST be completely accurate visually to the Figma design.
- **Screen Flow Analysis:** ALWAYS check for what screen connects to which other screen to understand the user flow before coding. If the connections aren't explicitly linked, check which screen is next to it (from left to right) to intuitively grasp the flow. Pay attention to screens that might share the same endpoint or destination.
- **Rule Verification:** After checking the Figma design payload, you MUST cross-reference the planned Flutter implementation with these rules (`figma_to_flutter_rules.md`) to ensure full compliance with coding standards and overflow prevention rules.

## 2. Directory Structure (Clean Architecture)
When adding new features or converting designs, adhere to the Clean Architecture layout:
```text
lib/
├── core/
│   ├── theme/             # Tokens, Colors, TextStyles, Spacing
│   ├── errors/            # Failure models, Exceptions
│   └── utils/             # Extensions, formatters, constants
├── features/
│   └── [feature_name]/
│       ├── data/          # Models, Repositories Impl, Data Sources
│       ├── domain/        # Entities, Repositories Interfaces, UseCases
│       └── presentation/
│           ├── pages/     # Complete screens
│           ├── widgets/   # Feature-specific reusable widgets
│           └── bloc/      # BLoC State Management (events, states, blocs)
└── main.dart
```

## 3. State Management (BLoC)
- **Library:** Use `flutter_bloc` for all complex state management.
- **Separation of Concerns:** Keep business logic strictly inside the `Bloc` / `Cubit`. The UI should only dispatch events and react to states.
- **Immutability:** Define clear, immutable states and events. Use the `equatable` package for efficient state comparison.
- **UI Integration:** Use `BlocBuilder` for rebuilding the UI, `BlocListener` for one-off side effects (snackbars, dialogs, navigation), and `BlocConsumer` when both are needed.

## 4. Design System & Repeatable Components
- **Extract Tokens:** Never hardcode HEX colors, padding constants, or font sizes in UI files.
  - *Colors:* Define in `lib/core/theme/app_colors.dart`.
  - *Typography:* Define in `lib/core/theme/app_text_styles.dart`.
  - *Spacing:* Define in `lib/core/theme/app_spacing.dart` (e.g., `static const double sm = 8.0;`).
- **Reusable Components:** If a Figma component is marked as a master component (or looks like a generic button, text field, or card), create it in `features/presentation/widgets/` or `core/presentation/widgets/`.
- **Component Anatomy:** Isolate stateless presentation logic. Expose parameters (`onTap`, `text`, `isLoading`) so the component remains completely independent of business logic.

## 5. Size & Responsiveness
- **Fluid Layouts:** Favor dynamic sizing over fixed width/heights.
- **Constraints over Sizes:** Use `BoxConstraints`, `Expanded`, `Flexible`, and `FractionallySizedBox` instead of hardcoded `width` and `height`.
- **Screen Sizing:** Avoid hardcoding specific screen dimensions. If a fixed size is necessary from Figma, evaluate if it should scale using tools like `MediaQuery` or standard calculations.
- **Padding:** Use `EdgeInsets.symmetric` or `EdgeInsets.all` linked to the `app_spacing.dart` file.

## 6. Defense Against Display Errors (Overflow Prevention)
- **Text Wrapping:** NEVER place a `Text` widget with unbounded width inside a `Row` without wrapping it in an `Expanded` or `Flexible` widget to prevent `RenderFlex overflow`.
- **Scrollable Containers:** For screens that may exceed the display height, ALWAYS wrap the main layout in a `SingleChildScrollView` or use `ListView/Sliver` equivalents.
- **Overflow Avoidance Checklist for generation:**
  - Are lists bounded? (Use `shrinkWrap: true` or wrap in `Expanded` inside a `Column`).
  - Are Rows constrained? (Wrap texts in `Flexible`).
  - Does the entire screen handle bottom overflow? (Use `SafeArea` + `SingleChildScrollView`).

## 7. Auto-Fix Workflow
- **When an Error is Reported:**
  1. Pinpoint the widget tree causing the unbounded constraint.
  2. Propose a targeted fix using `Flexible`, `Expanded`, changing `mainAxisSize`, or adding `SingleChildScrollView`.
  3. Perform the fix using file editing tools directly.
- **Validate:** Ensure the fix doesn't inadvertently break sibling layouts.

## 8. Demo / Mock Data (No Backend Required)
- **This project is for UI/UX demonstration only.** No real backend, API calls, or database connections are needed or should be implemented.
- **All data must be mocked:** Use hardcoded lists, fake delays (`Future.delayed`), and mock success/error responses to simulate real interactions.
- **BLoC logic stays mock-only:** Blocs should simulate state transitions (loading → success/error) without any actual network or database code.
- **No HTTP packages:** Do NOT add `http`, `dio`, or any network client packages. Do NOT add Firebase or any backend SDK.
- **Navigation always succeeds:** For demo flows, assume all form submissions and OTP verifications succeed (mock success path) unless explicitly asked to demo an error state.
