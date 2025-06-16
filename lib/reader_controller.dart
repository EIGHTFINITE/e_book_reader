import 'dart:async';

import 'package:e_book_reader/config.dart';
import 'package:e_book_reader/config_preference.dart';
import 'package:flutter/material.dart';

typedef ReaderPositionListener = void Function();
typedef LoadingListener = Function(bool isLoading);

class ReaderController extends ValueNotifier<ReaderConfig> {
  SharedConfigPreference? _sharedConfigPrefrence;

  void setConfig(ReaderConfig config) {
    value = config;
    _sharedConfigPrefrence?.save(config);
  }

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  ChangeNotifier get scrollNotifier {
    return _pageController;
  }

  ReaderController({SharedConfigPreference? pref, ReaderConfig? config})
      : super(ReaderConfig()) {
    _sharedConfigPrefrence = pref;
    var loadData = pref?.load();
    if (loadData != null) {
      updateValue(loadData);
    } else {
      updateValue(config ?? ReaderConfig());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        notifyListeners();
      }
    });
  }

  double get scrollSize {
    return _pageController.hasClients
        ? _pageController.position.maxScrollExtent
        : 1.0;
  }

  double get scrollPosition {
    return _pageController.hasClients ? _pageController.offset : 1.0;
  }

  double get contentSize {
    return _pageController.hasClients
        ? _pageController.position.viewportDimension
        : 1.0;
  }

  int get totalPage {
    if (contentSize <= 0 || scrollSize <= 0) {
      return 1;
    }
    return (scrollSize ~/ contentSize) + 1;
  }

  int get currentPage {
    return (scrollPosition ~/ contentSize) + 1;
  }

  double get rate {
    return (scrollPosition / (scrollSize)).clamp(0, 1);
  }

  void setTextAlign(TextAlign align) {
    updateValue(value.copyWith(
      textAlign: align,
    ));
  }

  void setTextStyle(TextStyle style) {
    updateValue(value.copyWith(
      textStyle: style,
    ));
  }

  void setPadding(EdgeInsets padding) {
    updateValue(value.copyWith(
      padding: padding,
    ));
  }

  void setAxis(Axis axis) {
    updateValue(value.copyWith(
      axis: axis,
    ));
  }

  void setBackgroundColor(Color backgroundColor) {
    updateValue(
      value.copyWith(
        backgroundColor: backgroundColor,
      ),
    );
  }

  void jumpToRate(double rate) {
    var y = rate * (scrollSize - contentSize);
    _pageController.jumpTo(y);
  }

  void jumpToPage(int page) {
    if (_pageController.hasClients) {
      _pageController.jumpToPage(page);
    }
  }

  final debouncer = Debouncer(milliseconds: 100);
  void updateValue(ReaderConfig newValue) {
    value = newValue;
    setConfig(newValue);
  }

  String? _text;
  String? get text => _text;
  Future<void> load(String text) async {
    _text = text;
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
