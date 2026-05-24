import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/features/add_post/presentation/cubit/add_post_cubit.dart';
import 'package:admin_msar/src/features/add_post/presentation/cubit/add_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/constants/app_icons.dart';
import 'package:admin_msar/src/core/widgets/app_button.dart';
import 'package:svg_flutter/svg.dart';

class AddPostButtonWidget extends StatelessWidget {
  const AddPostButtonWidget({
    super.key,
    required this.onSubmit,
    required this.onSuccessClose,
  });

  final VoidCallback onSubmit;
  final VoidCallback onSuccessClose;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state is AddPostSuccess) {
          _showSuccessSheet(context);
        }
      },
      builder: (context, state) {
        final loading = state is AddPostSubmitting;
        return AppButton(
          title: 'إضافة',
          loading: loading,
          onPressed: loading ? null : onSubmit,
        );
      },
    );
  }

  void _showSuccessSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
      ),
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      onSuccessClose();
                    },
                  ),
                ).fadeUp(),
                SvgPicture.asset(AppIcons.done).fadeUp(),
                const SizedBox(height: 20),
                const Text(
                  'تمت إضافة منشورك بنجاح!',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ).fadeUp(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      // Reset state so reopening the screen starts clean.
      if (context.mounted) context.read<AddPostCubit>().reset();
    });
  }
}
