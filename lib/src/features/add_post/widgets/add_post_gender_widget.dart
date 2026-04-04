import 'package:flutter/material.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';

class AddPostGenderWidget extends StatefulWidget {
  const AddPostGenderWidget({super.key});

  @override
  State<AddPostGenderWidget> createState() => _AddPostGenderWidgetState();
}

class _AddPostGenderWidgetState extends State<AddPostGenderWidget> {
  String selectedGender = 'male';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.light,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedGender = 'male';
              });
            },
            child: Container(
              width: 158,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: selectedGender == 'male'
                    ? AppColors.secondary
                    : Colors.transparent,
              ),
              child: Text(
                'ذكر',
                style: TextStyle(
                  color: selectedGender == 'male' ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedGender = 'female';
              });
            },
            child: Container(
              width: 158,
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: selectedGender == 'female'
                    ? AppColors.secondary
                    : Colors.transparent,
              ),
              child: Text(
                'انثى',
                style: TextStyle(
                  color: selectedGender == 'female'
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
