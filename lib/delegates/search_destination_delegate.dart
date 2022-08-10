import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {

  SearchDestinationDelegate() : super(
    searchFieldLabel: 'Buscar'
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query = '';
        },
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        final result = SearchResult(cancel: true);
        close(context, result);
      },
      icon: const Icon(Icons.arrow_back_ios)
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity = BlocProvider.of<LocationBloc>(context).state.lastKnowLocation!;
    searchBloc.getPlacesByquery(proximity, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
          final places = state.places;

        return ListView.separated(
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            return ListTile(
              title: Text(place.text),
              subtitle: Text(place.placeName),
              leading: const Icon(Icons.place_outlined, color: Colors.black),
              onTap: () {
                final result = SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(place.center[1], place.center[0]),
                  name: place.text,
                  description: place.placeName
                );
                print(state.history);
                searchBloc.add(AddToHistoryEvent(place));

                close(context, result);
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      });
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final historys = BlocProvider.of<SearchBloc>(context).state.history;

    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.black,),
          title: const Text('Colocar la ubicación manualmente', style: TextStyle(color: Colors.black),),
          onTap: (){

            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),

        ...historys.map((history) => ListTile(
          title: Text(history.text),
          subtitle: Text(history.placeName),
          leading: const Icon(Icons.history, color: Colors.black),
          onTap: () {
            final result = SearchResult(
              cancel: false,
              manual: false,
              position: LatLng(history.center[1], history.center[0]),
              name: history.text,
              description: history.placeName
            );

            close(context, result);
          },
        ))

      ],
    );
  }
}