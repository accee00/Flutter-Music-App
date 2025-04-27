import 'package:music_app/features/auth/model/user_model.dart';
import 'package:music_app/features/auth/repositories/auth_remote_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  final AuthRemoteRepo _authRemoteRepo = AuthRemoteRepo();
  @override
  AsyncValue<UserModel>? build() {
    return null;
  }

  Future<void> signUpUser({
    required String name,
    required String password,
    required String email,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepo.signUp(
      name: name,
      email: email,
      password: password,
    );

    res.match(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }

  Future<void> loginUser({
    required String password,
    required String email,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepo.signIn(email: email, password: password);

    res.match(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}
