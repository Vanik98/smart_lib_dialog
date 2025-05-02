# 📦 smart_lib_dialog

A smart, highly customizable dialog library for Flutter that allows **showing dialogs and loading indicators from anywhere** in your app — even **without a `BuildContext`**. Supports **custom styling**, **auto-dismiss**, and **global status callbacks**.

---

## ✨ Features

- **📦 Global Access**: Open dialogs from services, viewmodels, or utility classes (no `BuildContext` required).
- **⚡ Simple API**: Clean methods like `showDialog()` and `showLoading()` for quick usage.
- **🎨 Deep Customization**: Customize colors, fonts, buttons, icons, borders, and more via `SmartDialogParams` and `SmartLoadingParams`.
- **✅ Button Support**: Add **positive/negative buttons** with custom text styles and button styles.
- **⏱ Auto-Dismiss**: Automatically close dialogs/loading after a set duration.
- **🧩 Custom Widgets**: Inject custom UI components into dialogs.
- **🧠 No Boilerplate**: Smart internal handling — just call the method and go!
- **🧱 Lightweight**: Minimal dependencies and easy to extend.

---

## 🚀 Getting Started

### 1. Add Dependency

Add the library to your `pubspec.yaml`:

```yaml
dependencies:
  smart_lib_dialog: ^0.1.0 # Replace with latest version
```

Run `flutter pub get` to install.

---

### 2. Initialize in Your App

Wrap your app with `SmartDialogManager` in `MaterialApp`:

```dart
import 'package:smart_lib_dialog/smart_dialog_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: SmartDialogManager.init(), // Enables global dialogs
      home: YourHomePage(),
    );
  }
}
```

**Optional Initialization Parameters**:
- Set default styles for all dialogs/loading modals:
```dart
builder: SmartDialogManager.init(
  smartDialogParams: SmartDialogParams(
    backgroundColor: Colors.white,
    borderColor: Colors.grey.withOpacity(0.3),
    titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    descriptionTextStyle: const TextStyle(fontSize: 14, color: Colors.black87),
  ),
  smartLoadingParams: SmartLoadingParams(
    backgroundColor: Colors.black.withOpacity(0.6),
    icon: const Icon(Icons.refresh, color: Colors.white),
  ),
),
```

---

## 📚 Usage Examples

### Example 1: Show a Loading Dialog

```dart
SmartDialogManager.showLoading(); // Default style
```

**Customize Loading Style**:
```dart
SmartDialogManager.showLoading(
  params: SmartLoadingParams(
    backgroundColor: Colors.deepPurple.withOpacity(0.7),
    icon: const Icon(Icons.hourglass_bottom, color: Colors.white),
  ),
);
```

**Auto-Dismiss After 3 Seconds**:
```dart
SmartDialogManager.showLoading(duration: const Duration(seconds: 3));
```

**Dismiss Manually**:
```dart
SmartDialogManager.dismiss();
```

---

### Example 2: Show a Custom Dialog

```dart
SmartDialogManager.showDialog(
  params: SmartDialogParams(
    title: "Confirm Action",
    description: "Are you sure you want to proceed?",
    positiveButtonText: "Yes",
    negativeButtonText: "No",
    onPositiveButtonPressed: () {
      // Handle "Yes" tap
      SmartDialogManager.dismiss();
    },
    onNegativeButtonPressed: () {
      // Handle "No" tap
      SmartDialogManager.dismiss();
    },
    onOnClose: () {
      // Optional: Handle dialog closure (e.g., tap outside)
    },
  ),
);
```

**Customize Dialog Appearance**:
```dart
SmartDialogManager.showDialog(
  params: SmartDialogParams(
    backgroundColor: Colors.white.withOpacity(0.95),
    borderColor: Colors.grey.shade300,
    foregroundColor: Colors.deepPurple,
    title: "Advanced Dialog",
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
    descriptionTextStyle: const TextStyle(
      fontSize: 15,
      color: Colors.black87,
    ),
    positiveButtonTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    positiveButtonStyle: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
    ),
    negativeButtonTextStyle: const TextStyle(
      color: Colors.deepPurple,
    ),
    onPositiveButtonPressed: () => SmartDialogManager.dismiss(),
    onNegativeButtonPressed: () => SmartDialogManager.dismiss(),
  ),
);
```

