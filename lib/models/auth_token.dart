class AuthToken {
  final String _token;
  final String _userId;
  final String _email;
  final DateTime _expiryDate;

  AuthToken({ 
    token,
    email,
    userId,
    expiryDate,
  }) : _token = token,
        _userId = userId,
        _email = email,
        _expiryDate = expiryDate;

  bool get isValid {
    return token != null;
  }

  String get email => _email;

  String? get token {
    if (_expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  DateTime get expiryDate {
    return _expiryDate;
  }

  Map<String, dynamic> toJson() {
    return {
      'authToken': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String(),
    };
  }

  static AuthToken fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['authToken'],
      userId: json['userId'],
      email: json['email'],
      expiryDate: DateTime.parse(json['expiryDate']),
    );
  }

}
