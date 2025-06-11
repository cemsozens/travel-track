import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/country_model.dart';

class TravelProvider extends ChangeNotifier {
  final List<CountryModel> _visitedCountries = [];
  final List<CountryModel> _wishlistCountries = [];
  
  List<CountryModel> get visitedCountries => _visitedCountries;
  List<CountryModel> get wishlistCountries => _wishlistCountries;
  
  int get visitedCount => _visitedCountries.length;
  int get wishlistCount => _wishlistCountries.length;
  
  TravelProvider() {
    _loadData();
  }
  
  void toggleCountryVisited(String countryCode, String countryName) {
    final country = CountryModel(
      code: countryCode,
      name: countryName,
      visitedDate: DateTime.now(),
    );
    
    final index = _visitedCountries.indexWhere((c) => c.code == countryCode);
    
    if (index != -1) {
      _visitedCountries.removeAt(index);
    } else {
      _visitedCountries.add(country);
      // Remove from wishlist if added to visited
      _wishlistCountries.removeWhere((c) => c.code == countryCode);
    }
    
    _saveData();
    notifyListeners();
  }
  
  void toggleCountryWishlist(String countryCode, String countryName) {
    final country = CountryModel(
      code: countryCode,
      name: countryName,
      visitedDate: null,
    );
    
    final index = _wishlistCountries.indexWhere((c) => c.code == countryCode);
    
    if (index != -1) {
      _wishlistCountries.removeAt(index);
    } else {
      // Don't add to wishlist if already visited
      if (!_visitedCountries.any((c) => c.code == countryCode)) {
        _wishlistCountries.add(country);
      }
    }
    
    _saveData();
    notifyListeners();
  }
  
  bool isCountryVisited(String countryCode) {
    return _visitedCountries.any((c) => c.code == countryCode);
  }
  
  bool isCountryInWishlist(String countryCode) {
    return _wishlistCountries.any((c) => c.code == countryCode);
  }
  
  Color getCountryColor(String countryCode) {
    if (isCountryVisited(countryCode)) {
      return Colors.green.shade400;
    } else if (isCountryInWishlist(countryCode)) {
      return Colors.orange.shade400;
    } else {
      return Colors.grey.shade300;
    }
  }
  
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load visited countries
    final visitedData = prefs.getStringList('visited_countries') ?? [];
    _visitedCountries.clear();
    for (final data in visitedData) {
      final parts = data.split('|');
      if (parts.length >= 2) {
        _visitedCountries.add(CountryModel(
          code: parts[0],
          name: parts[1],
          visitedDate: parts.length > 2 ? DateTime.tryParse(parts[2]) : null,
        ));
      }
    }
    
    // Load wishlist countries
    final wishlistData = prefs.getStringList('wishlist_countries') ?? [];
    _wishlistCountries.clear();
    for (final data in wishlistData) {
      final parts = data.split('|');
      if (parts.length >= 2) {
        _wishlistCountries.add(CountryModel(
          code: parts[0],
          name: parts[1],
          visitedDate: null,
        ));
      }
    }
    
    notifyListeners();
  }
  
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Save visited countries
    final visitedData = _visitedCountries.map((c) => 
      '${c.code}|${c.name}|${c.visitedDate?.toIso8601String() ?? ''}').toList();
    await prefs.setStringList('visited_countries', visitedData);
    
    // Save wishlist countries
    final wishlistData = _wishlistCountries.map((c) => 
      '${c.code}|${c.name}|').toList();
    await prefs.setStringList('wishlist_countries', wishlistData);
  }
} 