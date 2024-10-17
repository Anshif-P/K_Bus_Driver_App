import 'dart:convert';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:k_bus_driver/util/app_exception/app_exception.dart';
import 'package:k_bus_driver/util/typedef/type_def.dart';

class ApiService {
  // ignore: prefer_final_fields
  static Map<String, String>? _header = {
    'Content-Type': 'application/json',
    'token': ''
  };

  static EitherResponse postApi(String url, Map map,
      [String? userToken]) async {
    print('map$map url $url');
    final uri = Uri.parse(url);
    if (userToken != null) {
      _header!['token'] = userToken;
    }
    final body = jsonEncode(map);
    dynamic fetchedData;
    try {
      print('bfore ------------------ 77');
      print("encode data $body");
      final response = await http.post(uri, body: body, headers: _header);
      print("response ----------${response.body}");

      fetchedData = _getResponse(response);

      return Right(fetchedData);
    } on SocketException {
      print('socket__________________----------');
      return Left(InternetException());
    } on http.ClientException {
      return Left(RequestTimeOutException());
    } catch (e) {
      print('socket__________________----------$e');
      return Left(BadRequestException());
    }
  }

  static EitherResponse getApi(String url, [String? token]) async {
    final uri = Uri.parse(url);
    if (token != null) {
      _header!['usertoken'] = token;
    }
    try {
      dynamic fetchedData;

      final response = await http.get(uri, headers: _header);
      fetchedData = _getResponse(response);

      return Right(fetchedData);
    } on SocketException {
      return Left(InternetException());
    } on http.ClientException {
      return Left(RequestTimeOutException());
    } catch (e) {
      return Left(BadRequestException());
    }
  }

  static EitherResponse deleteApi(String url, [String? token]) async {
    final uri = Uri.parse(url);
    if (token != null) {
      _header!['usertoken'] = token;
    }
    try {
      dynamic fetchedData;
      final response = await http.delete(uri, headers: _header);
      fetchedData = _getResponse(response);

      return Right(fetchedData);
    } on SocketException {
      return Left(InternetException());
    } on http.ClientException {
      return Left(RequestTimeOutException());
    } catch (e) {
      return Left(BadRequestException());
    }
  }

  static EitherResponse patch(String url, Map map, [String? userToken]) async {
    final uri = Uri.parse(url);
    if (userToken != null) {
      _header!['usertoken'] = userToken;
    }
    final body = jsonEncode(map);
    dynamic fetchedData;
    try {
      final response = await http.patch(uri, body: body, headers: _header);

      fetchedData = _getResponse(response);

      return Right(fetchedData);
    } on SocketException {
      return Left(InternetException());
    } on http.ClientException {
      return Left(RequestTimeOutException());
    } catch (e) {
      return Left(BadRequestException());
    }
  }

  static _getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return (jsonDecode(response.body));
      case 400:
        return throw BadRequestException();
      default:
        throw BadRequestException();
    }
  }
}
