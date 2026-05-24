import 'package:admin_msar/src/features/posts/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';

class AddPostGenderWidget extends StatelessWidget {
  const AddPostGenderWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final PostAudience value;
  final ValueChanged<PostAudience> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.light,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _option(PostAudience.men, 'ذكر'),
          _option(PostAudience.women, 'انثى'),
        ],
      ),
    );
  }

  Widget _option(PostAudience audience, String label) {
    final selected = value == audience;
    return GestureDetector(
      onTap: () => onChanged(audience),
      child: Container(
        width: 158,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: selected ? AppColors.secondary : Colors.transparent,
        ),
        child: Text(
          label,
          style: TextStyle(color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
