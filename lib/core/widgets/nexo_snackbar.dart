import 'package:flutter/material.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';

enum SnackbarType { success, error, info }

class NexoSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();

    Color bgColor;
    Color iconColor;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        bgColor = NexoColors.success.withValues(alpha: 0.15);
        iconColor = NexoColors.success;
        icon = Icons.check_circle_rounded;
        break;
      case SnackbarType.error:
        bgColor = NexoColors.error.withValues(alpha: 0.15);
        iconColor = NexoColors.error;
        icon = Icons.error_rounded;
        break;
      case SnackbarType.info:
        bgColor = NexoColors.primaryDark.withValues(alpha: 0.15);
        iconColor = NexoColors.primaryDark;
        icon = Icons.info_rounded;
        break;
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: NexoShapes.large,
        side: BorderSide(color: bgColor, width: 1.5),
      ),
      duration: duration,
      action: SnackBarAction(
        label: 'Cerrar',
        textColor: iconColor,
        onPressed: () {
          scaffoldMessenger.hideCurrentSnackBar();
        },
      ),
    );

    scaffoldMessenger.showSnackBar(snackBar);
  }
}
