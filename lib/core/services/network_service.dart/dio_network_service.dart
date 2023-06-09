// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart' hide FormData;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
part 'dio_network_service.freezed.dart';

@freezed
class NetworkRequestBody with _$NetworkRequestBody {
  const factory NetworkRequestBody.empty() = Empty;
  const factory NetworkRequestBody.fromData(FormData data) = formData;
  const factory NetworkRequestBody.text(String data) = Text;
}

// ignore: constant_identifier_names
enum NetworkRequestType { GET, POST, PUT, PATCH, DELETE }

class NetworkRequest {
  const NetworkRequest({
    required this.type,
    required this.path,
    required this.data,
    this.queryParams,
    this.headers,
  });

  final NetworkRequestType type;
  final String path;
  final NetworkRequestBody data;
  final Map<String, dynamic>? queryParams;
  final Map<String, String>? headers;
}

@freezed
class NetworkResponse<Model> with _$NetworkResponse {
  const factory NetworkResponse.ok(Model data) = Ok;
  const factory NetworkResponse.invalidParameters(Model data) =
      InvalidParameters;
  const factory NetworkResponse.noAuth(Model data) = NoAuth; //401
  const factory NetworkResponse.noAccess(Model data) = NoAccess; //403
  const factory NetworkResponse.badRequest(Model data) = BadRequest; //400
  const factory NetworkResponse.notFound(Model data) = NotFound; //404
  const factory NetworkResponse.conflict(Model data) = Conflict; //409
  const factory NetworkResponse.unProcessable(Model data) = UnProcessable; //422
  const factory NetworkResponse.noData(String data) = NoData; //500
}

class PreparedNetworkRequest<Model> {
  const PreparedNetworkRequest(
    this.request,
    this.parser,
    this.dio,
    this.headers,
    this.onSendProgress,
    this.onReceiveProgress,
  );
  final NetworkRequest request;
  final Model Function(Map<String, dynamic>) parser;
  final Dio dio;
  final Map<String, dynamic> headers;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;
}

Future<NetworkResponse<Model>> executeRequest<Model>(
  PreparedNetworkRequest request,
) async {
  try {
    dynamic body = request.request.data.whenOrNull(
      fromData: (data) => data,
      text: (data) => data,
    );
    final response = await request.dio.request(
      request.request.path,
      data: body,
      queryParameters: request.request.queryParams,
      options: Options(
        method: request.request.type.name,
        headers: request.headers,
        validateStatus: (status) => true,
      ),
      onSendProgress: request.onSendProgress,
      onReceiveProgress: request.onReceiveProgress,
    );

    switch (response.statusCode) {
      case 200:
        return NetworkResponse.ok(request.parser(response.data));
      case 201:
        return NetworkResponse.ok(request.parser(response.data));
      case 400:
        return NetworkResponse.badRequest(request.parser(response.data));
      case 401:
        return NetworkResponse.noAuth(request.parser(response.data));
      case 403:
        return NetworkResponse.noAccess(request.parser(response.data));
      case 404:
        return NetworkResponse.notFound(request.parser(response.data));
      case 409:
        return NetworkResponse.conflict(request.parser(response.data));
      case 422:
        return NetworkResponse.unProcessable(request.parser(response.data));
    }
    return NetworkResponse.ok(request.parser(response.data));
  } on DioError catch (error) {
    final errorText = error.toString();
    if (error.requestOptions.cancelToken?.isCancelled ?? false) {
      return NetworkResponse.noData(errorText);
    }
    return NetworkResponse.noData(error.toString());
  } catch (error) {
    return NetworkResponse.noData(error.toString());
  }
}

class NetworkService {
  NetworkService({
    required this.baseUrl,
    dioClient,
    httpHeaders,
  })  : _dio = dioClient,
        _headers = httpHeaders ?? {};
  Dio? _dio;
  final String baseUrl;
  final Map<String, String> _headers;
  Future<Dio> _getDefaultDioClient() async {
    _headers['content-type'] = 'application/json; charset=utf-8';
    final dio = Dio()
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      )
      ..options.baseUrl = baseUrl
      ..options.headers = _headers
      ..options.connectTimeout = 10000.milliseconds // 5 seconds
      ..options.receiveTimeout = 10000.milliseconds; // 5 seconds
    dio.options.validateStatus = (status) => true;
    return dio;
  }

  void addBasicAuth(String accessToken) {
    _headers['Authorization'] = 'Bearer $accessToken';
  }

  Future<NetworkResponse<T>> execute<T>(
    NetworkRequest request,
    T Function(Map<String, dynamic>) parser, {
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _dio ??= await _getDefaultDioClient();
    final req = PreparedNetworkRequest<T>(
      request,
      parser,
      _dio!,
      {..._headers, ...(request.headers ?? {})},
      onSendProgress,
      onReceiveProgress,
    );
    final result = await compute(
      executeRequest<T>,
      req,
    );
    return result;
  }
}
