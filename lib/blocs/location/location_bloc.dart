import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription<Position>? positionStream;
  final GpsBloc _gpsBloc = GpsBloc();

  LocationBloc() : super(const LocationState()) {

    on<OnStartFollowinbgUser>((event, emit) => emit(state.copywith( followingUser: true)));
    on<OnStopFollowinbgUser>((event, emit) => emit(state.copywith( followingUser: false)));

    on<OnNewUserLocationEvent>((event, emit) {
      emit(
        state.copywith(
          lastKnowLocation: event.newLocation,
          myLocationHistory: [...state.myLocationHistory, event.newLocation],
        )
      );
    });
  }

// TODO: obtiene posición actual del usuario
  Future getCurrentPosition() async {
    if(!_gpsBloc.state.isAllGranted) {
      final position = await Geolocator.getCurrentPosition();
      add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
    }
  }

// TODO: escucha los cambios de la ubicación de los cambios
  void startFollowingUser() {
    if(!_gpsBloc.state.isAllGranted) {
      add(OnStartFollowinbgUser());

      print('startFollowingUser');
      positionStream = Geolocator.getPositionStream().listen((event) {
        final position = event;
        add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
      });
    }
  }

  void stopFollowingUser(){
    add(OnStopFollowinbgUser());

    positionStream?.cancel();
    print('stopFollowingUser');
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }

}
