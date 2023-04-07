class LogInWithEmailAndPasswordFailure {
  final String message;

  const LogInWithEmailAndPasswordFailure(
      [this.message = "An Unkown Error Occured"]);

  factory LogInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-password':
        return LogInWithEmailAndPasswordFailure(
            'Please Enter the correct password.');
      case 'invalid-email':
        return LogInWithEmailAndPasswordFailure('Email is not valid.');
      case 'email-already-in-use':
        return LogInWithEmailAndPasswordFailure(
            'An account already exist for this email.');
      case 'operation-not-allowed':
        return LogInWithEmailAndPasswordFailure(
            'Operation is not allowed. Please Contact Support');
      case 'user-disabled':
        return LogInWithEmailAndPasswordFailure(
            'This user has been disabled. Please contact support foe help');
      default:
        return LogInWithEmailAndPasswordFailure();
    }
  }
}
