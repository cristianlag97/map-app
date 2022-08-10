part of 'gps_bloc.dart';

class GpsState extends Equatable {

  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;

  GpsState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted
  });

  GpsState copywith({
    bool? isGpsEnable,
    bool? isGpsPermissionGranted
  }) => GpsState(
    isGpsEnabled: isGpsEnable ?? this.isGpsEnabled,
    isGpsPermissionGranted: isGpsPermissionGranted ?? this.isGpsPermissionGranted
  );

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];// TODO: para saber cuando un estado es diferente a otro esas propiedades las pongo en el props

  @override
  String toString() => '{ isGpsEnable: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted }';
}

