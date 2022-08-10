import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;
  final Set<Polyline> polylines;
  final Set<Marker> markers;

  const MapView({
    Key? key,
    required this.initialLocation,
    required this.polylines,
    required this.markers
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition = CameraPosition(
      target: initialLocation,
      zoom: 15
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(// TODO: Permite estar escuchando cuando algo sucede y servirá cuando el pointmove se mueve el dedo sobre la pantalla
        onPointerMove: (pointerMovieEvent) => mapBloc.stopFollowing(), //* o *// mapBloc.add(OnStopFollowingUserEvent()),
        child: GoogleMap(
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          polylines: polylines,
          // mapType: MapType.hybrid,
          initialCameraPosition: initialCameraPosition,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          markers: markers,
          onMapCreated: (controller) => mapBloc.add(OnMapInitializedEvent(controller)),
          onCameraMove: (position) => mapBloc.mapCenter = position.target
        ),
      ),
    );
  }
}