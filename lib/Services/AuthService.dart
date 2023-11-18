import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to sign in with a phone number
  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          // Handle code sent to the user's phone
          // You can store verificationId to use it later for manual verification
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout, handle this if needed
        },
      );
    } catch (error) {
      rethrow;
    }
  }

  // Function to manually verify the SMS code
  Future<void> verifySmsCode(String verificationId, String smsCode) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
    } catch (error) {
      rethrow;
    }
  }

  // Function to sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
