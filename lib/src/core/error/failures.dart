sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'تحقق من اتصالك بالإنترنت']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'حدث خطأ في الخادم']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'فشل تسجيل الدخول']);
}

class NotAdminFailure extends Failure {
  const NotAdminFailure([
    super.message = 'هذا الحساب ليس لديه صلاحية الدخول',
  ]);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'العنصر غير موجود']);
}

class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'ليس لديك صلاحية لهذا الإجراء']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'حدث خطأ غير متوقع']);
}
