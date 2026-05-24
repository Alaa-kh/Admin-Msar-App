import 'package:admin_msar/src/core/animation/motions.dart';
import 'package:admin_msar/src/core/widgets/app_snack_bar.dart';
import 'package:admin_msar/src/features/add_post/presentation/cubit/add_post_cubit.dart';
import 'package:admin_msar/src/features/add_post/presentation/cubit/add_post_state.dart';
import 'package:admin_msar/src/features/add_post/widgets/add_post_button_widget.dart';
import 'package:admin_msar/src/features/add_post/widgets/add_post_gender_widget.dart';
import 'package:admin_msar/src/features/posts/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_msar/src/core/constants/app_colors.dart';
import 'package:admin_msar/src/core/widgets/app_text_field.dart';
import 'package:go_router/go_router.dart';

class AddPostFormWidget extends StatefulWidget {
  const AddPostFormWidget({super.key});

  @override
  State<AddPostFormWidget> createState() => _AddPostFormWidgetState();
}

class _AddPostFormWidgetState extends State<AddPostFormWidget> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _whatsappController = TextEditingController();
  PostAudience _audience = PostAudience.men;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state is AddPostError) {
          AppSnackBar.error(context, state.message);
        }
      },
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'عنوان المنشور',
              style: TextStyle(color: AppColors.primaryDark),
            ).fadeUp(),
            AppTextField(
              controller: _titleController,
              hint: 'أدخل عنواناً جذاباً...',
            ),
            const SizedBox(height: 7),
            const Text(
              'وصف المنشور',
              style: TextStyle(color: AppColors.primaryDark),
            ).fadeUp(),
            AppTextField(
              controller: _descriptionController,
              maxLines: 7,
              minLines: 1,
              hint: 'اكتب تفاصيل المنشور هنا...',
            ).fadeUp(),
            const SizedBox(height: 7),
            const Text(
              'رقم الواتساب',
              style: TextStyle(color: AppColors.primaryDark),
            ).fadeUp(),
            AppTextField(
              controller: _whatsappController,
              hint: 'أدخل رقم الواتساب هنا...',
              keyboardType: TextInputType.phone,
              formatter: [
                FilteringTextInputFormatter.allow(RegExp(r'^\+?[0-9]*$')),
              ],
            ).fadeUp(),
            const SizedBox(height: 10),
            const Text(
              'الجنس المختار',
              style: TextStyle(color: AppColors.primaryDark),
            ).fadeUp(),
            const SizedBox(height: 7),
            AddPostGenderWidget(
              value: _audience,
              onChanged: (a) => setState(() => _audience = a),
            ).fadeUp(),
            const SizedBox(height: 10),
            SizedBox(height: screenHeight * 0.2),
            AddPostButtonWidget(
              onSubmit: () => context.read<AddPostCubit>().submit(
                title: _titleController.text,
                description: _descriptionController.text,
                whatsapp: _whatsappController.text,
                audience: _audience,
              ),
              onSuccessClose: () => context.pop(true),
            ).fadeUp(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
