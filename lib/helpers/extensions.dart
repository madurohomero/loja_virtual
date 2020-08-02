import 'package:flutter/material.dart';

extension Eccus on TimeOfDay {
  String formatado() {
    return '${hour}h${minute.toString().padLeft(2, '0')}';
  }

  int minutos() => hour * 60 + minute;
}
