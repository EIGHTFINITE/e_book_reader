import 'package:flutter/material.dart';

class ReaderConfig {
  Axis axis;
  TextAlign textAlign;
  TextStyle textStyle;
  EdgeInsets padding;
  Color? backgroundColor;

  ReaderConfig({
    this.axis = Axis.horizontal,
    this.textAlign = TextAlign.start,
    this.textStyle = const TextStyle(
      color: Colors.black,
    ),
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor = Colors.white,
  });

  factory ReaderConfig.fromJson(Map<String, dynamic> json) {
    return ReaderConfig(
      axis: Axis.values[json["axis"] as int],
      textAlign: TextAlign.values[json["textAlign"] as int],
      textStyle: json["textStyle"],
      padding: EdgeInsets.fromLTRB(
        json["padding"]["left"],
        json["padding"]["top"],
        json["padding"]["right"],
        json["padding"]["bottom"],
      ),
      backgroundColor: json["backgroundColor"] == null
          ? null
          : Color(json["backgroundColor"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "axis": axis.index,
      "textAlign": textAlign.index,
      "textStyle": textStyle,
      "padding": {
        "left": padding.left,
        "top": padding.top,
        "right": padding.right,
        "bottom": padding.bottom,
      },
      "backgroundColor": backgroundColor?.toARGB32(),
    };
  }

  ReaderConfig copyWith({
    Axis? axis,
    TextAlign? textAlign,
    TextStyle? textStyle,
    EdgeInsets? padding,
    Color? backgroundColor,
  }) {
    return ReaderConfig(
      axis: axis ?? this.axis,
      textAlign: textAlign ?? this.textAlign,
      textStyle: textStyle ?? this.textStyle,
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
