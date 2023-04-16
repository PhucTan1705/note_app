import 'package:project_23/service/auth/auth_exceptions.dart';
import 'package:project_23/service/auth/auth_provider.dart';
import 'package:project_23/service/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    test('Không được khởi tạo ngay từ đầu', () {
      expect(provider.isInitialized, false);
    });

    test('không thể đăng xuất khi chưa khởi tạo', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    test('Nên được khởi tạo', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('Người dùng nên Null sau khi khởi tạo', () {
      expect(provider.currentUser, null);
    });

    test(
      'nên được khởi tạo trong vòng 2 giây nữa',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test('tạo người dùng nên được ủy quyền cho chức năng đăng nhập', () async {
      final badEmailUser = provider.createUser(
        email: 'osiris@gmail.com',
        password: '123456',
      );

      expect(badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()));

      final badPasswordUser = provider.createUser(
        email: 'someone@gmail.com',
        password: '123456',
      );
      expect(badPasswordUser,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));

      final user = await provider.createUser(
        email: 'Tan',
        password: '123456',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('Người dùng đăng nhập nên được xác minh', () {
      provider.sendEmailVerification();
      final user=provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('có thể đăng nhập và dăng xuất', () async {
      await provider.logOut();
      await provider.logIn(email: 'email', password: 'password',);
      final user=provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'osirisnk@gmail.com') throw UserNotLoginAuthException();
    if (password == '123456') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
