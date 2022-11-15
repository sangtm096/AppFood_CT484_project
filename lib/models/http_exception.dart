class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  HttpException.firebase(String code)
      : message = _translateFirebaseErrorCode(code);

  static String _translateFirebaseErrorCode(code) {
    switch (code) {
      case 'EMAIL_EXISTS':
        return 'Địa chỉ email này đã được sử dụng';
      case 'INVALID_EMAIL':
        return 'Đây không phải là một địa chỉ email hợp lệ';
      case 'WEAK_PASSWORD':
        return 'Mật khẩu này quá yếu';
      case 'EMAIL_NOT_FOUND':
        return 'Không thể tìm thấy người dùng có email đó';
      case 'INVALID_PASSWORD':
        return 'Mật khẩu không hợp lệ';
      default:
        return code;
    }
  }

  @override
  String toString() {
    return message;
  }
}
