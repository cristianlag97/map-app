part of 'location_bloc.dart';

class LocationState extends Equatable {

  final bool followingUser;
  final LatLng? lastKnowLocation;
  final List<LatLng>myLocationHistory;
  // TODO:
  //ultimo geolocation
  //historial

  const LocationState({
    this.followingUser = false,
    this.lastKnowLocation,
    myLocationHistory
  }): myLocationHistory = myLocationHistory ?? const [];



  LocationState copywith({
    bool? followingUser,
    LatLng? lastKnowLocation,
    List<LatLng>?myLocationHistory,
  }) => LocationState(
    followingUser: followingUser ?? this.followingUser,
    lastKnowLocation: lastKnowLocation ?? this.lastKnowLocation,
    myLocationHistory: myLocationHistory ?? this.myLocationHistory
  );

  @override
  List<Object?> get props => [ followingUser, lastKnowLocation, myLocationHistory ];// TODO: para saber cuando un estado es diferente a otro esas propiedades las pongo en el props
}