**Auto-Dismiss After 5 Seconds**:
```dart
SmartDialogManager.showDialog(
  duration: const Duration(seconds: 5),
  params: SmartDialogParams(...),
);
```

---

### Example 3: Use a Custom Widget in a Dialog

```dart
SmartDialogManager.showDialog(
  params: SmartDialogParams(
    customWidget: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Custom Content"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: SmartDialogManager.dismiss,
            child: const Text("Close"),
          ),
        ],
      ),
    ),
  ),
);
```

---

## 🛠️ SmartDialogParams Reference

| Parameter | Description |
|---------|-------------|
| `backgroundColor` | Background color of the dialog. |
| `foregroundColor` | Foreground/text color. |
| `borderColor` | Border color (if applicable). |
| `title` | Optional title text. |
| `titleTextStyle` | Custom style for the title. |
| `closeIconColor` | Color of the close icon (if shown). |
| `description` | Main content message (required). |
| `descriptionTextStyle` | Custom style for the description. |
| `positiveButtonText` | Label for the primary action (e.g., "OK"). |
| `positiveButtonTextStyle` | Custom style for the positive button text. |
| `positiveButtonStyle` | Full button style for the positive button. |
| `negativeButtonText` | Optional label for secondary action (e.g., "Cancel"). |
| `negativeButtonTextStyle` | Custom style for the negative button text. |
| `negativeButtonStyle` | Full button style for the negative button. |
| `onPositiveButtonPressed` | Callback for positive button press. |
| `onNegativeButtonPressed` | Callback for negative button press. |
| `onOutClick` | Callback when clicking outside the dialog (set `isClosable = false` to disable). |
| `onOnClose` | Optional callback when dialog is closed (e.g., back press or tap outside). |
| `customWidget` | Custom widget to display instead of the default content. |

---

## 🛠️ SmartLoadingParams Reference

| Parameter | Description |
|---------|-------------|
| `icon` | Custom loading icon (default: spinner). |
| `backgroundColor` | Background color of the loading overlay. |

---

## 🧠 Under the Hood

- **Singleton Pattern**: `SmartDialogManager` is a static singleton for global access.
- **Overlay-Based**: Uses Flutter’s `Overlay` to display dialogs independently of navigation.
- **Mixins**:
    - `OverlayMixin`: Handles overlay widget updates.
    - `StatusCallbackMixin`: Notifies listeners of dialog status changes (e.g., shown/dismissed).
    - `TimerMixin`: Supports auto-dismiss via `Duration`.
- **No Context Required**: Perfect for business logic layers (e.g., repositories, services).

---

## 🎯 Key Advantages

| Feature | Benefit |
|--------|---------|
| **No `BuildContext` Needed** | Show dialogs from anywhere in your codebase. |
| **Clean API** | Reduce boilerplate for common dialog types. |
| **Full Customization** | Tailor every visual aspect of dialogs and loading modals. |
| **Auto-Dismiss** | Close dialogs automatically after a set time. |
| **Lightweight** | Minimal dependencies and easy to extend. |

---

## 💡 Use Cases

- **Loading States**: Show spinners during API calls.
- **Confirmations**: Ask users to confirm actions (e.g., "Delete file?").
- **Error Handling**: Display global error messages.
- **Notifications**: Show alerts without disrupting navigation.
- **Custom Workflows**: Inject dynamic UI components into dialogs.

---

## 🧩 Extending the Library

- **Add New Dialog Types**: Extend `SmartDialogManager` with methods like `showSuccess()` or `showError()`.
- **Custom Themes**: Create reusable `SmartDialogParams` for consistent styling across your app.
- **Status Listeners**: Use `StatusCallbackMixin` to track dialog lifecycle events.
- **Advanced Widgets**: Build complex UIs with `customWidget`.

---

## 📦 Contributing & Feedback

Contributions are welcome! For feature requests, bugs, or improvements, [open an issue](https://github.com/vanik98/smart_lib_dialog/issues) or submit a PR.

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.

---

**Made with ❤️ for Flutter developers who value simplicity, flexibility, and scalability.**