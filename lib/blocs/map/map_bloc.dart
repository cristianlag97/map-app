import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>( _onInitMap );

    on<OnStopFollowingUserEvent>((event, emit) => emit(state.copywith(isFollowUser: false)));
    on<OnStartFollowingUserEvent>( _onStartFollowing );

    on<UpdateUserPolylineEvent>( _onPolylineNewPoint );

    on<OnToggleUserRouteEvent>((event, emit) => emit(state.copywith(showMyRoute: !state.showMyRoute)));
    on<DisplayPolylinesEvent>((event, emit) => emit(state.copywith(polylines: event.polylines, markers: event.markers)));

    // TODO: para escuchar los cambios en el state // si hay un stream se tiene que limpiar si no se usará mas
    locationStateSubscription = locationBloc.stream.listen((locationState) {

      if(locationState.lastKnowLocation != null) { // TODO: se llama acá la activación de los polylines cuando el locationsBloc.stream cambie
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }
      if(!state.isFollowingUser) return; // TODO: sino sigo al usuario no hago nada
      if(locationState.lastKnowLocation == null) return; // TODO: sino tengo ninguna localización no puedo hacer nada
        moveCamera(locationState.lastKnowLocation!); // TODO: cada que la ubicación cambia la camara va a seguir el punto

    });
  }


  void stopFollowing() {
    print(' =======> Follow Stop');
    add(OnStopFollowingUserEvent());
  }

  void _onStartFollowing(OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    print(' =======> Follow Start');
    emit(state.copywith(isFollowUser: true));

    if(locationBloc.state.lastKnowLocation == null) return; // TODO: sino tengo ninguna localización no puedo hacer nada
    moveCamera(locationBloc.state.lastKnowLocation!);

  }

  void _onPolylineNewPoint(UpdateUserPolylineEvent event, Emitter<MapState> emit) {

    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;
    emit(state.copywith(polylines: currentPolylines));
  }

  Future drawRoutePolyline(RouteDestination destination) async {

    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      points: destination.points,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap
    );

    double kms = destination.distance / 1000;
    kms = (kms *100).floorToDouble();
    kms /= 100;

    // double tripDuration = (destination.duration / 60).floorToDouble();
    int tripDuration = (destination.duration / 60).floorToDouble().toInt();

    //* Custom markers *//
    // final startMaker = await getAssetImageMarker();
    // final endMaker = await getNetworkImageMarker();
    final startMaker = await getStartCustomMarker(tripDuration, 'Mi ubicación');
    final endMaker = await getEndCustomMarker(kms.toInt(), destination.endPlace.text);

    final startMarker = Marker(
      anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      position: destination.points.first,
      icon: startMaker,
      // infoWindow: InfoWindow(
      //   title:  'Inicio',
      //   snippet: 'Kms: $kms, duration: $tripDuration'
      // )
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: endMaker,
      // infoWindow: InfoWindow(
      //   title:  destination.endPlace.text,
      //   snippet: destination.endPlace.placeName
      // )
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add(DisplayPolylinesEvent(currentPolylines, currentMarkers));

    // await Future.delayed(const Duration(milliseconds: 300));
    // _mapController?.showMarkerInfoWindow(const MarkerId('start'));

  }


  void _onInitMap( OnMapInitializedEvent event, Emitter<MapState> emit) {

    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMasTheme));

    emit(state.copywith(isMapInitialized: true));

  }


  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }


  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }

}
