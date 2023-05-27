
class SignUpFailure {
  final String message;

  const SignUpFailure([this.message = "An Unknown error occurred."]);

  factory SignUpFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpFailure('Email is not correct');
      case 'email-already-in-use':
        return const SignUpFailure('An account already exists for that email');
      case 'user-disabled':
        return const SignUpFailure('This user has been disabled');
      default:
        return const SignUpFailure();
    }
  }
}
