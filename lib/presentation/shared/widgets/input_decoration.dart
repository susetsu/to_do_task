import 'package:flutter/material.dart';

InputDecoration inputDecoration(
    {required text, String? hintText, Widget? suffixIcon}) {
  return InputDecoration(
    suffixIcon: suffixIcon,
    labelText: text,
    hintText: hintText,
    errorMaxLines: 1, // Limita el número de líneas para el error
    errorStyle: const TextStyle(
      fontFamily: 'RedHatDisplay',
      decoration: TextDecoration.none,
      // Define el estilo del texto de error
      color: Colors.red, // Color del texto de error
      fontSize: 14.0, // Tamaño de fuente del texto de error
      fontStyle: FontStyle.normal, // Estilo de fuente del texto de error
      fontWeight: FontWeight.bold, // Peso de fuente del texto de error
    ),
    disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.transparent)),
    // fillColor: Colors.blue,
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.white, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      // Define el borde de error

      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.white, width: 0.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.white, width: 0.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.white, width: 0.0),
    ),
  );
}
