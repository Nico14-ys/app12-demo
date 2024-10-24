import 'package:flutter/material.dart';

// Class of revision mode with a name,
// and the first page it should jump to when selected.
class RevMode {
  final String mode;
  final Widget firstPage;

  RevMode({
    required this.mode,
    required this.firstPage,
  });
}
