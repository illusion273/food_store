import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/data/models/location_model.dart';
import 'package:food_store/logic/blocs/app/app_bloc.dart';
import 'package:food_store/logic/blocs/location/location_bloc.dart';
import 'package:food_store/presentation/config/constants.dart';
import 'package:go_router/go_router.dart';

import 'gmap.dart';

const double innerPad = 10;

class LocationDetailsScreen extends StatelessWidget {
  final Location location;

  final TextEditingController streetController;
  final TextEditingController numberController;
  final TextEditingController cityController;
  final TextEditingController postalController;
  final TextEditingController doorController;
  final TextEditingController floorController;
  final TextEditingController moreController;
  LocationDetailsScreen({Key? key, required this.location})
      : streetController = TextEditingController(text: location.route),
        numberController = TextEditingController(text: location.streetNumber),
        cityController = TextEditingController(text: location.locality),
        postalController = TextEditingController(text: location.postalCode),
        doorController = TextEditingController(text: location.doorBell),
        floorController = TextEditingController(text: location.floor),
        moreController = TextEditingController(text: location.more),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        context.go('/catalog');
        // TODO: implement listener
      },
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text("RemoveME"),
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          // ),
          extendBodyBehindAppBar: true,
          body: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Stack(children: [
              Gmap(lat: location.lat, lng: location.lng),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height - 230,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6)],
                  ),
                  child: CustomScrollView(slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(
                          left: xPadding, right: xPadding),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(
                              height:
                                  MediaQuery.of(context).viewInsets.bottom < 253
                                      ? xPadding
                                      : MediaQuery.of(context).viewPadding.top),
                          Text("Address",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: innerPad),
                          IntrinsicHeight(
                            child: Row(children: [
                              Flexible(
                                flex: 5,
                                child: TextFormField(
                                  enabled: false,
                                  controller: streetController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                      labelText: "Street name"),
                                ),
                              ),
                              const SizedBox(width: innerPad),
                              Flexible(
                                flex: 2,
                                child: BlocBuilder<LocationBloc, LocationState>(
                                    builder: (context, state) {
                                  return TextFormField(
                                    enabled: state.status ==
                                            LocationStatus.partiallyLoaded
                                        ? true
                                        : false,
                                    controller: numberController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        labelText: "Number"),
                                  );
                                }),
                              ),
                            ]),
                          ),
                          const SizedBox(height: innerPad),
                          TextFormField(
                            enabled: false,
                            controller: cityController,
                            keyboardType: TextInputType.text,
                            decoration:
                                const InputDecoration(labelText: "City"),
                          ),
                          const SizedBox(height: innerPad),
                          TextFormField(
                            enabled: false,
                            controller: postalController,
                            keyboardType: TextInputType.text,
                            decoration:
                                const InputDecoration(labelText: "Postal code"),
                          ),
                          const SizedBox(height: innerPad),
                          Text("Details",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: innerPad),
                          IntrinsicHeight(
                            child: Row(children: [
                              Flexible(
                                flex: 5,
                                child: TextFormField(
                                  controller: doorController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                      labelText: "Door bell"),
                                ),
                              ),
                              const SizedBox(width: innerPad),
                              Flexible(
                                flex: 2,
                                child: TextFormField(
                                  controller: floorController,
                                  keyboardType: TextInputType.number,
                                  decoration:
                                      const InputDecoration(labelText: "Floor"),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(height: innerPad),
                          TextFormField(
                            controller: moreController,
                            keyboardType: TextInputType.text,
                            maxLines: 3,
                            decoration: const InputDecoration(
                                labelText: "More", alignLabelWithHint: true),
                          ),
                        ]),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: xPadding),
                      sliver: SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          children: [
                            Flexible(
                              child: Container(
                                constraints:
                                    const BoxConstraints(minHeight: innerPad),
                              ),
                            ),
                            BlocBuilder<LocationBloc, LocationState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () {
                                    if (state.status ==
                                        LocationStatus.fullyLoaded) {
                                      context.read<LocationBloc>().add(
                                              LocationConfirmed(
                                                  location.copyWith(
                                            doorBell: doorController.text,
                                            floor: floorController.text,
                                            more: moreController.text,
                                          )));
                                    } else if (state.status ==
                                        LocationStatus.partiallyLoaded) {
                                      context.read<LocationBloc>().add(
                                              LocationUpdated(location.copyWith(
                                            streetNumber: numberController.text,
                                            doorBell: doorController.text,
                                            floor: floorController.text,
                                            more: moreController.text,
                                          )));
                                    }
                                  },
                                  child: Text(
                                    state.status == LocationStatus.fullyLoaded
                                        ? "Confirm"
                                        : "Update",
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(double.maxFinite, 50),
                                  ),
                                );
                              },
                            )
                            // Builder(builder: (context) {
                            //   final stateLocation =
                            //       context.watch<LocationBloc>().state;
                            //   final stateAuth = context.watch<AuthBloc>().state;

                            //   return ElevatedButton(
                            //     onPressed: () {

                            //       if (stateLocation.status ==
                            //               LocationStatus.fullyLoaded &&
                            //           stateAuth is Authenticated) {
                            //         context.read<LocationBloc>().add(
                            //               LocationConfirmed(
                            //                 stateAuth.auth,
                            //                 stateLocation.location.copyWith(
                            //                   floor: floorController.text,
                            //                   doorBell: doorController.text,
                            //                   more: moreController.text,
                            //                 ),
                            //               ),
                            //             );
                            //         showDialog(
                            //           context: context,
                            //           builder: (context) {
                            //             return const Center(
                            //                 child: CircularProgressIndicator());
                            //           },
                            //         );
                            //       } else if (stateLocation.status ==
                            //           LocationStatus.partiallyLoaded) {
                            //         context.read<LocationBloc>().add(
                            //               LocationUpdated(
                            //                 stateLocation.location.copyWith(
                            //                   streetNumber: numberController.text,
                            //                   floor: floorController.text,
                            //                   doorBell: doorController.text,
                            //                   more: moreController.text,
                            //                 ),
                            //               ),
                            //             );
                            //         showDialog(
                            //           context: context,
                            //           builder: (context) {
                            //             return const Center(
                            //                 child: CircularProgressIndicator());
                            //           },
                            //         );
                            //       }
                            //     },
                            //     child: Text(stateLocation.status ==
                            //             LocationStatus.fullyLoaded
                            //         ? "Confirm"
                            //         : "Update"),
                            //     style: ElevatedButton.styleFrom(
                            //       fixedSize: const Size(double.maxFinite, 50),
                            //     ),
                            //   );
                            // }),
                            ,
                            SizedBox(
                                height: innerPad +
                                    MediaQuery.of(context).viewPadding.bottom),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
          )),
    );
  }
}

