import 'package:flutter/material.dart';

class TextPaginator {
  final String text;
  final TextStyle textStyle;
  final Size pageSize;

  TextPaginator({
    required this.text,
    required this.textStyle,
    required this.pageSize,
  });

  List<String> paginate() {
    final List<String> pages = [];
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    String remainingText = text;

    while (remainingText.isNotEmpty) {
      textPainter.text = TextSpan(text: remainingText, style: textStyle);
      textPainter.layout(maxWidth: pageSize.width);

      int endIndex = textPainter
          .getPositionForOffset(
            Offset(pageSize.width, pageSize.height),
          )
          .offset;

      // If all the text fits on the page
      if (endIndex >= remainingText.length) {
        pages.add(remainingText.trim());
        break;
      }

      // We are looking for a space to avoid splitting the word in half
      int lastSpace = remainingText.lastIndexOf(' ', endIndex);

      // If there is no space, either the word is too long or there is only one word left
      if (lastSpace == -1 || lastSpace == 0) {
        lastSpace = endIndex; // Must use full endIndex
      }

      pages.add(remainingText.substring(0, lastSpace).trim());
      remainingText = remainingText.substring(lastSpace).trim();
    }

    return pages;
  }
}
