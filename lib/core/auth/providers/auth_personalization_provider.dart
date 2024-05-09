import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_personalization_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthPersonalization build() {
    return AuthPersonalization();
  }

  void setPersonalization(AuthPersonalization auth) {
    state = auth;
  }
}

class AuthPersonalization {
  final String? name;
  final String? password;
  final String? email;
  final String? role;

  AuthPersonalization({this.role, this.name, this.password, this.email});
}
