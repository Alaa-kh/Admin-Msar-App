import 'package:firebase_auth/firebase_auth.dart';

import 'package:admin_msar/src/core/error/failures.dart';

Failure mapFirebaseException(Object error) {
  if (error is FirebaseAuthException) {
    return AuthFailure(switch (error.code) {
      'invalid-email' => 'البريد الإلكتروني غير صالح',
      'user-disabled' => 'تم تعطيل هذا الحساب',
      'user-not-found' => 'لا يوجد حساب بهذا البريد',
      'wrong-password' => 'كلمة المرور غير صحيحة',
      'invalid-credential' => 'بيانات الدخول غير صحيحة',
      'too-many-requests' => 'محاولات كثيرة، حاول لاحقاً',
      'network-request-failed' => 'تحقق من اتصالك بالإنترنت',
      _ => 'فشل تسجيل الدخول',
    });
  }
  if (error is FirebaseException) {
    if (error.plugin == 'firebase_storage') {
      return const ServerFailure('فشل رفع الملف');
    }
    if (error.plugin == 'cloud_firestore') {
      return switch (error.code) {
        'permission-denied' => const PermissionFailure(),
        'not-found' => const NotFoundFailure(),
        'unavailable' => const NetworkFailure(),
        _ => const ServerFailure(),
      };
    }
    return const ServerFailure();
  }
  return const UnknownFailure();
}
