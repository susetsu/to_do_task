import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

 class ToastWidget {
  Timer? _timer;

  showMessage({required String text, required Color color, bool? long}) {
    final active = _timer?.isActive;
    if (active != null) return;
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 200), () {
      // Si no se toca tres veces en menos de 2 segundos, reinicia el contador
      Fluttertoast.showToast(
        msg: text,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: const Color.fromARGB(255, 255, 255, 255),
        fontSize: 16.0,
        toastLength: long == true ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      );
    });
  }
}
