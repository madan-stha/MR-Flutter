import 'package:flutter/material.dart';

InkWell customInkwell({Widget? child, Function? onTap, Function? onLongPress}) {
  return InkWell(
    onLongPress: onLongPress as void Function()?,
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: onTap as void Function()?,
    child: child,
  );
}
