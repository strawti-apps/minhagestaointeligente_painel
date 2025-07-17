import 'package:flutter/material.dart';

/// Utility para tornar ternários mais limpos na view
T ternaryClean<T>({
  required bool condition,
  required T caseTrue,
  required T caseFalse,
}) {
  return condition ? caseTrue : caseFalse;
}

/// Utility para ternários com widgets
Widget ternaryWidget(bool condition, Widget ifTrue, Widget ifFalse) {
  return condition ? ifTrue : ifFalse;
}

/// Utility para ternários com strings
String ternaryString(bool condition, String ifTrue, String ifFalse) {
  return condition ? ifTrue : ifFalse;
}

/// Utility para ternários com cores
Color ternaryColor(bool condition, Color ifTrue, Color ifFalse) {
  return condition ? ifTrue : ifFalse;
}
