import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_sizes.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onClick;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.title,
    required this.onClick,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor:
          isOutlined ? Colors.transparent : colorScheme.primary,
          side: isOutlined
              ? BorderSide(color: colorScheme.outline, width: 1.5)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
        ),
        onPressed: onClick,
        child: Text(
          title,
          style: theme.textTheme.labelLarge?.copyWith(
            color: isOutlined ? colorScheme.primary : colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
