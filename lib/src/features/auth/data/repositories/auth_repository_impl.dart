import '../domain/entities/user_entity.dart';
import '../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserEntity?> login(String email, String password) async {
    // Mocking authentication
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'user@test.com' && password == 'password') {
      return const UserEntity(
        id: '123',
        email: 'user@test.com',
        name: 'John Doe',
      );
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<UserEntity?> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return UserEntity(id: '124', email: email, name: name);
  }
}
