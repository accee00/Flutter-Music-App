import 'package:music_app/features/auth/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_user_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserProvider extends _$CurrentUserProvider {
  @override
  UserModel? build() {
    return null;
  }

  void addUser(UserModel user) {
    state = user;
  }
}
