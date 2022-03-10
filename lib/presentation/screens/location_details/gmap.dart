import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gmap extends StatelessWidget {
  final double lat;
  final double lng;
  const Gmap({
    Key? key,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 260,
        child: AbsorbPointer(
          child: GoogleMap(
            zoomControlsEnabled: false,
            // mapType: state.status == LocationStatus.fullyLoaded
            //     ? MapType.normal
            //     : MapType.none,
            markers: <Marker>{
              Marker(
                  markerId: const MarkerId("marker"),
                  position: LatLng(lat, lng))
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, lng),
              zoom: 16,
            ),
          ),
        ));
  }
}
