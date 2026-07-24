import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Snackbars padronizadas do app: retângulo com borda arredondada de 8,
/// ícone de check (sucesso) ou x (erro), usando cores e tipografia do
/// [Theme.of(context)] atual.
class AppSnackBar {
  const AppSnackBar._();

  static void showSuccess(BuildContext context, String message) {
    _show(context, message: message, isSuccess: true);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message: message, isSuccess: false);
  }

  static void _show(
    BuildContext context, {
    required String message,
    required bool isSuccess,
  }) {
    final theme = Theme.of(context);

    final backgroundColor =
        isSuccess ? theme.colorScheme.primary : theme.colorScheme.error;
    final foregroundColor =
        isSuccess ? theme.colorScheme.onPrimary : theme.colorScheme.onError;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: Row(
            children: [
              Icon(
                isSuccess ? CupertinoIcons.checkmark_alt : CupertinoIcons.xmark,
                color: foregroundColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}