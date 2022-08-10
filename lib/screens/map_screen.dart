import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/map_view.dart';
import 'package:maps_app/widgets/btn_toggle_user_route.dart';
import 'package:maps_app/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();

  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (BuildContext context, locationState) {

          if(locationState.lastKnowLocation == null) return const Center( child: Text('Espere por favor...') );

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {

              Map<String, Polyline> polylines = Map.from(mapState.polylines);
              if(!mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }

              return SingleChildScrollView(
                      child: Stack(
                        children: [
                          MapView(
                            initialLocation: locationState.lastKnowLocation!,
                            polylines: polylines.values.toSet(),// TODO: para que pase se toman los values y se pasan a toSet()
                            markers: mapState.markers.values.toSet(),
                          ),
                          // TODO: controlls
                          const SearchBar(),
                          const ManualMarker()
                        ],
                      ),
                    );
            },
          );

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnToggleUserRoute(),
          BtnCurrentLocation(),
          BtnFollowUser()
        ],
      ),
    );
  }
}