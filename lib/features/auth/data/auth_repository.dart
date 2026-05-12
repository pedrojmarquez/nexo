import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nexo/core/constants/app_constants.dart';
import 'package:nexo/features/auth/domain/user_model.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// AuthRepository — Lógica de autenticación y persistencia de usuario
/// ─────────────────────────────────────────────────────────────────────────────
class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  /// Stream del estado de autenticación — escuchado por GoRouter
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Usuario activo actual (puede ser null si no está logueado)
  User? get currentUser => _auth.currentUser;

  /// Inicia sesión con Google y crea/actualiza el perfil en Firestore
  Future<NexoUser?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null; // El usuario canceló

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) return null;

    final nexoUser = NexoUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoUrl: user.photoURL,
      updatedAt: DateTime.now(),
    );

    // Merge: no sobreescribe campos existentes (createdAt, settings, etc.)
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(user.uid)
        .set(nexoUser.toJson(), SetOptions(merge: true));

    return nexoUser;
  }

  /// Busca un usuario por su email para compartir notas
  Future<NexoUser?> findUserByEmail(String email) async {
    final snapshot = await _firestore
        .collection(AppConstants.usersCollection)
        .where('email', isEqualTo: email.trim().toLowerCase())
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    return NexoUser.fromJson(snapshot.docs.first.data());
  }

  /// Cierra sesión en Firebase y Google
  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
