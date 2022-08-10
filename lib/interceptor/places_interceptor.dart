import 'package:dio/dio.dart';


class PlacesInterceptor extends Interceptor {

  final accessToken = 'pk.eyJ1IjoiY3Jpc3RpYW5sYWc5NyIsImEiOiJjbDR4Z2I2ZDYxbWNuM2p0YXpkYndkZmtxIn0.ZGPCGUgOOFTqOKNMwyIjnQ';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.queryParameters.addAll({
      // 'limit': 7,
      'access_token': accessToken,
      'language': 'es'
    });

    super.onRequest(options, handler);
  }

}