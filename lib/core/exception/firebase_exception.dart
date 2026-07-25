import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExceptionHandler {
  static String getMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address.';

      case 'email-already-in-use':
        return 'Email is already registered.';

      case 'weak-password':
        return 'Password is too weak.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
        return 'Incorrect password.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'too-many-requests':
        return 'Too many attempts. Try again later.';

      case 'invalid-credential':
        return 'Invalid email or password.';

      default:
        return e.message ?? 'Something went wrong.';
    }
  }
}
