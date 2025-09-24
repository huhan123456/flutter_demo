import 'package:bot_toast/bot_toast.dart';
import 'package:demo/http/base_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioUtils {
  // 单例模式
  static final DioUtils _instance = DioUtils._internal();

  factory DioUtils() => _instance;

  DioUtils._internal() {
    init(); // 初始化 Dio
  }

  late Dio dio;
  final Logger _logger = Logger(); // 日志工具

  // 初始化 Dio 配置
  void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://www.wanandroid.com/', // 基础 URL
        connectTimeout: const Duration(seconds: 10), // 连接超时
        receiveTimeout: const Duration(seconds: 10), // 接收超时
        contentType: 'application/json', // 默认 Content-Type
      ),
    );

    // 添加拦截器
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  // 请求拦截器（添加 Token/修改请求头）
  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 示例：添加 Token
    // final token = await _getToken();
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    _logger.i('Request: ${options.method} ${options.uri}');
    handler.next(options);
  }

  // 响应拦截器
  Future<void> _onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    _logger.i('Response: $response');
    BaseModel baseModel = BaseModel.fromJson(response.data);
    if (baseModel.errorCode == 0) {
      handler.next(
        Response(requestOptions: response.requestOptions, data: baseModel.data),
      );
    } else if (baseModel.errorCode == -1001) {
      //未登录
      BotToast.showText(text: baseModel.errorMsg ?? '');
      handler.reject(DioException(requestOptions: response.requestOptions));
    } else if (baseModel.errorCode == -1) {
      BotToast.showText(text: baseModel.errorMsg ?? '');
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
  }

  // 错误拦截器（统一错误处理）
  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _logger.e('Error: ${err.type} ${err.message}');
    handler.next(err);
  }

  // 模拟获取 Token（根据实际项目替换）
  Future<String?> _getToken() async {
    return 'your_access_token';
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      return await dio.get(
        path,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      return await dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw '连接超时，请检查网络';
      case DioExceptionType.badResponse:
        throw '服务器异常：${e.response?.statusCode}';
      case DioExceptionType.unknown:
        throw '网络未连接';
      default:
        throw '请求失败：${e.message}';
    }
  }
}
