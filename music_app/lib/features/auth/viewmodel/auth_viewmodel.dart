import 'package:music_app/core/providers/current_user_provider.dart';
import 'package:music_app/features/auth/model/user_model.dart';
import 'package:music_app/features/auth/repositories/auth_local_repo.dart';
import 'package:music_app/features/auth/repositories/auth_remote_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepo _authRemoteRepo;
  late AuthLocalRepo _authLocalRepo;
  late CurrentUserProvider _currentUserProvider;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepo = ref.watch(authRemoteRepoProvider);
    _authLocalRepo = ref.watch(authLocalRepoProvider);
    _currentUserProvider = ref.watch(currentUserProviderProvider.notifier);
    return null;
  }

  Future<void> initShared() async {
    await _authLocalRepo.init();
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
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (user) {
        _currentUserProvider.addUser(user);
        return state = AsyncValue.data(user);
      },
    );
  }

  Future<void> loginUser({
    required String password,
    required String email,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepo.signIn(email: email, password: password);

    res.match(
      (error) => state = AsyncValue.error(error.message, StackTrace.current),
      (user) {
        _authLocalRepo.setToken(user.token);
        _currentUserProvider.addUser(user);
        return state = AsyncValue.data(user);
      },
    );
  }

  Future<UserModel?> getData() async {
    state = const AsyncValue.loading();
    final token = _authLocalRepo.getToken();
    print(token);
    if (token != null) {
      final res = await _authRemoteRepo.getCurrentUserData(userToken: token);
      res.match((failure) => AsyncValue.error(failure, StackTrace.current), (
        user,
      ) {
        _currentUserProvider.addUser(user);
        return AsyncValue.data(user);
      });
    }
    return null;
  }
}
