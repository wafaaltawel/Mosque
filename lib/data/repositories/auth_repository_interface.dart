abstract class AuthRepositoryInterface {
  Future<void> login({required String phone, required String password});
}
