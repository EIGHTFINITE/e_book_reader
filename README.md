# E-Book Reader
![](https://raw.githubusercontent.com/emintolgahanpolat/e_book_reader/refs/heads/main/Simulator%20Screen%20Recording%20-%20iPhone%2016%20-%202025-04-12%20at%2001.25.38.gif)
## Overview
The e_book_reader package provides a versatile and customizable e-book reading interface for Flutter applications. It supports features such as page scrolling, content loading, pull-to-refresh, and extensive customization options for the reading experience.

## Features
* Customizable text styles (font size, font weight, font style, etc.)
* Adjustable reading modes (light/dark)
* Scroll position tracking
* Horizontal and vertical reading layouts
* Cover Page, Previous and next page

<h3 align="left">Support:</h3>

<p><a href="https://www.buymeacoffee.com/emintpolat"><img align="left" src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="50" width="210" alt="emintolgahanpolat" /></a></p><br><br>

## Installation
To use this package, add e_book_reader as a dependency in your pubspec.yaml file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  e_book_reader: ^1.0.0
```
Then, run flutter pub get to install the package.

### Usage
Here is a step-by-step guide to using the e_book_reader package in your Flutter application.

```dart
import 'package:e_book_reader/e_book_reader.dart';
import 'package:e_book_reader/reader_controller.dart';
import 'package:e_book_reader/reader_pull_to_refresh.dart';
```
###  Basic Setup
Create a ReaderController and configure it in your widget:

```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ReaderController _readerController = ReaderController();

  @override
  void initState() {
    _readerController.load(longText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Book Reader"),
      ),
      body: ReaderContent(
        controller: _readerController,
      ),
    );
  }
}
```


## Add Scroll Listener
```dart
@override
void initState() {
  _readerController.load(longText);
  _readerController.addScrollListener(() {
    print("Scroll Position: ${_readerController.scrollPosition}");
  });
  super.initState();
}

```

## Customizing the Reader
You can customize various aspects of the reader using the ReaderController:

```dart
_readerController.setAxis(Axis.horizontal);
_readerController.setTextStyle(TextStyle(color: Colors.black));
_readerController.setBackgroundColor(Colors.white);
_readerController.setPadding(EdgeInsets.all(16));
```

## Pull-to-Refresh
To enable pull-to-refresh functionality, wrap the ReaderContent widget with ReaderPullToRefresh:

```dart
ReaderPullToRefresh(
  onRefreshTop: () async {
    // Handle top refresh
  },
  onRefreshBottom: () async {
    // Handle bottom refresh
  },
  child: ReaderContent(
    controller: _readerController,
  ),
)
```


## API Summary


|Method|	Description|
|--|--|
|load(String text)|	Loads the e-book text content|
|setAxis(Axis axis)	|Sets the reading direction (vertical/horizontal)
|setTextAlign(TextAlign align)	|Sets the text alignment
|setTextStyle(TextStyle style)	|Sets the text style
|setPadding(EdgeInsets padding)|Sets the padding around the text
|setBackgroundColor(Color backgroundColor)	|Sets the background color
|scrollToRate(double rate)|	Scrolls to a specific position based on rate
|scrollToPosition(double position)|	Scrolls to a specific position|
|scrollToPage(int page)|	Scrolls to a specific page|
