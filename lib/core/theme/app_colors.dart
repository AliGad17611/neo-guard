import 'package:flutter/material.dart';

class AppColors {
  // Background gradients
  static const backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF312E81), // indigo-950
      Color(0xFF581C87), // purple-950
      Color(0xFF1E3A8A), // blue-950
    ],
  );

  // Primary colors
  static const purple200 = Color(0xFFDDD6FE);
  static const purple300 = Color(0xFFC4B5FD);
  static const purple400 = Color(0xFFA78BFA);
  static const purple500 = Color(0xFF8B5CF6);
  static const purple600 = Color(0xFF7C3AED);
  static const purple700 = Color(0xFF6D28D9);
  static const purple800 = Color(0xFF5B21B6);
  static const purple900 = Color(0xFF4C1D95);
  
  static const blue200 = Color(0xFFBFDBFE);
  static const blue300 = Color(0xFF93C5FD);
  static const blue400 = Color(0xFF60A5FA);
  static const blue500 = Color(0xFF3B82F6);
  static const blue600 = Color(0xFF2563EB);
  static const blue800 = Color(0xFF1E40AF);
  static const blue900 = Color(0xFF1E3A8A);
  static const blue950 = Color(0xFF172554);
  
  static const indigo400 = Color(0xFF818CF8);
  static const indigo600 = Color(0xFF4F46E5);
  static const indigo800 = Color(0xFF3730A3);

  static const green400 = Color(0xFF4ADE80);
  static const green950 = Color(0xFF052E16);
  
  // Status colors
  static const red200 = Color(0xFFFECACA);
  static const red300 = Color(0xFFFCA5A5);
  static const red400 = Color(0xFFF87171);
  static const red500 = Color(0xFFEF4444);
  static const red600 = Color(0xFFDC2626);
  static const red800 = Color(0xFF991B1B);
  
  static const orange500 = Color(0xFFF97316);
  static const yellow200 = Color(0xFFFEF08A);
  static const yellow400 = Color(0xFFFBBF24);

  // Severity gradients
  static const extinctionGradient = LinearGradient(
    colors: [Color(0xFFDC2626), Color(0xFF991B1B)],
  );
  
  static const regionalGradient = LinearGradient(
    colors: [Color(0xFFEA580C), Color(0xFFDC2626)],
  );
  
  static const majorGradient = LinearGradient(
    colors: [Color(0xFFCA8A04), Color(0xFFEA580C)],
  );
  
  static const cityGradient = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
  );
  
  static const localGradient = LinearGradient(
    colors: [Color(0xFF059669), Color(0xFF2563EB)],
  );
}