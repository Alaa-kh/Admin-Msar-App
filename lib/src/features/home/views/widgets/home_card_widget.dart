import 'package:flutter/material.dart';
import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:svg_flutter/svg.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({
    super.key,
    required this.icon,
    required this.number,
    required this.text,
    required this.onTap,
  });
  final String icon;
  final int number;
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.border, blurRadius: 7)],
      ),
      child: Column(
        children: [
          ListTile(
            leading: SvgPicture.asset(icon).fadeUp(),
            title: Text(
              number.toString(),
              style: TextStyle(
                color: AppColors.dark,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ).fadeUp(),
            subtitle: Text(
              text,
              style: TextStyle(color: AppColors.grey),
            ).fadeUp(),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('عرض الكل', style: TextStyle(color: AppColors.primary)),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                  size: 16,
                ),
              ],
            ),
          ).fadeDown(),
        ],
      ),
    );
  }
}
