part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;

  //* Polylines *//
  final Map<String, Marker> markers;
  final Map<String, Polyline> polylines;
  /*
    'miRuta: {
      id: polylineID Google,
      points:[ [lat,lng], [122122, -323212], [122122, -323212] ],
      with: 3,
      color: Colors.black87
    },
    destino: {
      id: polylineID Google,
      points:[ [lat,lng], [122122, -323212], [122122, -323212] ],
      with: 3,
      color: Colors.blue
    }
  */

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUser = true,
    this.showMyRoute = true,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }): polylines = polylines ?? const {},
      markers = markers ?? const {}; // TODO: si no tengo ningun valor entonces es un map vacio


  MapState copywith({
    bool? isMapInitialized,
    bool? isFollowUser,
    bool? showMyRoute,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser:  isFollowUser ?? this.isFollowingUser,
    showMyRoute:  showMyRoute ?? this.showMyRoute,
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers,
  );

  @override
  List<Object> get props => [ isMapInitialized, isFollowingUser, showMyRoute, polylines ];// TODO: para saber cuando un estado es diferente a otro esas propiedades las pongo en el props
}