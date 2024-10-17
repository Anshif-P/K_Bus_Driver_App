import 'package:k_bus_driver/network/api_service/api_service.dart';
import 'package:k_bus_driver/util/app_url/app_url.dart';
import 'package:k_bus_driver/util/typedef/type_def.dart';

class AuthenticationRepo {
  EitherResponse singUpUser(map) async =>
      ApiService.postApi(AppUrl().baseUrl + AppUrl().register, map);
  EitherResponse loginUser(map) async =>
      ApiService.postApi(AppUrl().baseUrl + AppUrl().login, map);
}
