import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeAuthRepository {
  AppUser? get currentUser => null; // TODO: implement currentUser
  Stream<AppUser?> authStateChanges() =>
      Stream.value(null); // TODO: implement authStateChanges

  Future<void> signinWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    // TODO: implement signinWithEmailAndPassword
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    // TODO: implement createUserWithEmailAndPassword
  }

  Future<void> signOut() async {
    // TODO: implement signOut
  }
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  return FakeAuthRepository();
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
