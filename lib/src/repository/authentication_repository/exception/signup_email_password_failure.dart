class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure(
      [this.message = "An Unkown Error Occured"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure('Email is not valid.');
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(
            'An account already exist for this email.');
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(
            'Operation is not allowed. Please Contact Support');
      case 'user-disabled':
        return SignUpWithEmailAndPasswordFailure(
            'This user has been disabled. Please contact support foe help');
      default:
        return SignUpWithEmailAndPasswordFailure();
    }
  }
}
