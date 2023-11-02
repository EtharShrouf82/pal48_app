import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pal48/constants/constants.dart';

class MarkerIconsBody extends StatefulWidget {
  final String lat;
  final String long;
  final String title;

  const MarkerIconsBody({
    super.key,
    required this.lat,
    required this.long,
    required this.title,
  });

  @override
  State<StatefulWidget> createState() => MarkerIconsBodyState();
}

// const LatLng _kMapCenter = LatLng(33.0826, 35.2845);

class MarkerIconsBodyState extends State<MarkerIconsBody> {
  GoogleMapController? controller;
  BitmapDescriptor? _markerIcon;

  // ignore: prefer_const_constructors
  LatLng _kMapCenter = LatLng(1, 1);

  @override
  void initState() {
    _kMapCenter = LatLng(double.parse(widget.lat), double.parse(widget.long));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return SliverPadding(
      padding: const EdgeInsets.all(defaultPadding),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          width: double.infinity,
          height: 200.0,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _kMapCenter,
              zoom: 9,
            ),
            markers: <Marker>{_createMarker()},
            onMapCreated: _onMapCreated,
          ),
        ),
      ),
    );
  }

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: _kMapCenter,
        icon: _markerIcon!,
        infoWindow: InfoWindow(
          title: widget.title,
          snippet: '',
          onTap: () {},
        ),
      );
    } else {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: _kMapCenter,
        infoWindow: const InfoWindow(
          title: '',
          snippet: '',
        ),
      );
    }
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size.square(48));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/red_square.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }
}
