import 'package:k_bus_driver/network/api_service/api_service.dart';
import 'package:k_bus_driver/util/app_url/app_url.dart';
import 'package:k_bus_driver/util/typedef/type_def.dart';

class BusRepositories {
  EitherResponse addBusDetails(map, token) async =>
      ApiService.postApi(AppUrl().baseUrl + AppUrl().addBusDetails, map, token);
}
