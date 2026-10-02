import 'package:evently/core/app_colors.dart';
import 'package:flutter/material.dart';

class SelectBox extends StatelessWidget {
  const SelectBox({
    super.key,
    this.title = "",
    required this.onTap,
    required this.isSelected,
    this.image = "",
  });

  final String title;
  final bool isSelected;
  final String image;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor
              : theme.primaryColorLight,

          border: Border.all(
            color: isSelected
                ? theme.primaryColor
                : theme.dividerColor,
          ),

          borderRadius: BorderRadius.circular(8),

          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
            ),
          ],
        ),

        child: Center(
          child: title.isNotEmpty
              ? Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? AppColors.white
                  : theme.primaryColorDark,

              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          )
              : ImageIcon(AssetImage(image), color:isSelected?theme.primaryColorLight:theme.primaryColorDark)
          ),
      ),
    );
  }
}