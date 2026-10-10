import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../../data/models/item_models.dart';

class StatusBadge extends StatelessWidget {
  final ItemStatus status;
  final String? customText;

  const StatusBadge({
    Key? key,
    required this.status,
    this.customText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor;
    Color bgColor;

    switch (status) {
      case ItemStatus.reported:
      case ItemStatus.pendingReview:
        textColor = AppColors.statusOrange;
        bgColor = AppColors.statusOrangeBg;
        break;
      case ItemStatus.stored:
        textColor = AppColors.statusTeal;
        bgColor = AppColors.statusTealBg;
        break;
      case ItemStatus.matched:
        textColor = AppColors.statusTeal;
        bgColor = AppColors.statusTealBg;
        break;
      case ItemStatus.claimApproved:
      case ItemStatus.claimed:
      case ItemStatus.returned:
        textColor = AppColors.statusGreen;
        bgColor = AppColors.statusGreenBg;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadii.full),
      ),
      child: Text(
        customText ?? status.label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isDestructive;
  final Widget? icon;

  const AppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.isDestructive = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.r12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: isDestructive ? AppColors.statusRed : AppColors.primaryBlue,
          side: BorderSide(
            color: isDestructive ? AppColors.statusRed : AppColors.border,
            width: 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.r12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 8)],
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDestructive ? AppColors.statusRed : (isPrimary ? Colors.white : AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecurityStaffCard extends StatelessWidget {
  final String title;
  final String content;

  const SecurityStaffCard({
    Key? key,
    this.title = 'Security Staff Only',
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.r16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lock_outline, size: 18, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textHeading,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
