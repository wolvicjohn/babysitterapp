import 'package:flutter/material.dart';
import 'package:babysitterapp/models/search_result.dart';
import 'package:babysitterapp/pages/search_page/widgets/filter_bar_widget.dart';
import 'package:babysitterapp/pages/search_page/widgets/index.dart';
import 'package:latlong2/latlong.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Widget _filterWidget = Container();
  final List<String> _searchHistory = [];
  final List<SearchResult> _allBabysitters = SearchResult.fetchBabysitters();
  List<SearchResult> _searchResults = [];
  String _selectedFilter = '';

  bool _showAutocomplete = false;
  bool _showResults = false;
  bool _noResultsFound = false;
  bool _showFilterBar = true;

  final LatLng userLocation = LatLng(37.7749, -122.4194);

  List<SearchResult> _applyFilter(List<SearchResult> results) {
    switch (_selectedFilter) {
      case 'People':
        return results;
      case 'Near you':
        return results;
      case 'Map':
        return results;
      default:
        return results;
    }
  }

  void _onFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;

      //update the filter widget based on the selected filter
      if (_selectedFilter == 'People') {
        _filterWidget = const AllDefaultWidget(
        );
      } else if (_selectedFilter == 'Near you') {
        _filterWidget = NearbyWidget(
          userLocation: userLocation,
          babysitters: _allBabysitters,
        );
      } else if (_selectedFilter == 'Map') {
        _filterWidget = MapWidget(
          userLocation: userLocation,
          babysitters: _allBabysitters,
        );
      } else {
        _filterWidget = Container();
      }

      _searchResults = _applyFilter(_allBabysitters);
    });
  }


  void _onSearchSubmit(String value) {
    setState(() {
      if (value.isNotEmpty) {
        if (!_searchHistory.contains(value)) {
          _searchHistory.add(value);
        }
        _showAutocomplete = false;

        _searchResults = _allBabysitters
            .where((result) =>
        result.location.toLowerCase().contains(value.toLowerCase()) ||
            result.bio.toLowerCase().contains(value.toLowerCase()) ||
            result.skills.any((skill) =>
                skill.toLowerCase().contains(value.toLowerCase())))
            .toList();

        _showResults = true;
        _noResultsFound = _searchResults.isEmpty;
      }
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      if (value.isNotEmpty) {
        _showAutocomplete = true;
        _showResults = false;
        _showFilterBar = false;

        _searchResults = _allBabysitters
            .where((result) =>
            result.location.toLowerCase().contains(value.toLowerCase()))
            .toList();
      } else {
        _showAutocomplete = false;
        _showFilterBar = true;
        _filterWidget = Container(); //widget is hidden when there's no input
      }
    });
  }

  void _onBackPressed() {
    setState(() {
      _showResults = false;
      _showAutocomplete = false;
      _showFilterBar = true;
    });
  }

  void _onLabelClick(SearchResult babysitter) {
    setState(() {
      _searchHistory.add(babysitter.location);
      _showAutocomplete = false;
      _showResults = true;
      _searchResults = [babysitter];
    });
  }

  void _onReset() {
    setState(() {
      _searchController.clear();
      _searchResults.clear();
      _showResults = false;
      _showAutocomplete = false;
      _showFilterBar = true;
    });
  }

  void _onHistoryItemClick(String history) {
    setState(() {
      _searchController.text = history;
      _onSearchSubmit(history);
    });
  }

  void _clearSearchHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBarWidget(
            searchController: _searchController,
            onSearchChanged: _onSearchChanged,
            onSearchSubmit: () => _onSearchSubmit(_searchController.text),
            onBackPressed: _onBackPressed,
            onReset: _onReset,
          ),
          //conditionally hide widgets when searching
          if (_showFilterBar) //only show the filter bar when it's allowed
            FilterBarWidget(
              selectedFilter: _selectedFilter,
              onFilterChanged: _onFilterChanged,
            ),

          // //only show these widgets if not searching
          // if (!isSearching)
          //   MapWidget(
          //     userLocation: userLocation,
          //     babysitters: _allBabysitters,
          //   ),
          // if (!isSearching)
          //   NearbyWidget(
          //     userLocation: userLocation,
          //     babysitters: _allBabysitters,
          //   ),
          // if (!isSearching)
          //   const AllDefaultWidget(),

          Expanded(
            child: _selectedFilter == 'People'
                ? _filterWidget
                : _selectedFilter == 'Near you'
                ? _filterWidget
                : _selectedFilter == 'Map'
                ? _filterWidget
                : _showResults
                ? SearchResultsWidget(
              searchResults: _searchResults,
              onLabelClick: _onLabelClick,
              noResultsFound: _noResultsFound,
              type: 'People',
            )
                : _showAutocomplete
                ? AutocompleteWidget(
              searchResults: _searchResults,
              onLabelClick: _onLabelClick,
            )
                : _searchHistory.isEmpty
                ? const Center(child: Text('No search yet.'))
                : DefaultListWidget(
              searchHistory: _searchHistory,
              onHistoryItemClick: _onHistoryItemClick,
              onClearHistory: _clearSearchHistory,
            ),
          ),
        ],
      ),
    );
  }
}
