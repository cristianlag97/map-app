import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/interceptor/interceptors.dart';
import 'package:maps_app/models/models.dart';

class TrafficService {

  final Dio _dioTraffic;
  final Dio _dioPlaces;

  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';

  TrafficService() //* se instancia para no mandarla en el constructor *//
    : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()), // TODO: Configurar interceptores
      _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponse> getCoorsStartToEnd(LatLng start, LatLng end) async {

    final coorsString = '${ start.longitude },${ start.latitude };${ end.longitude },${ end.latitude }';
  final url = '$_baseTrafficUrl/driving/$coorsString';


    final resp = await _dioTraffic.get(url);

    final data = TrafficResponse.fromMap(resp.data);

    return data;
  }

  Future<List<Feature>> getResultsByquery(LatLng proximity, String query) async {

    if(query.isEmpty) return [];

    final url = '$_basePlacesUrl/$query.json';

    final resp = await _dioPlaces.get(url, queryParameters: {
      'proximity': '${proximity.longitude},${proximity.latitude}',
      'limit': 7
    });

    final placesResponse = PlacesResponce.fromMap(resp.data);

    return placesResponse.features;
  }


  Future<Feature> getInfoMationByCoors(LatLng coors) async {

    final url = '$_basePlacesUrl/${coors.longitude},${coors.latitude}.json';
    final resp = await _dioPlaces.get(url, queryParameters: {
      'limit': 1
    });
    print(resp.data);
    final placesResponse = PlacesResponce.fromMap(resp.data);

    return placesResponse.features[0];
  }

}