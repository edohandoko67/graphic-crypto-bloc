import 'package:crypto_fake/data/models/Login.dart';
import 'package:crypto_fake/data/models/ResData.dart';
import 'package:crypto_fake/data/models/datacust/datacustmodel.dart';
import 'package:crypto_fake/data/providers/api.provider.dart';
import 'package:crypto_fake/widgets/Storage.dart';

import './ApiConstant.dart';
import 'package:dio/dio.dart' as dio;


class AuthService {
  HttpClient httpClient = HttpClient(baseUrl: ApiConstants.baseUrl);
  final Storage _storage = Storage();

  Future<bool> login(Map<String, dynamic> data) async {
    final response = await httpClient.post(ApiConstants.login, data: data);
    final body = ResData.fromJson(response.data, (data) => Login.fromJson(data));

    if (body.metaData?.code != 200) {
      throw Exception(body.metaData?.message ?? 'Login failed');
    }

    _storage.login();
    _storage.saveToken(body.data.session_id ?? '');
    _storage.saveName(body.data.name ?? '');

    return true;
  }

  Future<List<DataCustModel>> dataCust() async {
    try {
      final response = await httpClient.get(ApiConstants.dataCust);
      final body = response.data;

      if (body['metaData']?['code'] == 200) {
        final dataList = body['response']?['dataSO'] as List<dynamic>?;

        if (dataList != null) {
          return dataList
              .map((e) => DataCustModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }

      return [];
    } on dio.DioError catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

}