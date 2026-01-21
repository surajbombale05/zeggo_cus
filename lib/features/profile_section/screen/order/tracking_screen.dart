import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  // GoogleMapController? mapController;

  // final LatLng userLocation = const LatLng(19.0760, 72.8777);
  // LatLng driverLocation = const LatLng(19.1190, 72.8460);
  static const String googleApiKey = "AIzaSyA7M-sl_SgQF6xBJkglQs2K5uNdM0pxips";
  GoogleMapController? mapController;
  Timer? _timer;

  final LatLng userLocation = const LatLng(19.0760, 72.8777);
  LatLng driverLocation = const LatLng(19.1190, 72.8460);

  // static const String googleApiKey = "YOUR_VALID_API_KEY";

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  final PolylinePoints polylinePoints = PolylinePoints(apiKey: googleApiKey);

  @override
  void initState() {
    super.initState();
    _initMarkers();
    _drawRoute();
    _trackDriverLive();
  }

  void _initMarkers() {
    markers = {
      Marker(
        markerId: const MarkerId("driver"),
        position: driverLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: "Driver"),
      ),
      Marker(
        markerId: const MarkerId("user"),
        position: userLocation,
        infoWindow: const InfoWindow(title: "User"),
      ),
    };
  }

  Future<void> _drawRoute() async {
    final result = await polylinePoints.getRouteBetweenCoordinates(
      // ignore: deprecated_member_use
      request: PolylineRequest(
        origin: PointLatLng(driverLocation.latitude, driverLocation.longitude),
        destination: PointLatLng(userLocation.latitude, userLocation.longitude),
        mode: TravelMode.driving,
      ),
    );
    log("------ ${result}");
    if (!mounted || result.points.isEmpty) return;

    final points = result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
    log("------ $points");

    setState(() {
      polylines = {Polyline(polylineId: const PolylineId("route"), points: points, width: 5, color: Colors.blue)};
    });
  }

  void _trackDriverLive() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;

      setState(() {
        driverLocation = LatLng(driverLocation.latitude + 0.0005, driverLocation.longitude + 0.0005);
        log("------ $driverLocation");
        _initMarkers();
      });

      _drawRoute();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Tracking", style: TextStyle(fontSize: 13))),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: userLocation, zoom: 14),
        markers: markers,
        polylines: polylines,
        myLocationEnabled: true,
        onMapCreated: (controller) => mapController = controller,
      ),
    );
  }
}
