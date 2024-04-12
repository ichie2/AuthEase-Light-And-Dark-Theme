import 'package:qoute_app/constants/api_constants.dart';
import 'package:qoute_app/data/entities/user_model.dart';
import 'package:qoute_app/domain/networking/api_service.dart';
import 'package:qoute_app/domain/repositories/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);
  @override
  Future<UserData?> getUser() async {
    return await _apiService.getData<UserData?>(
      acceptToken: true,
      endpoint: ApiConstants.profile,
      result: (result) {
        final response = UserData.fromJson(result);
        return response;
      },
    );
  }

  @override
  Future<String> login({username, password}) async {
    return await _apiService.postData<String>(
      endpoint: ApiConstants.login,
      params: {
        "username": username,
        "password": password,
      },
      acceptToken: false,
      result: (result) {
        final response = result['token'];
        return response.toString();
      },
    );
  }

  @override
  Future<dynamic> register({username, email, password, phone, address}) async {
    return await _apiService.postData<dynamic>(
      endpoint: ApiConstants.register,
      params: {
        "username": username,
        "email": email,
        "phone": phone,
        "image": "string",
        "address": address,
        "password": password,
      },
      acceptToken: false,
      result: (result) {
        return result;
      },
    );
  }
}
