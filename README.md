<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

A lightweight Flutter plugin to download any file (image, video, etc.) from a URL and save it directly to the gallery, with real-time progress updates and permission handling.

✨ Features
✅ Downloads files with progress feedback

🖼️ Saves images/videos to the gallery

📱 Handles Android & iOS permissions automatically

⚙️ Customizable progress callback

🔐 Supports Android 13+ scoped storage

🚀 Getting Started
Prerequisites
Flutter SDK 3.10 or higher

Android SDK 21+

iOS 11.0 or higher

Add Dependency
In your pubspec.yaml:

yaml
Copy
Edit
dependencies:
gallery_downloader: ^1.0.0
Then run:

bash
Copy
Edit
flutter pub get
📦 Usage
Example
dart
Copy
Edit
final result = await GalleryDownloader.downloadAndSaveToGallery(
fileUrl: 'https://example.com/sample.jpg',
onReceiveProgress: (received, total) {
double progress = received / total * 100;
print('Downloading: ${progress.toStringAsFixed(0)}%');
},
);

if (result['success']) {
print('File saved at: ${result['filePath']}');
} else {
print('Error: ${result['message']}');
}
🔧 You can find a full example in the example/ folder.

🔐 Permissions
This plugin automatically handles permission requests using permission_handler:

On Android 13+, no storage permission is needed

On Android ≤ 12, storage permission is requested

On iOS, no extra permission is required

Make sure to update your AndroidManifest.xml:

xml
Copy
Edit
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
android:maxSdkVersion="28"/>
And also configure minSdkVersion in android/app/build.gradle:

gradle
Copy
Edit
defaultConfig {
minSdkVersion 21
}
📚 Additional Information
🔗 GitHub Repository: View on GitHub

🐞 Found a bug? Submit an issue

❤️ Contributions are welcome! Submit PRs or open issues.

🛠 Maintained by [yourusername]