/*class LocationDetailsScreen extends StatefulWidget {
  const LocationDetailsScreen({Key? key}) : super(key: key);

  @override
  State<LocationDetailsScreen> createState() => _LocationDetailsScreenState();
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalController = TextEditingController();
  final TextEditingController doorController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController moreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {},
      builder: (context, state) {
        streetController.text = state.location.route;
        numberController.text = state.location.streetNumber;
        cityController.text = state.location.locality;
        postalController.text = state.location.postalCode;
        doorController.text = state.location.doorBell;
        floorController.text = state.location.floor;
        moreController.text = state.location.more;

        return LocationDetailsScreenB(
          streetController: streetController,
          numberController: numberController,
          cityController: cityController,
          postalController: postalController,
          doorController: doorController,
          floorController: floorController,
          moreController: moreController,
        );
      },
    );
  }
}

class LocationDetailsScreenB extends StatelessWidget {
  const LocationDetailsScreenB({
    Key? key,
    required this.streetController,
    required this.numberController,
    required this.cityController,
    required this.postalController,
    required this.doorController,
    required this.floorController,
    required this.moreController,
  }) : super(key: key);

  final TextEditingController streetController;
  final TextEditingController numberController;
  final TextEditingController cityController;
  final TextEditingController postalController;
  final TextEditingController doorController;
  final TextEditingController floorController;
  final TextEditingController moreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(children: [
            SizedBox(
              height: 260,
              child: BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  return AbsorbPointer(
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      mapType: state.status == LocationStatus.fullyLoaded
                          ? MapType.normal
                          : MapType.none,
                      markers: <Marker>{
                        Marker(
                            markerId: const MarkerId("marker"),
                            position:
                                LatLng(state.location.lat, state.location.lng))
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(state.location.lat, state.location.lng),
                        zoom: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height - 230,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6)],
                ),
                child: CustomScrollView(slivers: [
                  SliverPadding(
                      padding: const EdgeInsets.only(
                          left: xPadding, right: xPadding),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(
                              height:
                                  MediaQuery.of(context).viewInsets.bottom < 253
                                      ? xPadding
                                      : MediaQuery.of(context).viewPadding.top),
                          Text("Address",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: innerPad),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: TextFormField(
                                    enabled: false,
                                    controller: streetController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        labelText: "Street name"),
                                  ),
                                ),
                                const SizedBox(width: innerPad),
                                Flexible(
                                  flex: 2,
                                  child:
                                      BlocBuilder<LocationBloc, LocationState>(
                                    builder: (context, state) {
                                      return TextFormField(
                                        enabled: state.status ==
                                                LocationStatus.partiallyLoaded
                                            ? true
                                            : false,
                                        controller: numberController,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            labelText: "Number"),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: innerPad),
                          TextFormField(
                            enabled: false,
                            controller: cityController,
                            keyboardType: TextInputType.text,
                            decoration:
                                const InputDecoration(labelText: "City"),
                          ),
                          const SizedBox(height: innerPad),
                          TextFormField(
                            enabled: false,
                            controller: postalController,
                            keyboardType: TextInputType.text,
                            decoration:
                                const InputDecoration(labelText: "Postal code"),
                          ),
                          const SizedBox(height: innerPad),
                          Text("Details",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: innerPad),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: TextFormField(
                                    controller: doorController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        labelText: "Door bell"),
                                  ),
                                ),
                                const SizedBox(width: innerPad),
                                Flexible(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: floorController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: "Floor"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: innerPad),
                          TextFormField(
                            controller: moreController,
                            keyboardType: TextInputType.text,
                            maxLines: 3,
                            decoration: const InputDecoration(
                                labelText: "More", alignLabelWithHint: true),
                          ),
                        ]),
                      )),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: xPadding),
                    sliver: SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          Flexible(
                              child: Container(
                                  constraints: const BoxConstraints(
                                      minHeight: innerPad))),
                          Builder(builder: (context) {
                            final stateLocation =
                                context.watch<LocationBloc>().state;
                            final stateAuth = context.watch<AuthBloc>().state;

                            return ElevatedButton(
                              onPressed: () {
                                if (stateLocation.status ==
                                        LocationStatus.fullyLoaded &&
                                    stateAuth is Authenticated) {
                                  context.read<LocationBloc>().add(
                                        LocationConfirmed(
                                          stateAuth.auth,
                                          stateLocation.location.copyWith(
                                            floor: floorController.text,
                                            doorBell: doorController.text,
                                            more: moreController.text,
                                          ),
                                        ),
                                      );
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    },
                                  );
                                } else if (stateLocation.status ==
                                    LocationStatus.partiallyLoaded) {
                                  context.read<LocationBloc>().add(
                                        LocationUpdated(
                                          stateLocation.location.copyWith(
                                            streetNumber: numberController.text,
                                            floor: floorController.text,
                                            doorBell: doorController.text,
                                            more: moreController.text,
                                          ),
                                        ),
                                      );
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    },
                                  );
                                }
                              },
                              child: Text(stateLocation.status ==
                                      LocationStatus.fullyLoaded
                                  ? "Confirm"
                                  : "Update"),
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(double.maxFinite, 50),
                              ),
                            );
                          }),
                          const SizedBox(height: innerPad),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ]),
        ));
  }
}
*/