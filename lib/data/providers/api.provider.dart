import 'package:crypto_fake/data/providers/cache.provider.dart';
import 'package:crypto_fake/widgets/Log.dart';
import 'package:crypto_fake/widgets/Storage.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HttpClient {
  HttpClient({required this.baseUrl, this.enableCache=false, this.showAlert=true, this.duration=const Duration(seconds: 15)});
  final String baseUrl;
  final bool enableCache;
  final bool showAlert;
  final Duration duration;
  final Storage _storage = Storage();
  late Dio dio = Dio(BaseOptions(baseUrl: baseUrl))
  ..interceptors
  .addAll([
    LogInterceptor(
      responseHeader: false,
      error: true,
      responseBody: true,
      requestHeader: false,
    ),
    if (enableCache)
      DioCacheInterceptor(
          options: CacheOptions(
            store: HiveCacheStore(AppPathProvider.path),
            policy: CachePolicy.forceCache,
            hitCacheOnErrorExcept: [],
            maxStale: duration,
            priority: CachePriority.high,
          )
      ),
    InterceptorsWrapper(
        onRequest: (options, handler) {
          final String? token = _storage.getToken();
          if(token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (e, handler) {
          switch (e.type) {
            case DioErrorType.connectTimeout:
              if(showAlert) EasyLoading.dismiss();
              break;
            case DioErrorType.sendTimeout:
              if(showAlert) EasyLoading.dismiss();
              break;
            case DioErrorType.receiveTimeout:
              if(showAlert) EasyLoading.dismiss();
              break;
            case DioErrorType.response:
              if(showAlert) EasyLoading.showError(e.response?.statusMessage??"Server Error");
              break;
            case DioErrorType.cancel:
              if(showAlert) EasyLoading.dismiss();
              break;
            case DioErrorType.other:
              if(showAlert) EasyLoading.showError("Terjadi Kesalahan pada server!");
              break;
          }
          Log.d(e);
          return handler.next(e);
        }
    )
  ]);

  Future<Response<T>> get<T>(String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    Response<T> response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress
    );

    Options requestOptions = (options ?? Options()).copyWith(
      //followRedirects: followRedirects,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${_storage.getToken()}',
      },
    );
    print('token: bearer ${_storage.getToken()}');

    return response;
  }

  Future<Response<T>> post<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        void Function(int, int)? onSendProgress,
        void Function(int, int)? onReceiveProgress,
        bool showError = true,
        bool useFormData = false,
        bool followRedirects = false,
      }) async {
    // Konversi data ke FormData jika diperlukan
    dynamic requestData = data;
    if (useFormData && data is Map<String, dynamic>) {
      requestData = FormData.fromMap(data);
    }

    // Gabungkan opsi, termasuk followRedirects
    Options requestOptions = (options ?? Options()).copyWith(
      followRedirects: followRedirects,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${_storage.getToken()}',
      },
    );
    print('token: bearer ${_storage.getToken()}');

    try {
      Response<T> response = await dio.post(
        path,
        data: requestData,
        queryParameters: queryParameters,
        options: requestOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioError catch (e) {
      if (showError) {
        print('Dio Error: ${e.message}');
        print('Response Error: ${e.response?.data}');
      }
      rethrow;
    } catch (e) {
      if (showError) {
        print('Error: $e');
      }
      rethrow;
    }
  }
}