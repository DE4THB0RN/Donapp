import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapSample extends StatefulWidget {
  final double height;
  final double width;
  final GlobalKey<MapSampleState>? key;

  const MapSample({this.key, this.height = 450, this.width = 450})
      : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<LatLng?> getLatLngFromAddress(String address, String apiKey) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      } else {
        print('Geocoding failed: ${data['status']}');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }

    return null; // Retorna null se não encontrar
  }

  Future<void> moveToAddress(String address) async {
    const apiKey = 'AIzaSyAOVYRIgupAurZup5y1PRh8Ismb1A3lLao';
    final LatLng? target = await getLatLngFromAddress(address, apiKey);

    if (target != null) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(target));
    } else {
      print('Endereço não encontrado.');
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            zoomGesturesEnabled: true, // Habilitar zoom com pinça
            scrollGesturesEnabled: true, // Habilitar movimentação com toque
            rotateGesturesEnabled: true, // Habilitar rotação com dois dedos
            tiltGesturesEnabled: true, // Habilitar inclinação
          ),
          // Positioned(
          //   bottom: 16,
          //   right: 16,
          //   child: FloatingActionButton(
          //     onPressed: _goToTheLake,
          //     child: const Icon(Icons.directions_boat),
          //   ),
          // ),
        ],
      ),
    );
  }
}
