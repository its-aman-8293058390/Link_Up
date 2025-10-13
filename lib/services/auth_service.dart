import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<UserModel?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      // Validate password
      if (!isValidPassword(password)) {
        throw Exception(
            'Password must be at least 8 characters with letters, numbers, and special symbols');
      }

      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        // Create user in database
        UserModel userModel = UserModel(
          uid: user.uid,
          email: user.email!,
        );

        await _db.child('users').child(user.uid).set(userModel.toMap());

        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase auth errors
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception('This email is already registered. Please login instead.');
        case 'invalid-email':
          throw Exception('Please enter a valid email address.');
        case 'operation-not-allowed':
          throw Exception('Email/password accounts are not enabled.');
        case 'weak-password':
          throw Exception('The password is too weak. Please use a stronger password.');
        default:
          throw Exception('An error occurred during signup: ${e.message}');
      }
    } catch (e) {
      // Handle general errors
      if (e is Exception) {
        rethrow;
      } else {
        throw Exception('An unexpected error occurred during signup.');
      }
    }
    return null;
  }

  // Sign in with email and password
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        // Get user data from database
        DataSnapshot snapshot =
            await _db.child('users').child(user.uid).get();

        if (snapshot.exists) {
          Map<String, dynamic> userData =
              Map<String, dynamic>.from(snapshot.value as Map);
          return UserModel.fromMap(userData, user.uid);
        } else {
          // Create user in database if not exists
          UserModel userModel = UserModel(
            uid: user.uid,
            email: user.email!,
          );

          await _db.child('users').child(user.uid).set(userModel.toMap());

          return userModel;
        }
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase auth errors
      switch (e.code) {
        case 'invalid-email':
          throw Exception('Please enter a valid email address.');
        case 'user-disabled':
          throw Exception('This account has been disabled.');
        case 'user-not-found':
          throw Exception('No account found with this email. Please sign up first.');
        case 'wrong-password':
          throw Exception('Incorrect password. Please try again.');
        default:
          throw Exception('An error occurred during login: ${e.message}');
      }
    } catch (e) {
      // Handle general errors
      if (e is Exception) {
        rethrow;
      } else {
        throw Exception('An unexpected error occurred during login.');
      }
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Password validation
  bool isValidPassword(String password) {
    if (password.length < 8) return false;

    bool hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    bool hasDigit = RegExp(r'\d').hasMatch(password);
    bool hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    return hasLetter && hasDigit && hasSpecialChar;
  }
}