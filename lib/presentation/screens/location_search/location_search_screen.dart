import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/logic/blocs/location/location_bloc.dart';
import 'package:food_store/logic/blocs/suggestions/suggestions_bloc.dart';
import 'package:food_store/presentation/config/constants.dart';
import 'package:go_router/go_router.dart';

class LocationSearchScreen extends StatelessWidget {
  const LocationSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state.status == LocationStatus.fullyLoaded ||
            state.status == LocationStatus.partiallyLoaded) {
          context.go('/location_search/details', extra: state.location);
        }
      },
      child: Scaffold(
        appBar: AppBar(elevation: 0),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: xPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your Address",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  context
                      .read<SuggestionsBloc>()
                      .add(SuggestionsRequested(value));
                },
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 18,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRad)),
                  hintText: 'Random Street 32, Athens, 99999',
                ),
              ),
              OutlinedButton.icon(
                onPressed: (() {
                  context.read<LocationBloc>().add(GeolocationRequested());
                  showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      });
                }),
                icon: const Icon(
                  Icons.gps_fixed_rounded,
                  size: 18,
                ),
                label: const Text("Use location services"),
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 14)),
              ),
              BlocBuilder<SuggestionsBloc, SuggestionsState>(
                builder: (_, state) {
                  if (state.status == SuggestionStatus.loaded) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          return ListTile(
                            visualDensity: const VisualDensity(vertical: -1),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            leading: const Icon(Icons.location_on),
                            title: Text(state.suggestions[i].description),
                            onTap: () {
                              context.read<LocationBloc>().add(
                                  SuggestionSubmitted(
                                      state.suggestions[i].placeId));
                            },
                          );
                        },
                        itemCount: state.suggestions.length,
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                          child: Text("Failed to get address recommendations")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
