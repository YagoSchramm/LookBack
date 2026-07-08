import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const _darkBackground = Color(0xFF121212);
  static const _darkSurface = Color(0xFF1E1E1E);
  static const _darkSurfaceAlt = Color(0xFF262626);

  static const _darkPrimary = Color(0xFF4783FB);
  static const _darkPrimaryContainer = Color(0xFF1F3A73);
  static const _darkSecondary = Color(0xFF297DD2);
  static const _darkOnBackground = Color(0xFFE0E0E0);
  static const _darkTextSecondary = Color.fromARGB(255, 127, 127, 127);
  static const _darkDivider = Color(0xFF2A2A2A);
  static const _darkError = Color(0xFFEF9A9A);

  static const _lightBackground = Color(0xFFF5F5F5);
  static const _lightSurface = Color(0xFFFFFFFF);
  static const _lightSurfaceAlt = Color(0xFFEDEDED);
  static const _lightPrimary = Color.fromARGB(255, 71, 131, 251);
  static const _lightPrimaryContainer = Color(0xFFDCE7FF);
  static const _lightSecondary = Color.fromARGB(255, 16, 9, 150);
  static const _lightOnBackground = Color(0xFF212121);
  static const _lightTextSecondary = Color.fromARGB(255, 151, 151, 151);
  static const _lightDivider = Color(0xFFE0E0E0);
  static const _lightError = Color(0xFFB71C1C);

  static const waveformActive = Color(0xFF4783FB);
  static const waveformInactive = Color(0x334783FB);

  static const glowGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4783FB), Color(0xFF297DD2)],
  );

  static const double borderRadius = 24;

  static TextTheme _textTheme(Color onBackground, Color textSecondary) {
    final display = GoogleFonts.manropeTextTheme();
    final body = GoogleFonts.interTextTheme();

    return TextTheme(
      displayLarge: display.displayLarge?.copyWith(
        fontSize: 42,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.2,
        color: onBackground,
        height: 1.1,
      ),
      displayMedium: display.displayMedium?.copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: onBackground,
        height: 1.15,
      ),
      headlineLarge: display.headlineLarge?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: onBackground,
      ),
      headlineMedium: display.headlineMedium?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: onBackground,
      ),
      titleLarge: body.titleLarge?.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: onBackground,
      ),
      titleMedium: body.titleMedium?.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: onBackground,
      ),
      bodyLarge: body.bodyLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: onBackground,
        height: 1.65,
      ),
      bodyMedium: body.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onBackground,
        height: 1.6,
      ),
      bodySmall: body.bodySmall?.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
      labelLarge: body.labelLarge?.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: onBackground,
      ),
      labelMedium: body.labelMedium?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
    );
  }

  static TextStyle mono(BuildContext context, {double fontSize = 13}) {
    final onBackground = Theme.of(context).colorScheme.onSurface;
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      color: onBackground.withOpacity(0.75),
    );
  }

  static ThemeData get light {
    final colorScheme = const ColorScheme.light(
      brightness: Brightness.light,
      primary: _lightPrimary,
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: _lightPrimaryContainer,
      onPrimaryContainer: _lightOnBackground,
      secondary: _lightSecondary,
      onSecondary: _lightTextSecondary,
      surface: _lightSurface,
      onSurface: _lightOnBackground,
      error: _lightError,
      onError: Color(0xFFFFFFFF),
      outline: _lightDivider,
    );

    return _build(
      colorScheme: colorScheme,
      background: _lightBackground,
      surfaceAlt: _lightSurfaceAlt,
      textTheme: _textTheme(_lightOnBackground, _lightTextSecondary),
      divider: _lightDivider,
    );
  }

  static ThemeData get dark {
    final colorScheme = const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: _darkPrimary,
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: _darkPrimaryContainer,
      onPrimaryContainer: Colors.white,
      secondary: _darkSecondary,
      onSecondary: _darkTextSecondary,
      surface: _darkSurface,
      onSurface: _darkOnBackground,
      error: _darkError,
      onError: Color(0xFF000000),
      outline: _darkDivider,
    );

    return _build(
      colorScheme: colorScheme,
      background: _darkBackground,
      surfaceAlt: _darkSurfaceAlt,
      textTheme: _textTheme(_darkOnBackground, _darkTextSecondary),
      divider: _darkDivider,
    );
  }

  static ThemeData _build({
    required ColorScheme colorScheme,
    required Color background,
    required Color surfaceAlt,
    required TextTheme textTheme,
    required Color divider,
  }) {
    final fieldFill = Color.alphaBlend(
      colorScheme.onSurface.withOpacity(0.03),
      background,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      textTheme: textTheme,
      dividerColor: divider,
      splashColor: colorScheme.primary.withOpacity(0.10),
      highlightColor: colorScheme.primary.withOpacity(0.06),

      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineMedium,
        surfaceTintColor: Colors.transparent,
      ),

      cardTheme: CardThemeData(
        color: surfaceAlt.withOpacity(0.92),
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: divider, width: 1),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surfaceAlt,
        labelStyle: textTheme.labelMedium,
        side: BorderSide(color: divider),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 4,
          shadowColor: colorScheme.primary.withOpacity(0.4),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: textTheme.labelLarge,
          side: BorderSide(color: colorScheme.primary, width: 1.4),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: textTheme.labelLarge,
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: fieldFill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface.withOpacity(0.45),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: divider,
        thickness: 1,
        space: 24,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.onSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: background),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: background,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.45),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}