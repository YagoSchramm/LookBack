import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const _darkBackground = Color(0xFF090B14);
  static const _darkSurface = Color(0xFF111827);
  static const _darkSurfaceAlt = Color(0xFF1A2338);

  static const _darkPrimary = Color(0xFF7C8CFF);
  static const _darkPrimaryContainer = Color(0xFF2D3D73);

  static const _darkSecondary = Color(0xFF8CB8FF);

  static const _darkOnBackground = Color(0xFFF3F6FF);
  static const _darkTextSecondary = Color(0xFFA4B0C8);

  static const _darkDivider = Color(0xFF27324A);

  static const _darkError = Color(0xFFFF7A8C);

  static const _lightBackground = Color(0xFFF7F9FC);
  static const _lightSurface = Color(0xFFFFFFFF);
  static const _lightSurfaceAlt = Color(0xFFF0F4FA);

  static const _lightPrimary = Color(0xFF536DFE);
  static const _lightPrimaryContainer = Color(0xFFDDE5FF);

  static const _lightSecondary = Color(0xFF6C9DFF);

  static const _lightOnBackground = Color(0xFF1B2333);
  static const _lightTextSecondary = Color(0xFF6D7892);

  static const _lightDivider = Color(0xFFE2E8F4);

  static const _lightError = Color(0xFFD64A63);

  static const waveformActive = Color(0xFF8CB8FF);
  static const waveformInactive = Color(0x338CB8FF);

  static const glowGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5D73FF), Color(0xFF9CC9FF)],
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
      onPrimary: Colors.white,
      primaryContainer: _lightPrimaryContainer,
      onPrimaryContainer: _lightOnBackground,
      secondary: _lightSecondary,
      onSecondary: Colors.white,
      surface: _lightSurface,
      onSurface: _lightOnBackground,
      error: _lightError,
      onError: Colors.white,
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
      onPrimary: Color(0xFF090B14),
      primaryContainer: _darkPrimaryContainer,
      onPrimaryContainer: Colors.white,
      secondary: _darkSecondary,
      onSecondary: Color(0xFF090B14),
      surface: _darkSurface,
      onSurface: _darkOnBackground,
      error: _darkError,
      onError: Color(0xFF090B14),
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
    // Campo de texto quase invisível: fundo = background com um leve
    // clareamento (~3%), quase imperceptível até o usuário focar.
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
        backgroundColor: const Color(0xFF5D73FF),
        foregroundColor: Colors.white,
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