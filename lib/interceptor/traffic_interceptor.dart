import 'package:dio/dio.dart';


class TrafficInterceptor extends Interceptor{

  final accessToken = 'pk.eyJ1IjoiY3Jpc3RpYW5sYWc5NyIsImEiOiJjbDR4Z2I2ZDYxbWNuM2p0YXpkYndkZmtxIn0.ZGPCGUgOOFTqOKNMwyIjnQ';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });

    super.onRequest(options, handler);
  }

}