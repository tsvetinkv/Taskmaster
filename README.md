Taskmaster is an app where you can organize your day, keep track of what needs to get done, and stay on top of your tasks without the clutter. Taskmaster offers a simple, distraction-free way to manage your to-do list, built to work the same whether you're on your phone, your desktop, or in the browser.

Taskmaster provides users with the ability to:

* Create, edit, and delete tasks in a few taps;
* Keep tasks organized and easy to scan, so you always know what's next;
* Use the app on any device - Android, iOS, Windows, macOS, Linux, and the web - with one shared codebase behind all of them.

It is designed for anyone who wants a lightweight, no-fuss to-do list - no accounts, no clutter, just tasks.

## Functionalities

* Add, edit, and delete tasks
* Mark tasks as complete
* Cross-platform support (Android, iOS, Windows, macOS, Linux, Web)
* Clean, minimal interface

## How it's made

Taskmaster is built with **Flutter** and **Dart**, which is what makes it possible to ship the same app to mobile, desktop, and web from a single codebase. The UI is built with Flutter's widget system for a consistent look and feel across every platform, and the project is organized so each platform's native shell (android/, ios/, windows/, macos/, linux/, web/) sits alongside the shared Dart logic in lib/.

## Installation and Running the App

To run Taskmaster on your own machine, you'll need [Flutter](https://docs.flutter.dev/get-started/install) installed, along with the toolchain for whichever platform you want to build for (Android Studio for Android, Xcode for iOS/macOS, Visual Studio for Windows, or standard build tools for Linux).

```bash
# Clone the repository
git clone https://github.com/tsvetinkv/Taskmaster.git
cd Taskmaster

# Install dependencies
flutter pub get

# Check that everything is set up correctly
flutter doctor
```

Once dependencies are installed, list the devices available to you and run the app:

```bash
# See connected devices, simulators, and emulators
flutter devices

# Run on whichever device you'd like
flutter run
```

You can also target a specific platform directly:

```bash
flutter run -d chrome     # Web
flutter run -d windows    # Windows
flutter run -d macos      # macOS
flutter run -d linux      # Linux
```

To build a standalone release instead of running in debug mode:

```bash
flutter build apk       # Android
flutter build ios       # iOS
flutter build web       # Web
flutter build windows   # Windows
flutter build macos     # macOS
flutter build linux     # Linux
```

## Feedback

If you have any feedback, please reach out to me at [tsvetinikolova5@gmail.com].

## Built With

* [Flutter](https://flutter.dev/)
* [Dart](https://dart.dev/)
