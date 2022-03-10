import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/data/models/location_model.dart';
import 'package:food_store/data/repositories/all_repos.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'location_event.dart';
part 'location_state.dart';

/// This bloc is responsible for displaying data in location_details_screen
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final PlacesRepository _placesRepository;
  final GeoRepository _geoRepository;
  final UserRepository _userRepository;

  LocationBloc(
    PlacesRepository placesRepository,
    GeoRepository geoRepository,
    UserRepository userRepository,
  )   : _placesRepository = placesRepository,
        _geoRepository = geoRepository,
        _userRepository = userRepository,
        super(const LocationState()) {
    on<SuggestionSubmitted>(_onSuggestionSubmitted);
    on<GeolocationRequested>(_onGeolocationRequested);
    on<LocationConfirmed>(_onLocationConfirmed);
    on<LocationUpdated>(_onLocationUpdated);
  }

  void _onSuggestionSubmitted(
      SuggestionSubmitted event, Emitter<LocationState> emit) async {
    emit(const LocationState(status: LocationStatus.loading));
    final place = await _placesRepository.getDetailsById(event.placeId);

    Location location = Location(
      streetNumber: place.streetNumber ?? "",
      route: place.route ?? "",
      locality: place.locality ?? "",
      postalCode: place.postalCode ?? "",
      lat: place.lat ?? 0,
      lng: place.lng ?? 0,
    );

    // If the user chose a street suggestion without number, the details api
    // won't return streeNumber and postalCode. In this scenario, partiallyLoaded
    // will be emitted for the user to enter streetNumber at location_details screen
    if (place.streetNumber == null) {
      emit(LocationState(
        status: LocationStatus.partiallyLoaded,
        location: location,
      ));
    } else {
      emit(LocationState(
          status: LocationStatus.fullyLoaded, location: location));
    }
  }

  void _onGeolocationRequested(
      GeolocationRequested event, Emitter<LocationState> emit) async {
    print("GeolocationRequested fired");
    try {
      Position pos = await _geoRepository.getCurrentLocation();
      List<String> address = await _geoRepository.getAddressFromCordinates(
          pos.latitude, pos.longitude);
      await Future.delayed(const Duration(seconds: 1)); // temp
      emit(LocationState(
          status: LocationStatus.fullyLoaded,
          location: Location(
            streetNumber: address[1],
            route: address[0],
            locality: address[2],
            postalCode: address[3],
            lat: pos.latitude,
            lng: pos.longitude,
          )));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _onLocationConfirmed(
      LocationConfirmed event, Emitter<LocationState> emit) async {
    print("LocationConfirmed fired");
    try {
      //await _authRepository.getAuthStateChanges().last;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("pref_location", jsonEncode(event.location));
      await _userRepository.postLocationData(event.location);
    } catch (e) {
      print(e);
    }
  }

  void _onLocationUpdated(
      LocationUpdated event, Emitter<LocationState> emit) async {
    print("LocationUpdated fired");
    emit(const LocationState(status: LocationStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await _geoRepository.getLocationFromAddress(
          "${event.location.route}, ${event.location.streetNumber}, ${event.location.locality}");

      final address = await _geoRepository.getAddressFromCordinates(
          result.latitude, result.longitude);

      emit(LocationState(
        status: LocationStatus.fullyLoaded,
        location: event.location.copyWith(
          postalCode: address[3],
          lat: result.latitude,
          lng: result.longitude,
        ),
      ));
    } catch (e) {
      print("Error $e");
    }
  }
}
