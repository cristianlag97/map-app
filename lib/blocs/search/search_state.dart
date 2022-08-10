part of 'search_bloc.dart';

class SearchState extends Equatable {

  final bool displayManualMarket;
  final List<Feature> places;
  final List<Feature> history;

  const SearchState({
    this.displayManualMarket = false,
    this.places = const [],
    this.history = const [],
  });

  SearchState copywith({
    bool? displayManualMarket,
    List<Feature>? places,
    List<Feature>? history,
  }) => SearchState(
    displayManualMarket: displayManualMarket ?? this.displayManualMarket,
    places: places ?? this.places,
    history: history ?? this.history,
  );


  @override
  List<Object> get props => [ displayManualMarket, places, history ];
}

